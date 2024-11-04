
DROP Table IF EXISTS User;
DROP Table IF EXISTS Community;
DROP Table IF EXISTS Events;

CREATE Table Events(
    ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    description TEXT NOT NULL,
    organizerID integer REFERENCES User(ID), -- Foreign Key
    -- attendess NUMBER NOT NULL,
    tagsID integer REFERENCES Tags(ID), -- Foreign Key
)

CREATE Table TagsList(
    ID SERIAL PRIMARY KEY,
    tagsID integer REFERENCES Tags(ID), -- Foreign Key
)

CREATE Table Tags(
    ID SERIAL PRIMARY KEY,
    color VARCHAR(255) NOT NULL,
    label VARCHAR(255) NOT NULL,
)

CREATE Table User(
    ID SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    pasword VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    eventID integer REFERENCES Events(ID), -- Foreign Key
    -- communityID integer REFERENCES Community(ID), -- Foreign Key
)

-- CREATE Table Communities(
--     ID SERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     ownerID integer REFERENCES User(ID), -- Foreign Key
-- )

-- CREATE CommunityMembers(
--     ID SERIAL PRIMARY KEY,
--     userID integer REFERENCES User(ID), -- Foreign Key
    
--     CommunityID integer REFERENCES Community(ID), -- Foreign Key
-- )

-- CREATE CommunityDetails(
--     ID SERIAL PRIMARY KEY,
--     communityID integer REFERENCES Community(ID), -- Foreign Key

--     events NUMBER NOT NULL,)




GRANT SELECT ON User TO public;
GRANT SELECT ON Events TO public;

INSERT INTO EVENTS(name, location, date, time, description, organizerID, TagsList) VALUES('Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1, 1);
INSERT INTO EVENTS(name, location, date, time, description, organizerID, TagsList) VALUES('Sample Event 2', 'Location 2', '2021-01-02', '1:00:00', 'Description for Sample Event 2', 2, 2);
INSERT INTO EVENTS(name, location, date, time, description, organizerID, TagsList) VALUES('Sample Event 3', 'Location 3', '2021-01-03', '2:00:00', 'Description for Sample Event 3', 3, 3);
INSERT INTO EVENTS(name, location, date, time, description, organizerID, TagsList) VALUES('Sample Event 4', 'Location 4', '2021-01-04', '3:00:00', 'Description for Sample Event that is really long so that i can test out the length feature of the erendneiorjasofjnasojnf aslkfjasl fjasl;fj sal;kfj sal;kfjsa;lfjas;lk fjsa;lfjaslfjas;kfjsalkfjslkf jas;l jasof', 4, 4);

INSERT INTO Tags(color, label) VALUES('blue', 'Sports');
INSERT INTO Tags(color, label) VALUES('yellow', 'Social');
INSERT INTO Tags(color, label) VALUES('green', 'Student Org');
INSERT INTO Tags(color, label) VALUES('red', 'Academic');
INSERT INTO Tags(color, label) VALUES('purple', 'Workshop');

INSERT INTO User(username, password, name, eventID) VALUES('user1', 'password1', 'User 1', 1);
INSERT INTO User(username, password, name, eventID) VALUES('user2', 'password2', 'User 2', 2);
INSERT INTO User(username, password, name, eventID) VALUES('user3', 'password3', 'User 3', 3);




