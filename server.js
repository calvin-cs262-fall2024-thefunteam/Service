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

//Read/ Get
app.get('/users', readUsers);               // Retrieve all users
app.get('/events', readEvents);             // Retrieve all events
app.get('/events/:id/tags', readEventTags); // Retrieve tags for a single event by ID
app.get('/tags', readTags);                 // Retrieve all predefined tags
app.get('/events/:id', readEvent);          // Retrieve a single event by ID

//Create/ Post
app.post('/users', createUser);
app.post('/events', createEvent);

// Update/ Put

// Delete
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

// Retrieve users
function readUsers(req, res, next) {
  db.manyOrNone('SELECT * FROM Account')
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

// Retrieve tags
function readTags(req, res, next) {
  db.manyOrNone('SELECT * FROM Tags')
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

function readEvent(req, res, next) {
  db.oneOrNone('SELECT * FROM Events WHERE id=${id}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}


// Retrieve tags for event id 
function readEventTags(req, res, next) {
  const eventID = parseInt(req.params.id);
  db.manyOrNone('SELECT tagID FROM EventsTags WHERE eventID = $1', eventID)
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
