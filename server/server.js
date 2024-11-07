
const pgp = require('pg-promise')();
const dotenv = require('dotenv');
dotenv.config();


const db = pgp({
  host: process.env.DB_SERVER,
  port: process.env.DB_PORT,
  database: process.env.DB_DATABASE,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Configure the server and its routes.

const express = require('express');

const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

app.use(router);
app.listen(port, () => console.log(`Listening on port ${port}`));

router.post('/users', createUser);
router.post('/events', createEvent);

// Implement the CRUD operations.

function returnDataOr404(res, data) {
  if (data == null) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

  function createUser(req, res, next) {
    const { username, password, name, eventID } = req.body;
    db.none('INSERT INTO User(username, password, name, eventID) VALUES(${username}, ${password}, ${name}, ${eventID})', req.body)
      .then((data) => {
        res.send(data);
      })
      .catch((err) => {
        next(err);
      });
  }

  function createEvent(req, res, next) {
    const { name, location, date, time, description, organizerID, tagsID } = req.body;
    db.none('INSERT INTO Events(name, location, date, time, description, organizerID, tagsID) VALUES(${name}, ${location}, ${date}, ${time}, ${description}, ${organizerID}, ${tagsID})', req.body)
      .then(() => {
        res.send(data);
      })
      .catch((err) => {
        next(err);
      });
  }