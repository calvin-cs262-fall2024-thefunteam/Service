const pgp = require('pg-promise')();

const db = pgp({
  host: process.env.DB_SERVER,
  port: process.env.DB_PORT,
  database: process.env.DB_DATABASE,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: {
    rejectUnauthorized: false,
  },
});

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => res.send('Hello, CS 262 funteam service!'));
app.get('/users', readUsers);
app.get('/events', readEvents); // Simple SELECT *
app.get('/events/formatted', readEventsWithTags); // Events with nested tags
app.post('/users', createUser);
app.post('/events', createEvent);

app.listen(port, () => console.log(`Listening on port ${port}`));

function returnDataOr404(res, data) {
  if (data == null || data.length === 0) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

// Retrieve all events without formatting, just a simple SELECT *
function readEvents(req, res, next) {
  db.manyOrNone('SELECT * FROM Events')
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

// Retrieve events with tags formatted (nested tags for each event)
function readEventsWithTags(req, res, next) {
  db.any(`
    SELECT e.*, t.label AS tag_label, t.color AS tag_color
    FROM Events e
    LEFT JOIN EventsTags et ON e.ID = et.eventID
    LEFT JOIN Tags t ON et.tagID = t.ID
  `)
    .then((data) => {
      const events = {};
      data.forEach((row) => {
        if (!events[row.id]) {
          events[row.id] = {
            id: row.id,
            name: row.name,
            location: row.location,
            date: row.date,
            time: row.time,
            description: row.description,
            organizerID: row.organizerid,
            tags: [],
          };
        }
        if (row.tag_label && row.tag_color) {
          events[row.id].tags.push({
            label: row.tag_label,
            color: row.tag_color,
          });
        }
      });
      returnDataOr404(res, Object.values(events));
    })
    .catch(next);
}

// Retrieve users
function readUsers(req, res, next) {
  db.manyOrNone('SELECT * FROM Account')
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

// Create user
function createUser(req, res, next) {
  const { Accountname, password, name } = req.body;
  db.none(
    'INSERT INTO Account(Accountname, password, name) VALUES(${Accountname}, ${password}, ${name})',
    req.body
  )
    .then(() => res.status(201).send({ message: 'User created successfully.' }))
    .catch(next);
}

// Create event with tags
function createEvent(req, res, next) {
  const { name, location, date, time, description, organizerID, tags } = req.body;

  db.one(
    'INSERT INTO Events(name, location, date, time, description, organizerID) VALUES(${name}, ${location}, ${date}, ${time}, ${description}, ${organizerID}) RETURNING id',
    { name, location, date, time, description, organizerID }
  )
    .then((event) => {
      if (tags && tags.length > 0) {
        const tagQueries = tags.map((tagID) => ({
          query: 'INSERT INTO EventsTags(eventID, tagID) VALUES($1, $2)',
          values: [event.id, tagID],
        }));
        return db.tx((t) => t.batch(tagQueries.map((q) => t.none(q.query, q.values))));
      }
    })
    .then(() => res.status(201).send({ message: 'Event and tags created successfully.' }))
    .catch(next);
}
