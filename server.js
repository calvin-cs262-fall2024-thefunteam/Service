/**
 * @file server.js
 * @description This file contains the server-side logic for the EventSphere web service.
 */

const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.get("/", (req, res) => res.send("Hello, CS 262 funteam service!"));

// Read/ Get
/**
 * Retrieve all users.
 * @name GET /users
 */
app.get("/users", readUsers);

/**
 * Retrieve all events.
 * @name GET /events
 */
app.get("/events", readEvents);

/**
 * Retrieve event by ID.
 * @name GET /events/:id
 * @param {string} id - The ID of the event.
 */
app.get("/events/:id", readEvent);

/**
 * Login with account name and password.
 * @name GET /users/:Accountname/:password
 * @param {string} Accountname - The account name of the user.
 * @param {string} password - The password of the user.
 */
app.get("/users/:Accountname/:password", login);

/**
 * Retrieve all saved events.
 * @name GET /savedEvents
 */
app.get("/savedEvents", readSavedEvents);

/**
 * Retrieve all events for a user by organizer ID.
 * @name GET /eventsbyuser/:organizerID
 * @param {string} organizerID - The ID of the organizer.
 */
app.get("/eventsbyuser/:organizerID", getEventsByOrganizerID);

/**
 * Retrieve all saved events for a user by account ID.
 * @name GET /savedEvents/:accountID
 * @param {string} accountID - The ID of the account.
 */
app.get("/savedEvents/:accountID", getSavedEventsByAccountID);

// Create/ Post
/**
 * Create a new user.
 * @name POST /users
 */
app.post("/users", createUser);

/**
 * Create a new event.
 * @name POST /events
 */
app.post("/events", createEvent);

/**
 * Save an event.
 * @name POST /savedEvents
 */
app.post("/savedEvents", saveEvent);

// Update/ Put
/**
 * Update a single event by ID.
 * @name PUT /events/:id
 * @param {string} id - The ID of the event.
 */
app.put("/events/:id", editEvent);

/**
 * Change password for a user.
 * @name PUT /users/:Accountname/password
 * @param {string} Accountname - The account name of the user.
 */
app.put("/users/:Accountname/password", changePassword);

/**
 * Change name for a user.
 * @name PUT /users/:Accountname/name
 * @param {string} Accountname - The account name of the user.
 */
app.put("/users/:Accountname/name", changeName);

/**
 * Change account name for a user.
 * @name PUT /users/:Accountname/accountname
 * @param {string} Accountname - The account name of the user.
 */
app.put("/users/:Accountname/accountname", changeAccountname);

// Delete
/**
 * Delete a single event by ID.
 * @name DELETE /events/:id
 * @param {string} id - The ID of the event.
 */
app.delete("/events/:id", deleteEvent);

/**
 * Delete a single user by ID.
 * @name DELETE /users/:accountID
 * @param {string} accountID - The ID of the account.
 */
app.delete("/users/:accountID", deleteUser);

/**
 * Unsave an event by account ID and event ID.
 * @name DELETE /savedEvents/:accountID/:eventID
 * @param {string} accountID - The ID of the account.
 * @param {string} eventID - The ID of the event.
 */
app.delete("/savedEvents/:accountID/:eventID", deleteSavedEvent);

app.listen(port, () => console.log(`Listening on port ${port}`));

/**
 * Sends a 404 status if data is null or empty, otherwise sends the data.
 *
 * @param {Object} res - The response object.
 * @param {Array|Object} data - The data to send.
 */
