DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Community;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS TagsList;
DROP TABLE IF EXISTS Tags;

CREATE TABLE User (
    ID SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    eventID INTEGER
);

CREATE TABLE Events (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    description TEXT NOT NULL,
    organizerID INTEGER REFERENCES User(ID),
    tagsID INTEGER REFERENCES Tags(ID)
);

CREATE TABLE Tags (
    ID SERIAL PRIMARY KEY,
    color VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL
);

CREATE TABLE TagsList (
    ID SERIAL PRIMARY KEY,
    eventID INTEGER REFERENCES Events(ID),
    tagID INTEGER REFERENCES Tags(ID)
);

GRANT SELECT ON User TO public;
GRANT SELECT ON Events TO public;

INSERT INTO Events(name, location, date, time, description, organizerID, tagsID) VALUES('Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1, 1);
INSERT INTO Events(name, location, date, time, description, organizerID, tagsID) VALUES('Sample Event 2', 'Location 2', '2021-01-02', '1:00:00', 'Description for Sample Event 2', 2, 2);
INSERT INTO Events(name, location, date, time, description, organizerID, tagsID) VALUES('Sample Event 3', 'Location 3', '2021-01-03', '2:00:00', 'Description for Sample Event 3', 3, 3);
INSERT INTO Events(name, location, date, time, description, organizerID, tagsID) VALUES('Sample Event 4', 'Location 4', '2021-01-04', '3:00:00', 'Description for Sample Event that is really long so that i can test out the length feature of the erendneiorjasofjnasojnf aslkfjasl fjasl;fj sal;kfj sal;kfjsa;lfjas;lk fjsa;lfjaslfjas;kfjsalkfjslkf jas;l jasof', 4, 4);

-- Insert tags
INSERT INTO Tags(color, label) VALUES('blue', 'Sports'); 
INSERT INTO Tags(color, label) VALUES('yellow', 'Social');
INSERT INTO Tags(color, label) VALUES('green', 'Student Org');
INSERT INTO Tags(color, label) VALUES('red', 'Academic');
INSERT INTO Tags(color, label) VALUES('purple', 'Workshop');

-- Insert users
INSERT INTO User(username, password, name, eventID) VALUES('user1', 'password1', 'User 1', 1);
INSERT INTO User(username, password, name, eventID) VALUES('user2', 'password2', 'User 2', 2);
INSERT INTO User(username, password, name, eventID) VALUES('user3', 'password3', 'User 3', 3);

-- Assign tags to events
INSERT INTO TagsList(eventID, tagID) VALUES(1, 1); -- assign tag 1 to event 1
INSERT INTO TagsList(eventID, tagID) VALUES(1, 2); -- assign tag 2 to event 1
INSERT INTO TagsList(eventID, tagID) VALUES(2, 1); -- assign tag 1 to event 2
INSERT INTO TagsList(eventID, tagID) VALUES(3, 4); -- assign tag 4 to event 3
INSERT INTO TagsList(eventID, tagID) VALUES(4, 3); -- assign tag 3 to event 4




