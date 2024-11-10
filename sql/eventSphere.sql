DROP TABLE IF EXISTS TagsList;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Account;

CREATE TABLE Account (
    ID integer PRIMARY KEY,
    Accountname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Tags (
    ID integer PRIMARY KEY,
    color VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

CREATE TABLE Events (
    ID integer PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    description TEXT NOT NULL,
    organizerID INTEGER REFERENCES Account(ID)
);

CREATE TABLE TagsList (
    ID integer PRIMARY KEY,
    eventID INTEGER REFERENCES Events(ID),
    tagID INTEGER REFERENCES Tags(ID)
);

-- Allow users to select data from the tables
GRANT SELECT ON Account TO public;
GRANT SELECT ON Events TO public;
GRANT SELECT ON Tags TO public;
GRANT SELECT ON TagsList TO public;

-- Insert Tags
INSERT INTO Tags VALUES(1, 'blue', 'Sports'); 
INSERT INTO Tags VALUES(2, 'yellow', 'Social');
INSERT INTO Tags VALUES(3, 'green', 'Student Org');
INSERT INTO Tags VALUES(4, 'red', 'Academic');
INSERT INTO Tags VALUES(5, 'purple', 'Workshop');

-- Insert Accounts
INSERT INTO Account VALUES(1, 'Account1', 'password1', 'name 1');
INSERT INTO Account VALUES(2, 'Account2', 'password2', 'name 2');
INSERT INTO Account VALUES(3, 'Account3', 'password3', 'name 3');

-- Insert Events
INSERT INTO Events VALUES(1, 'Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1);
INSERT INTO events VALUES(2, 'Sample Event 2', 'Location 2', '2021-01-02', '1:00:00', 'Description for Sample Event 2', 2);
INSERT INTO Events VALUES(3, 'Sample Event 3', 'Location 3', '2021-01-03', '2:00:00', 'Description for Sample Event 3', 3);
INSERT INTO Events VALUES(4, 'Sample Event 4', 'Location 4', '2021-01-04', '3:00:00', 'Description for Sample Event 4', 3);

-- Assign tags to events
INSERT INTO TagsList VALUES(1, 1, 1); -- assign tag 1 to event 1
INSERT INTO TagsList VALUES(2, 1, 2); -- assign tag 2 to event 1
INSERT INTO TagsList VALUES(3, 2, 1); -- assign tag 1 to event 2
INSERT INTO TagsList VALUES(4, 3, 4); -- assign tag 4 to event 3
INSERT INTO TagsList VALUES(5, 4, 3); -- assign tag 3 to event 4