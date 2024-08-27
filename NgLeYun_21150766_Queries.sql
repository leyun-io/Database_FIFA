# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_Queries
# Section 3 Part 3 Designing and implementing queries
# Purpose of File: Designing and implementing queries

# Level 1 Basic SQL Select Statement
-- Which team have more than 5 yellow card?
-- This query looks in the 'Team' table for teams where the yellow card count (YCard) exceeds 5.
SELECT TeamName 
FROM Team 
WHERE YCard > 5;

-- What is the average goal that each team have?
-- Using the AVG function, this query computes the average goals for all teams in the 'Team' table.
SELECT AVG(Goals) 
FROM Team;

-- Which team in the knockout match have played the match before '18:00:00' (6 PM)
-- This searches the 'Matches' table for matches classified as 'Knockout' and starting before 18:00:00.
SELECT MatchID, Team1ID, Team2ID, Knockout, Time
FROM Matches 
WHERE Time < '18:00:00';

-- Which team name starts with 'C'?
-- It filters the 'Team' table to retrieve teams with names beginning with 'C'.
SELECT TeamName 
FROM Team 
WHERE TeamName LIKE 'C%';

-- Which player name have length longer than 20?
-- This checks the 'Player' table for player names exceeding 20 characters in length.
SELECT Name 
FROM Player 
WHERE LENGTH(Name) > 20;

-- Which teams competed in the final and semi-final match?
-- Searches the 'Matches' table for teams participating in either 'Final' or 'Semi-Final' stages.
SELECT Team1ID, Team2ID 
FROM Matches 
WHERE Knockout IN ('Final', 'Semi-Final');

-- Find out team that gain goal count between 3 to 6
-- Groups the 'Team' table by 'TeamName' and filters for total goals between 3 and 6.
SELECT TeamName, Goals
FROM Team
GROUP BY TeamName
HAVING Goals BETWEEN 3 AND 6;

-- I want to know the teams that have match after 15th September 2007. 
-- Filters the 'Matches' table for matches occurring after September 24, 2007, formatting the date.
SELECT Team1ID, Team2ID, DATE_FORMAT(Date, '%W, %e %M %Y') AS MatchDate
FROM Matches 
WHERE Date > '2007-09-24';

-- How many knockout were played in each stadium?
-- Counts matches classified as 'Knockout' in the 'Matches' table, grouped by 'StadiumName'.
SELECT StadiumName, COUNT(*) AS GoalCount
FROM Matches 
GROUP BY StadiumName;

-- How many goals are scored in total in the tournament?
-- Sums up all goals from the 'Team' table to get the total number of goals in the tournament.
SELECT SUM(Goals) 
AS TotalGoals 
FROM Team;

-- Which 5 team that have the most goal count?
-- Retrieves the top 5 teams based on total goals scored, sorted in descending order.
SELECT TeamName, Goals
FROM Team 
GROUP BY TeamName 
ORDER BY Goals DESC 
LIMIT 5;

-- Who are the players from USA team which have the forwards position?
-- Selects players from the 'Player' table who are in the 'Forward' position for the 'USA' team.
SELECT Name 
FROM Player 
WHERE TeamName = 'USA' AND Position = 'Forward';

-- Can I know all the location of the stadium that held FIFA world cup 2007?
-- Concatenates the name and location of each stadium from the 'Stadium' table.
SELECT CONCAT(StadiumName, ', ', Location) AS Location
FROM Stadium;

-- Who are the goal keeper from either 'USA', 'Brazil', or 'Germany'?
-- Filters the 'Player' table for goalkeepers belonging to either 'USA', 'Brazil', or 'Germany'.
SELECT Name, PlayerNO, TeamName FROM Player 
WHERE TeamName IN ('USA', 'Brazil', 'Germany') 
AND Position = 'Goalkeeper';

-- I want to know which player's name starts with 'Kar'
-- Looks in the 'Player' table for players whose names start with the string 'Kar'.
SELECT Name 
FROM Player 
WHERE Name REGEXP '^Kar';

-- Which player start her last name with "S"?
-- Uses a regular expression to filter players in the 'Player' table whose last names start with 'S'.
SELECT *
FROM Player 
WHERE Name REGEXP '^[^ ]* [S]';


# Level 2 Use joins and sub-queries

-- Can i know the match which have already been past for 5966 days?
-- Retrieves the list of old matches for historical reference.
-- This selects matches from the Matches table where the number of days since the match occurred is more than 5966.
SELECT 
    m.MatchID, 
    m.Date, 
    m.Team1ID, 
    m.Team2ID, 
    DATEDIFF(CURDATE(), m.Date) AS DaysSinceMatch
FROM 
    Matches m
WHERE 
    DATEDIFF(CURDATE(), m.Date) > 5966
ORDER BY 
    DaysSinceMatch DESC;



-- Which teams participated in matches at 'Shanghai Hongkou Football Stadium'?
-- Finds teams that have played at a specific stadium.
-- This query joins Compete and Matches tables to find teams that played in the 
-- Shanghai Hongkou Football Stadium.
SELECT DISTINCT TeamName, m.MatchID 
FROM Compete c
JOIN Matches m ON c.MatchID = m.MatchID 
WHERE m.StadiumName = 'Shanghai Hongkou Football Stadium';