function returnDataOr404(res, data) {
  if (data == null || data.length === 0) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

/**
 * Retrieves all users from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function readUsers(req, res, next) {
  db.manyOrNone("SELECT * FROM Account")
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Retrieves all events from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function readEvents(req, res, next) {
  db.manyOrNone("SELECT * FROM Events")
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Retrieves a single event by ID from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function readEvent(req, res, next) {
  db.oneOrNone("SELECT * FROM Events WHERE id=${id}", req.params)
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Logs in a user by account name and password.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function login(req, res, next) {
  db.oneOrNone("SELECT * FROM Account WHERE Accountname=${Accountname} AND password=${password}", req.params)
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Retrieves all saved events from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function readSavedEvents(req, res, next) {
  db.manyOrNone("SELECT * FROM SavedEvents")
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Retrieves all events for a user by organizer ID from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function getEventsByOrganizerID(req, res, next) {
  db.manyOrNone("SELECT * FROM Events WHERE organizerID=${organizerID}", req.params)
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Retrieves all saved events for a user by account ID from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function getSavedEventsByAccountID(req, res, next) {
  db.manyOrNone("SELECT * FROM SavedEvents WHERE accountID=${accountID}", req.params)
    .then((data) => returnDataOr404(res, data))
    .catch(next);
}

/**
 * Creates a new user in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing user details.
 * @param {string} req.body.Accountname - The account name of the user.
 * @param {string} req.body.password - The password of the user.
 * @param {string} req.body.name - The name of the user.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function createUser(req, res, next) {
  db.none("INSERT INTO Account(Accountname, password, name) VALUES(${Accountname}, ${password}, ${name})", req.body)
    .then(() => res.status(201).send({ message: "User created successfully." }))
    .catch(next);
}

/**
 * Creates a new event in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing event details.
 * @param {string} req.body.name - The name of the event.
 * @param {string} req.body.location - The location of the event.
 * @param {string} req.body.organizer - The organizer of the event.
 * @param {string} req.body.date - The date of the event.
 * @param {string} req.body.description - The description of the event.
 * @param {number} req.body.organizerid - The ID of the organizer.
 * @param {Array<string>} req.body.tagsArray - An array of tags associated with the event.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function createEvent(req, res, next) {
  db.none(
    "INSERT INTO Events(name, location, organizer, date, description, organizerid, tagsArray) VALUES(${name}, ${location}, ${organizer}, ${date}, ${description}, ${organizerid}, ${tagsArray})", req.body)
    .then(() => {
      res.status(201).send({ message: "Event created successfully." });
    })
    .catch(next);
}

/**
 * Saves an event for a user in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing saved event details.
 * @param {number} req.body.accountID - The ID of the account.
 * @param {number} req.body.eventID - The ID of the event.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function saveEvent(req, res, next) {
  db.none("INSERT INTO SavedEvents(accountID, eventID) VALUES(${accountID}, ${eventID})", req.body)
    .then(() => res.status(201).send({ message: "Event saved successfully." }))
    .catch(next);
}

/**
 * Updates an existing event in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing updated event details.
 * @param {number} req.body.id - The ID of the event to update.
 * @param {string} req.body.name - The name of the event.
 * @param {string} req.body.location - The location of the event.
 * @param {string} req.body.organizer - The organizer of the event.
 * @param {string} req.body.date - The date of the event.
 * @param {string} req.body.description - The description of the event.
 * @param {number} req.body.organizerid - The ID of the organizer.
 * @param {Array<string>} req.body.tagsArray - An array of tags associated with the event.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function editEvent(req, res, next) {
  db.none(
    "UPDATE Events SET name=${name}, location=${location}, organizer=${organizer}, date=${date}, description=${description}, organizerid=${organizerid}, tagsArray=${tagsArray} WHERE id=${id}",
    req.body
  )
    .then(() => res.status(200).send({ message: "Event updated successfully." }))
    .catch(next);
}

/**
 * Deletes an event from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.params - The parameters of the request.
 * @param {number} req.params.id - The ID of the event to delete.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function deleteEvent(req, res, next) {
  db.none("DELETE FROM Events WHERE id=${id}", req.params)
    .then(() => res.status(200).send({ message: "Event deleted successfully." }))
    .catch(next);
}

/**
 * Deletes a user from the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.params - The parameters of the request.
 * @param {number} req.params.accountID - The ID of the account to delete.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function deleteUser(req, res, next) {
  db.none("DELETE FROM Account WHERE id=${accountID}", req.params)
    .then(() => res.status(200).send({ message: "User deleted successfully." }))
    .catch(next);
}

/**
 * Unsaves an event for a user in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.params - The parameters of the request.
 * @param {number} req.params.accountID - The ID of the account.
 * @param {number} req.params.eventID - The ID of the event.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function deleteSavedEvent(req, res, next) {
  db.none("DELETE FROM SavedEvents WHERE accountID=${accountID} AND eventID=${eventID}", req.params)
    .then(() => res.status(200).send({ message: "Event unsaved successfully." }))
    .catch(next);
}

/**
 * Changes the password for a user in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing the new password.
 * @param {string} req.body.password - The new password.
 * @param {Object} req.params - The parameters of the request.
 * @param {string} req.params.Accountname - The account name of the user.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function changePassword(req, res, next) {
  db.none("UPDATE Account SET password=${password} WHERE Accountname=${Accountname}", req.body)
    .then(() => res.status(200).send({ message: "Password changed successfully." }))
    .catch(next);
}

/**
 * Changes the name for a user in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing the new name.
 * @param {string} req.body.name - The new name.
 * @param {Object} req.params - The parameters of the request.
 * @param {string} req.params.Accountname - The account name of the user.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function changeName(req, res, next) {
  db.none("UPDATE Account SET name=${name} WHERE Accountname=${Accountname}", req.body)
    .then(() => res.status(200).send({ message: "Name changed successfully." }))
    .catch(next);
}

/**
 * Changes the account name for a user in the database.
 *
 * @param {Object} req - The request object.
 * @param {Object} req.body - The body of the request containing the new account name.
 * @param {string} req.body.Accountname - The new account name.
 * @param {Object} req.params - The parameters of the request.
 * @param {string} req.params.Accountname - The current account name of the user.
 * @param {Object} res - The response object.
 * @param {Function} next - The next middleware function.
 */
function changeAccountname(req, res, next) {
  db.none("UPDATE Account SET Accountname=${Accountname} WHERE Accountname=${Accountname}", req.body)
    .then(() => res.status(200).send({ message: "Account name changed successfully." }))
    .catch(next);
}