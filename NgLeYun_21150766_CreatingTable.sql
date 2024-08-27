# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_CreatingTable
# Section 3 Part 2a Implementation
# Purpose of File: Create table into the database

# Section 2 Part 1
-- Creating a databse using <suitable name> _<your student ID>
-- Drop FIFA_21150766 if already exist
DROP DATABASE IF EXISTS FIFA_21150766;
-- Create the database
CREATE DATABASE FIFA_21150766;

-- Use the database I created
USE FIFA_21150766;

-- Creating the Team table
-- Drop the table if exist
DROP TABLE IF EXISTS Team;
CREATE TABLE Team (
    TeamName VARCHAR(48) NOT NULL,
    Goals INT DEFAULT 0, 
    YCard INT DEFAULT 0,
    RCard INT DEFAULT 0, 
    PRIMARY KEY (TeamName)
);

-- Creating the Player table
-- Drop the table if exist
DROP TABLE IF EXISTS Player;
CREATE TABLE Player (
    PlayerNo INT NOT NULL,
    TeamName VARCHAR(48) NOT NULL,
    Name VARCHAR(128) NOT NULL,
    Position VARCHAR(12) NOT NULL,
    PRIMARY KEY (PlayerNo, TeamName),
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);

-- Creating the Stadium table
-- Drop the table if exist
DROP TABLE IF EXISTS Stadium;
CREATE TABLE Stadium (
    StadiumName VARCHAR(255) NOT NULL, 
    Location VARCHAR(255),
    Capacity INT, 
    PRIMARY KEY (StadiumName)
);

-- Creating the Matches table
-- Drop the table if exist
DROP TABLE IF EXISTS Matches;
CREATE TABLE Matches (
    MatchID INT NOT NULL,
    Knockout VARCHAR(48) NOT NULL,
    Date DATE,
    Time TIME,
    StadiumName VARCHAR(255),
    Team1ID VARCHAR(48) NOT NULL,
    Team2ID VARCHAR(48) NOT NULL, 
    PRIMARY KEY (MatchID), 
    FOREIGN KEY (StadiumName) REFERENCES Stadium(StadiumName)
);

-- Creating the Compete table
-- Drop the table if exist
DROP TABLE IF EXISTS Compete;
CREATE TABLE Compete (
    TeamName VARCHAR(48) NOT NULL,
    MatchID INT NOT NULL,
    Scores INT NOT NULL,
    PRIMARY KEY (TeamName, MatchID),
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

-- Creating the Winner table
-- Drop the table if exist
DROP TABLE IF EXISTS Winner;
CREATE TABLE Winner (
    Awards VARCHAR(48) NOT NULL,
    TeamName VARCHAR(48) NOT NULL,
    PRIMARY KEY (Awards),
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);


