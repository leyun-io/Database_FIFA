# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_Views_MatchStatistics
# Section 3 Part 4 Increase the database functionality with advanced concepts
# Purpose of File: This file will shows the view of each match and the match statistics

# Implementing the View for showing the match statistic
CREATE OR REPLACE VIEW MatchStatistics AS
SELECT 
    m.MatchID, 
    m.Team1ID, 
    m.Team2ID, 
    m.Date, 
    m.Time, 
    m.StadiumName, 
    -- extract the scores from each team
    (SELECT Scores FROM Compete WHERE MatchID = m.MatchID AND TeamName = m.Team1ID) AS Team1Scored,
    (SELECT Scores FROM Compete WHERE MatchID = m.MatchID AND TeamName = m.Team2ID) AS Team2Scored
FROM 
    Matches m
JOIN 
    Team t1 ON m.Team1ID = t1.TeamName
JOIN 
    Team t2 ON m.Team2ID = t2.TeamName;

# Testing the view
SELECT * 
FROM MatchStatistics;

SELECT * 
FROM MatchStatistics
WHERE Team1ID = 'Germany' OR Team2ID = 'Germany';

