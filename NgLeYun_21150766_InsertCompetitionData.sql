# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_InsertCompetitionData
# Section 3 Part 2b Loading sample data
# Purpose of File: Insert the data into table Stadium, Match, Compete and Winner
# Reference: FIFA Women’s World Cup China 2007TM. (n.d.). 
# 				https://www.fifa.com/tournaments/womens/womensworldcup/china2007


-- Insert data into Stadium table
INSERT INTO Stadium VALUES
('Tianjin Olympic Sports Center Stadium', 'Tianjin\, China', '60000');
INSERT INTO Stadium VALUES
('Wuhan Five Rings Sports Center Stadium', 'Wuhan\, China', '60000');
INSERT INTO Stadium VALUES
('Hangzhou Dragon Stadium', 'Hangzhou\, China', '51000');
INSERT INTO Stadium VALUES
('Chengdu Sports Centre Stadium', 'Chengdu\, China', '40000');
INSERT INTO Stadium VALUES
('Shanghai Hongkou Football Stadium', 'Shanghai\, China', '33000');

-- Insert data into Matches table
-- Quarter-Final
INSERT INTO Matches VALUES
(25, 'Quarter-Final', '2007-09-22', 
'17:00:00', 'Wuhan Five Rings Sports Center Stadium', 'Germany', 'Korea DPR');
INSERT INTO Matches VALUES
(26, 'Quarter-Final', '2007-09-22', 
'20:00:00', 'Tianjin Olympic Sports Center Stadium', 'USA', 'England');
INSERT INTO Matches VALUES
(27, 'Quarter-Final', '2007-09-23', 
'17:00:00', 'Wuhan Five Rings Sports Center Stadium', 'Norway', 'China PR');
INSERT INTO Matches VALUES
(28, 'Quarter-Final', '2007-09-23', 
'20:00:00', 'Tianjin Olympic Sports Center Stadium', 'Brazil', 'Australia');

-- Semi-Final
INSERT INTO Matches VALUES
(29, 'Semi-Final', '2007-09-26', 
'20:00:00', 'Tianjin Olympic Sports Center Stadium', 'Germany', 'Norway');
INSERT INTO Matches VALUES
(30, 'Semi-Final', '2007-09-27', 
'20:00:00', 'Hangzhou Dragon Stadium', 'USA', 'Brazil');

-- Match for Third Place
INSERT INTO Matches VALUES
(31, 'Match for Third Place', '2007-09-30', 
'17:00:00', 'Shanghai Hongkou Football Stadium', 'Norway', 'USA');

-- Final
INSERT INTO Matches VALUES
(32, 'Final', '2007-09-30', 
'20:00:00', 'Shanghai Hongkou Football Stadium', 'Germany', 'Brazil');


-- Insert data into Compete table
-- Quarter-Final
INSERT INTO Compete VALUES
('Germany', 25, 3);
INSERT INTO Compete VALUES
('Korea DPR', 25, 0);
INSERT INTO Compete VALUES
('USA', 26, 3);
INSERT INTO Compete VALUES
('England', 26, 0);
INSERT INTO Compete VALUES
('Norway', 27, 1);
INSERT INTO Compete VALUES
('China PR', 27, 0);
INSERT INTO Compete VALUES
('Brazil', 28, 3);
INSERT INTO Compete VALUES
('Australia', 28, 2);

-- Semi-Final
INSERT INTO Compete VALUES
('Germany', 29, 3);
INSERT INTO Compete VALUES
('Norway', 29, 0);
INSERT INTO Compete VALUES
('USA', 30, 0);
INSERT INTO Compete VALUES
('Brazil', 30, 4);

-- Match for Third Place
INSERT INTO Compete VALUES
('Norway', 31, 1);
INSERT INTO Compete VALUES
('USA', 31, 4);

-- Final
INSERT INTO Compete VALUES
('Germany', 32, 2);
INSERT INTO Compete VALUES
('Brazil', 32, 0);

-- Insert data into Winner table
INSERT INTO Winner VALUES
('Winner', 'Germany');
INSERT INTO Winner VALUES
('Runner-up', 'Brazil');
INSERT INTO Winner VALUES
('Third Place', 'USA');
INSERT INTO Winner VALUES
('Fourth Place', 'Norway');

