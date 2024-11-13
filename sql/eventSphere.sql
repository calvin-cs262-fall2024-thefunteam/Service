-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Events;

-- Create Account table
CREATE TABLE Account (
    ID INTEGER PRIMARY KEY,
    Accountname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

-- Create Events table
CREATE TABLE Events (
    ID INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    description TEXT NOT NULL,
    organizerID INTEGER REFERENCES Account(ID)
);

-- Grant select permissions on all tables to public
GRANT SELECT ON Account TO public;
GRANT SELECT ON Events TO public;

-- Insert sample Accounts
INSERT INTO Account VALUES (1, 'Account1', 'password1', 'name 1');
INSERT INTO Account VALUES (2, 'Account2', 'password2', 'name 2');
INSERT INTO Account VALUES (3, 'Account3', 'password3', 'name 3');

-- Insert sample Events

INSERT INTO Events (name, location, date, time, description, organizerID) VALUES
('Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1),
('Sample Event 2', 'Location 2', '2021-01-02', '13:00:00', 'Description for Sample Event 2 Very long adfajdfkas flksahf kashf lkas hfaslkf baslkfbsalk fhaskljf lhsajkf askjfh sakjfh askjlfh askljfhaksl j hfaskjhf askjfh sakjfhaskjfh askjfh askjhf askj hfaskljfh askljfh asjkfh asjkfhaskjf haskjf haskl jh', 2),
('Sample Event 3', 'Location 3', '2021-01-03', '14:00:00', 'According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway because bees don't care what humans think is impossible. Yellow, black. Yellow, black. Yellow, black. Yellow, black. Ooh, black and yellow! Let's shake it up a little. Barry! Breakfast is ready! Coming! Hang on a second. Hello? ', 3),
('Sample Event 4', 'Location 4', '2021-01-04', '15:00:00', 'Description for Sample Event 4', 3);

-- Associate Events with Tags in the EventsTags join table
INSERT INTO EventsTags (eventID, tagID) VALUES (1, 1);  -- Sample Event 1 with Social tag
INSERT INTO EventsTags (eventID, tagID) VALUES (1, 2);  -- Sample Event 1 with Networking tag
INSERT INTO EventsTags (eventID, tagID) VALUES (2, 1);  -- Sample Event 2 with Social tag
INSERT INTO EventsTags (eventID, tagID) VALUES (3, 3);  -- Sample Event 3 with Workshop tag
INSERT INTO EventsTags (eventID, tagID) VALUES (4, 2);  -- Sample Event 4 with Networking tag

INSERT INTO Events VALUES
(1, 'Sample Event 1', 'Location 1', '2021-01-01', '12:00:00', 'Description for Sample Event 1', 1),
(2, 'Sample Event 2', 'Location 2', '2021-01-02', '13:00:00', 'Description for Sample Event 2 Very long adfajdfkas flksahf kashf lkas hfaslkf baslkfbsalk fhaskljf lhsajkf askjfh sakjfh askjlfh askljfhaksl j hfaskjhf askjfh sakjfhaskjfh askjfh askjhf askj hfaskljfh askljfh asjkfh asjkfhaskjf haskjf haskl jh', 2),
(3, 'Sample Event 3', 'Location 3', '2021-01-03', '14:00:00', 'According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway because bees dont care what humans think is impossible. Yellow, black. Yellow, black. Yellow, black. Yellow, black. Ooh, black and yellow! Lets shake it up a little. Barry! Breakfast is ready! Coming! Hang on a second. Hello? ', 3),
(4, 'Sample Event 4', 'Location 4', '2021-01-04', '15:00:00', 'Description for Sample Event 4', 3);


