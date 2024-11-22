-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Account;

-- Create Account table
CREATE TABLE Account (
    ID SERIAL PRIMARY KEY,
    Accountname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

-- Create Events table
CREATE TABLE Events (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    organizer VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    description TEXT NOT NULL,
    tagsArray INTEGER[] DEFAULT '{}',
    location VARCHAR(255) NOT NULL,
    organizerID INTEGER REFERENCES Account(ID)
);

-- Grant select permissions on all tables to public
GRANT SELECT ON Account TO public;
GRANT SELECT ON Events TO public;

-- Insert sample Accounts
-- Note: The password will be hashed in the future
INSERT INTO Account (Accountname, password, name) VALUES ('john_doe', 'password123', 'John Doe');
INSERT INTO Account (Accountname, password, name) VALUES ('jane_smith', 'password456', 'Jane Smith');
INSERT INTO Account (Accountname, password, name) VALUES ('alice_jones', 'password789', 'Alice Jones');

-- Insert sample Events
INSERT INTO Events (name, organizer, date, description, tagsArray, location, organizerID) VALUES
('Tech Conference 2021', 'John Doe', '2021-09-15', 'A conference about the latest in technology.', ARRAY[1,2], 'New York', 1),
('Music Festival', 'Jane Smith', '2021-10-10', 'A festival featuring various music artists.', ARRAY[2,3], 'Los Angeles', 2),
('Art Exhibition', 'Alice Jones', '2021-11-05', 'An exhibition showcasing modern art.', ARRAY[3,4], 'San Francisco', 3),
('Startup Pitch Night', 'Alice Jones', '2021-12-01', 'An event where startups pitch their ideas to investors.', ARRAY[5], 'Boston', 3);