-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS SavedEvents;
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
    time TIME not NULL,
    description TEXT NOT NULL,
    tagsArray INTEGER[] DEFAULT '{}',
    location VARCHAR(255) NOT NULL,
    organizerID INTEGER REFERENCES Account(ID)
);

-- Create SavedEvents table
CREATE TABLE SavedEvents (
    accountID INTEGER REFERENCES Account(ID),
    eventID INTEGER REFERENCES Events(ID)
);


-- Grant select permissions on all tables to public
GRANT SELECT ON Account TO public;
GRANT SELECT ON Events TO public;
GRANT SELECT ON SavedEvents TO public;

-- Insert sample Accounts
INSERT INTO Account (Accountname, password, name) VALUES ('john_doe', 'password123', 'John Doe');
INSERT INTO Account (Accountname, password, name) VALUES ('jane_smith', 'password456', 'Jane Smith');
INSERT INTO Account (Accountname, password, name) VALUES ('alice_jones', 'password789', 'Alice Jones');

-- Insert sample Events
-- Insert more diverse sample events
INSERT INTO Events (name, organizer, date, description, tagsArray, location, organizerID) VALUES
('Virtual Reality Gaming Expo', 'Pixel Play Studios', '2024-02-15', 'Dive into the world of VR gaming with demos and tournaments.', 
ARRAY[1, 5], 'San Francisco', 1),

('Astronomy Night Under the Stars', 'Starlight Observatory', '2024-03-10', 'Join us for a night of stargazing with expert astronomers.', 
ARRAY[1, 4], 'Sedona', 2),

('Comedy Open Mic Night', 'Laugh Out Loud Comedy Club', '2024-04-01', 'Show off your comedy chops or enjoy some laughs.', 
ARRAY[1], 'Austin', 3),

('Urban Gardening Workshop', 'Grow Green Co.', '2024-04-15', 'Learn how to grow your own urban garden in small spaces.', 
ARRAY[5], 'Denver', 2),

('Drone Racing Championship', 'Skybound Drones', '2024-05-12', 'Compete or spectate at this high-speed drone racing event.', 
ARRAY[2, 1], 'Seattle', 1),

('Fantasy Writers Meetup', 'Imagination Press', '2024-06-08', 'Connect with fellow fantasy writers and share your work.', 
ARRAY[3, 5], 'Portland', 3),

('DIY Robotics Workshop', 'TechBuild Labs', '2024-07-16', 'Build your own robot in this hands-on workshop.', 
ARRAY[4, 5], 'Chicago', 2),

('Pet Adoption Fair', 'Paws and Claws Animal Rescue', '2024-08-03', 'Meet your new best friend and support animal shelters.', 
ARRAY[1], 'New York', 1),

('Historic Ghost Tour', 'Legends of the Past Tours', '2024-09-20', 'Explore haunted historic sites and hear spine-chilling tales.', 
ARRAY[1, 3], 'Boston', 3),

('Eco-Friendly Living Expo', 'Sustainable Earth Initiative', '2024-10-05', 'Discover products and practices for a sustainable lifestyle.', 
ARRAY[4, 1], 'Los Angeles', 2),

('Underwater Photography Workshop', 'DiveDeep Adventures', '2024-10-20', 'Capture the beauty of marine life with expert guidance.', 
ARRAY[5], 'Miami', 3),

('Art in the Park Festival', 'Canvas Collective', '2024-11-02', 'Enjoy live art, food, and music at this outdoor festival.', 
ARRAY[1, 3], 'Austin', 1),

('Hackathon for Healthcare', 'HealthTech Solutions', '2024-11-15', 'Collaborate to create innovative tech solutions for healthcare.', 
ARRAY[4, 5], 'San Francisco', 2),

('Winter Lights Parade', 'City of Boulder', '2024-12-14', 'Celebrate the season with a parade of dazzling light displays.', 
ARRAY[1], 'Boulder', 3),

('Game Developers Conference', 'Pixel Forge Games', '2025-01-20', 'Meet game developers, learn, and showcase your projects.', 
ARRAY[4, 5], 'Seattle', 1),

('Science Fiction Film Marathon', 'RetroReels Cinema', '2024-03-28', 'A back-to-back marathon of iconic sci-fi movies from the past decades.', 
ARRAY[1, 3], 'Los Angeles', 1),

('Blockchain for Beginners Workshop', 'CryptoStart Hub', '2024-04-25', 'Learn the fundamentals of blockchain technology and cryptocurrencies.', 
ARRAY[4, 5], 'San Francisco', 2),

('Marine Conservation Dive', 'Ocean Guardians Association', '2024-05-22', 'Participate in underwater cleanup and marine conservation efforts.', 
ARRAY[2, 4], 'Key West', 3),

('Immersive Theater Experience', 'NextStage Productions', '2024-06-15', 'A one-of-a-kind interactive theatrical performance.', 
ARRAY[1], 'New York', 2),

('Mountain Trail Hiking Challenge', 'Peak Explorers Club', '2024-07-04', 'A guided hike across challenging mountain trails for all skill levels.', 
ARRAY[2], 'Denver', 1),

('Cosplay and Pop Culture Expo', 'FandomVerse Events', '2024-08-12', 'Celebrate pop culture with cosplay contests, exhibits, and panels.', 
ARRAY[1, 3], 'San Diego', 2),

('Space Exploration Seminar', 'AstroTech Institute', '2024-09-18', 'Learn about the latest developments in space technology and exploration.', 
ARRAY[4], 'Houston', 3),

('Culinary Fusion Cooking Class', 'TasteMakers Kitchen', '2024-10-10', 'Explore global cuisines and create unique fusion dishes.', 
ARRAY[5, 1], 'Chicago', 2);

