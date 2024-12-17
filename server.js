const pgp = require("pg-promise")();

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

const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.get("/", (req, res) => res.send("Hello, CS 262 funteam service!"));

//Read/ Get
app.get("/users", readUsers); // Retrieve all users
app.get("/events", readEvents); // Retrieve all events
app.get("/events/:id", readEvent); // Retrieve event by ID
app.get("/users/:Accountname/:password", login); // Login
app.get("/savedEvents", readSavedEvents); // Retrieve all saved events

app.get("/eventsbyuser/:organizerID", getEventsByOrganizerID); // Retrieve all events for a user
app.get("/savedEvents/:accountID", getSavedEventsByAccountID ); // Retrieve all saved events for a user

//Create/ Post
app.post("/users", createUser); // Create a new user
app.post("/events", createEvent); // Create a new event
app.post("/users", createUser); // Create a new user
app.post("/savedEvents", saveEvent); // Save an event

// Update/ Put
app.put("/events/:id", editEvent); // Update a single event by ID
app.put("/users/:Accountname/password", changePassword); // Change password
app.put("/users/:Accountname/name", changeName); // Change name
app.put("/users/:Accountname/accountname", changeAccountname); // Change accountname

// Delete
app.delete("/events/:id", deleteEvent); // Delete a single event by ID
app.delete("/users/:accountID", deleteUser); // Delete a single user by ID
app.delete("/savedEvents/:accountID/:eventID", deleteSavedEvent); // Unsave an event


app.listen(port, () => console.log(`Listening on port ${port}`));

function returnDataOr404(res, data) {
  if (data == null || data.length === 0) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

// Event Functions
function readEvents(req, res, next) {
  db.manyOrNone("SELECT * FROM Events")
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

function readEvent(req, res, next) {
  db.oneOrNone("SELECT * FROM Events WHERE id=${id}", req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function createEvent(req, res, next) {
  db.none(
    "INSERT INTO Events(name, location, organizer, date, description, organizerid, tagsArray) VALUES(${name}, ${location}, ${organizer}, ${date}, ${description}, ${organizerid}, ${tagsArray})",req.body)
    .then(() => {
      res.status(201).send({ message: "Event created successfully." });
    })
    .catch(next);
}

function deleteEvent(req, res, next) {
  db.none("DELETE FROM Events WHERE id=${id}", req.params)
    .then(() => res.status(200).send({ message: "Event deleted successfully." }))
    .catch(next);
}

function editEvent(req, res, next) {
  db.none(
    "UPDATE Events SET name=${name}, location=${location}, organizer=${organizer}, date=${date}, description=${description}, organizerid=${organizerid}, tagsArray=${tagsArray} WHERE id=${id}",
    req.body
  )
    .then(() => res.status(200).send({ message: "Event updated successfully." }))
    .catch(next);
}

// Users Functions
function readUsers(req, res, next) {
  db.manyOrNone("SELECT * FROM Account")
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

function login(req, res, next) {
  db.oneOrNone("SELECT * FROM Account WHERE Accountname=${Accountname} AND password=${password}", req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function changePassword(req, res, next) {
  db.none("UPDATE Account SET password=${password} WHERE Accountname=${Accountname}", req.body)
    .then(() => res.status(200).send({ message: "Password changed successfully." }))
    .catch(next);
}

function changeName(req, res, next) {
  db.none("UPDATE Account SET name=${name} WHERE Accountname=${Accountname}", req.body)
    .then(() => res.status(200).send({ message: "Name changed successfully." }))
    .catch(next);
}

function changeAccountname(req, res, next) {
  db.none("UPDATE Account SET Accountname=${newAccountname} WHERE Accountname=${Accountname}", req.body)
    .then(() => res.status(200).send({ message: "Accountname changed successfully." }))
    .catch(next);
}

function deleteUser(req, res, next) {
  db.none("DELETE FROM Account WHERE accountID=${accountID}", req.params)
    .then(() => res.status(200).send({ message: "User deleted successfully." }))
    .catch(next);
}

// Create user
function createUser(req, res, next) {
  db.none(
    "INSERT INTO Account(Accountname, password, name, salt) VALUES(${Accountname}, ${password}, ${name}, ${salt})",
    req.body
  )
    .then(() => res.status(201).send({ message: "User created successfully." }))
    .catch(next);
}

// Save Events
function saveEvent(req, res, next) {
  db.none(
    "INSERT INTO SavedEvents(accountID, eventID) VALUES(${accountID}, ${eventID})",
    req.body
  )
    .then(() => res.status(201).send({ message: "Event saved successfully." }))
    .catch(next);
}

function readSavedEvents(req, res, next) {
  db.manyOrNone("SELECT * FROM SavedEvents")
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

function getEventsByOrganizerID(req, res, next) {
  const { organizerID } = req.params;

  db.manyOrNone("SELECT * FROM Events WHERE organizerID = $1", [organizerID])
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

function getSavedEventsByAccountID(req, res, next) {
  const { accountID } = req.params;
  const query = `
    SELECT e.* 
    FROM SavedEvents s
    INNER JOIN Events e ON s.eventID = e.id
    WHERE s.accountID = $1
  `;
  db.manyOrNone(query, [accountID])
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

function deleteSavedEvent(req, res, next) {
  db.none("DELETE FROM SavedEvents WHERE accountID=${accountID} AND eventID=${eventID}", req.params)
    .then(() => res.status(200).send({ message: "Event unsaved successfully." }))
    .catch(next);
}

