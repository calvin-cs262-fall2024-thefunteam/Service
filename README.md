# CS 262 EventSphere Webservice

This is the data service application for the 
[CS 262 EventSphere Project](https://github.com/calvin-cs262-fall2024-thefunteam/Project),
which is deployed here:
          
- <https://eventsphere-web.azurewebsites.net/>

## Endpoints

### General
- `/` - A hello message.

### Users
- `GET /users` - Retrieve all users.
- `GET /users/:Accountname/:password` - Login with account name and password.
- `POST /users` - Create a new user.
- `PUT /users/:Accountname/password` - Change password for a user.
- `PUT /users/:Accountname/name` - Change name for a user.
- `PUT /users/:Accountname/accountname` - Change account name for a user.
- `DELETE /users/:accountID` - Delete a user by account ID.

### Events
- `GET /events` - Retrieve all events.
- `GET /events/:id` - Retrieve an event by ID.
- `POST /events` - Create a new event.
- `PUT /events/:id` - Update an event by ID.
- `DELETE /events/:id` - Delete an event by ID.
- `GET /eventsbyuser/:organizerID` - Retrieve all events for a user by organizer ID.

### Saved Events
- `GET /savedEvents` - Retrieve all saved events.
- `GET /savedEvents/:accountID` - Retrieve all saved events for a user by account ID.
- `POST /savedEvents` - Save an event.
- `DELETE /savedEvents/:accountID/:eventID` - Unsave an event by account ID and event ID.

## Database

The database is relational with the schema specified in the `sql/` sub-directory and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/).
