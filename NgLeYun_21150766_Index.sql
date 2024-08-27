# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_Index
# Section 3 Part 4 Increase the database functionality with advanced concepts
# Purpose of File: This file will contain two indexes
# Use case: This willl let the query run faster in my SQL database

# Create index to the Player table
CREATE INDEX idx_player_team_position 
ON Player(TeamName, Position);
SHOW INDEXES IN Player;

# Testing the indexes
SELECT * 
FROM Player 
WHERE TeamName = 'USA' AND Position = 'Forward';

# Create index to the Compete table
CREATE INDEX idx_compete_match_team 
ON Compete(MatchID, TeamName);

# Testing the indexes
SELECT c.TeamName, SUM(c.Scores) 
FROM Compete c 
JOIN Matches m ON c.MatchID = m.MatchID 
WHERE c.MatchID = 32
GROUP BY c.TeamName;


