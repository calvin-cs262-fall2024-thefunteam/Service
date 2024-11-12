-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS EventsTags;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Account;

-- Create Account table
CREATE TABLE Account (
    ID SERIAL PRIMARY KEY,
    Accountname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

-- Create Tags table
CREATE TABLE Tags (
    ID SERIAL PRIMARY KEY,
    color VARCHAR(7) NOT NULL,  -- For hex color codes
    label VARCHAR(255) NOT NULL
);

-- Create Events table
CREATE TABLE Events (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    description TEXT NOT NULL,
    organizerID INTEGER REFERENCES Account(ID)
);

-- Create EventsTags join table to link Events and Tags in a many-to-many relationship
CREATE TABLE EventsTags (
    eventID INTEGER REFERENCES Events(ID) ON DELETE CASCADE,
    tagID INTEGER REFERENCES Tags(ID) ON DELETE CASCADE,
    PRIMARY KEY (eventID, tagID)
);

-- Grant select permissions on all tables to public
GRANT SELECT ON Account TO public;
GRANT SELECT ON Events TO public;
GRANT SELECT ON Tags TO public;
GRANT SELECT ON EventsTags TO public;

-- Insert sample Accounts
INSERT INTO Account (Accountname, password, name) VALUES ('Account1', 'password1', 'name 1');
INSERT INTO Account (Accountname, password, name) VALUES ('Account2', 'password2', 'name 2');
INSERT INTO Account (Accountname, password, name) VALUES ('Account3', 'password3', 'name 3');

-- Insert sample Tags
INSERT INTO Tags (color, label) VALUES ('#FFD700', 'Social');
INSERT INTO Tags (color, label) VALUES ('#32CD32', 'Networking');
INSERT INTO Tags (color, label) VALUES ('#FF6347', 'Workshop');

-- Insert sample Events
INSERT INTO Events (name, location, date, time, description, organizerID) VALUES
('Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1),
('Sample Event 2', 'Location 2', '2021-01-02', '13:00:00', 'Description for Sample Event 2', 2),
('Sample Event 3', 'Location 3', '2021-01-03', '14:00:00', 'Description for Sample Event 3', 3),
('Sample Event 4', 'Location 4', '2021-01-04', '15:00:00', 'Description for Sample Event 4', 3);

-- Associate Events with Tags in the EventsTags join table
INSERT INTO EventsTags (eventID, tagID) VALUES (1, 1);  -- Sample Event 1 with Social tag
INSERT INTO EventsTags (eventID, tagID) VALUES (1, 2);  -- Sample Event 1 with Networking tag
INSERT INTO EventsTags (eventID, tagID) VALUES (2, 1);  -- Sample Event 2 with Social tag
INSERT INTO EventsTags (eventID, tagID) VALUES (3, 3);  -- Sample Event 3 with Workshop tag
INSERT INTO EventsTags (eventID, tagID) VALUES (4, 2);  -- Sample Event 4 with Networking tag



-- DROP TABLE IF EXISTS TagsList;
-- DROP TABLE IF EXISTS Events;
-- DROP TABLE IF EXISTS Tags;
-- DROP TABLE IF EXISTS Account;

-- CREATE TABLE Account (
--     ID integer PRIMARY KEY,
--     Accountname VARCHAR(255) NOT NULL,
--     password VARCHAR(255) NOT NULL,
--     name VARCHAR(255) NOT NULL
-- );

-- CREATE TABLE Tags (
--     ID integer PRIMARY KEY,
--     color VARCHAR(255) NOT NULL,
--     label VARCHAR(255) NOT NULL
-- );

-- CREATE TABLE Events (
--     ID integer PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     location VARCHAR(255) NOT NULL,
--     date DATE NOT NULL,
--     time TIME NOT NULL,
--     description TEXT NOT NULL,
--     organizerID INTEGER REFERENCES Account(ID)
--     tagsListID INTEGER REFERENCES TagsList(ID)
-- );

-- CREATE TABLE TagsList (
--     ID integer PRIMARY KEY,
--     tagID INTEGER REFERENCES Tags(ID)
-- );

-- -- Allow users to select data from the tables
-- GRANT SELECT ON Account TO public;
-- GRANT SELECT ON Events TO public;
-- GRANT SELECT ON Tags TO public;
-- GRANT SELECT ON TagsList TO public;



-- -- Insert Accounts
-- INSERT INTO Account VALUES(1, 'Account1', 'password1', 'name 1');
-- INSERT INTO Account VALUES(2, 'Account2', 'password2', 'name 2');
-- INSERT INTO Account VALUES(3, 'Account3', 'password3', 'name 3');

-- -- Insert Events
-- INSERT INTO Events VALUES(1, 'Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1);
-- INSERT INTO Events VALUES(2, 'Sample Event 2', 'Location 2', '2021-01-02', '1:00:00', 'Description for Sample Event 2', 2);
-- INSERT INTO Events VALUES(3, 'Sample Event 3', 'Location 3', '2021-01-03', '2:00:00', 'Description for Sample Event 3', 3);
-- INSERT INTO Events VALUES(4, 'Sample Event 4', 'Location 4', '2021-01-04', '3:00:00', 'Description for Sample Event 4', 3);