-- Which team is not in the knockout match?
-- This left joins the Team table with the Compete table to find teams that have no entry in knockout matches.
SELECT t.TeamName, Goals
FROM Team t
LEFT JOIN Compete c ON t.TeamName = c.TeamName
WHERE c.TeamName IS NULL;

-- What are the average goals that are scored in each stadium?
-- This query calculates the average goals scored in each stadium by joining the Matches and Compete tables.
SELECT m.StadiumName, AVG(c.Scores) AS AverageGoals
FROM Matches m
JOIN Compete c ON m.MatchID = c.MatchID
GROUP BY m.StadiumName;

-- Find the total goals scored in each phase of the competition (e.g., Group Stage, Quarter-Final, etc.).
-- This aggregates the total goals scored in each phase of the competition by joining the Matches and Compete tables.
SELECT m.Knockout, SUM(c.Scores) AS TotalGoals
FROM Matches m
JOIN Compete c ON m.MatchID = c.MatchID
GROUP BY m.Knockout;

-- How many goals each team get in the knockout match?
-- This query sums up the goals scored by each team in knockout matches, excluding 'Group Stage' and 'NULL'.
SELECT c.TeamName, m.Knockout, SUM(c.Scores) AS TotalGoals
FROM Compete c
JOIN Matches m ON c.MatchID = m.MatchID
WHERE m.Knockout != 'Group Stage' OR m.Knockout != 'NULL'
GROUP BY m.Knockout, c.TeamName
ORDER BY m.Knockout, TotalGoals DESC;

-- Can I know which team is the winner of the tournament, and who is the goalkeeper of this team, 
-- what team are they from and how many goals do this team scores in the overall conpetition?
-- This query uses right joins to connect the Player, Team, and Winner tables to find the winning 
-- team's goalkeeper and their overall goal score.
SELECT *
FROM Player 
RIGHT JOIN Team ON Player.TeamName = Team.TeamName
RIGHT JOIN Winner ON Team.TeamName = Winner.TeamName
WHERE Winner.Awards = 'Winner' AND Player.Position = 'Goalkeeper';

-- Which team have more goals then team Norway?
-- This query compares each team's goals with Norway's goals and selects those with a higher count.
SELECT t.TeamName, t.Goals
FROM Team t
INNER JOIN Team t2 ON t2.TeamName = 'Norway'
WHERE t.Goals > t2.Goals;

-- Which team scores the goal count which is lower than average, and list all the player in those team.
-- This nested query selects players from teams whose total goal count is below the average across all teams.
SELECT PlayerNo, Name, TeamName
FROM Player 
WHERE TeamName IN (
    SELECT TeamName 
    FROM Team 
    WHERE Goals < (SELECT AVG(Goals) FROM Team)
);

-- List teams that have played more matches than the average number of matches played by all teams.
-- This query lists matches where the total goals exceed the average total goals scored across all matches.
SELECT Compete.MatchID, 
	   GROUP_CONCAT(DISTINCT Compete.TeamName SEPARATOR ', ') AS Teams, 
       -- Find the scores for each compete
       SUM(Compete.Scores) AS TotalGoals 
FROM Compete
JOIN Matches ON Compete.MatchID = Matches.MatchID
GROUP BY Compete.MatchID
HAVING TotalGoals > (
	-- Average the total scores
    SELECT AVG(TotalGoals) 
    FROM (
        SELECT SUM(Scores) AS TotalGoals 
        FROM Compete 
        GROUP BY MatchID
    ) AS MatchGoals
);

-- Can I know the matches and the total goals scored in each knockout match?
-- This query calculates the total goals scored in each match of the knockout stage.
SELECT Matches.MatchID, 
	   Matches.Date, 
       Matches.Team1ID, 
       Matches.Team2ID, 
       IFNULL(SUM(Compete.Scores), 0) AS TotalGoals
FROM Matches
LEFT JOIN Compete ON Matches.MatchID = Compete.MatchID
GROUP BY Matches.MatchID;

-- Which team scored more that 3 goals and which team get more than 5 yellow card?
-- This union query combines the results of teams scoring more than 3 goals with those 
-- receiving more than 5 yellow cards.
(SELECT TeamName, 'High Scorer' AS Category
FROM Compete
WHERE Scores > 3)
-- use union to show the two result
UNION
(SELECT TeamName, 'Frequent Foulers' AS Category
FROM Team
WHERE YCard > 5);

-- Find out the knockout match that have most goals in total
-- This query finds the match with the highest total goals scored in the knockout stage.
SELECT m.MatchID, 
	   m.Date, 
       m.Team1ID, 
       m.Team2ID, 
       SUM(c.Scores) AS TotalGoals
FROM Matches m
JOIN Compete c ON m.MatchID = c.MatchID
-- Group the results by Match ID to calculate total goals for each match
GROUP BY m.MatchID
-- Filter to only include the match with the maximum total goals
HAVING TotalGoals = (
    -- Subquery to find the maximum total goals scored in any match
    SELECT MAX(TotalGoals)
    FROM (
        -- Subquery to calculate total goals for each match
        SELECT SUM(Scores) AS TotalGoals
        FROM Compete
        GROUP BY MatchID
    ) AS SubQuery
);

