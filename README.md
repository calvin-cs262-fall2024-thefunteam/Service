# CS 262 EventSphere Webservice

This is the data service application for the 
[CS 262 EventSphere Project](https://github.com/calvin-cs262-fall2024-thefunteam/Project),
which is deployed here:
          
- <https://eventsphere-web.azurewebsites.net/>

It has the following read data route URLs:
- `/` a hello message
- `/events` a list of events
- `/users/`to get users
- `/savedEvents` to get all SavedEvents
- `/savedEvents/{userID}` to get all saved events by a specific user

The database is relational with the schema specified in the `sql/` sub-directory
and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/).
