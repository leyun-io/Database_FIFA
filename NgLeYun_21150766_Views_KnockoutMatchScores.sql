# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_KnockoutMatchScores
# Section 3 Part 4 Increase the database functionality with advanced concepts
# Purpose of File: This file contain a view that is used to find out the total score of the team during the knockout 

# This view will help in Knowing each team's scores in the knockout 
CREATE OR REPLACE VIEW KnockoutMatchScores AS
SELECT Compete.TeamName, SUM(Compete.Scores) AS TotalScores
FROM Compete
JOIN Matches ON Compete.MatchID = Matches.MatchID
WHERE Matches.Knockout != 'Group Stage'
GROUP BY Compete.TeamName;

# Testing the view
SELECT * 
FROM KnockoutMatchScores
WHERE TeamName = 'Norway';

