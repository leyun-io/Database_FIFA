# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_Trigger_UpdateGoalCount
# Section 3 Part 4 Increase the database functionality with advanced concepts
# Purpose of File: This is a trigger that will increase the goal count in the Team table while one compete is complete by a particular team.
# Hypothetical Scenario: After a match finish, the results are entered into the Compete table. The trigger ensures that the team's total goal count in the Team table is instantly updated, maintaining data consistency without manual intervention.


# Create a trigger

DROP TRIGGER IF EXISTS update_goal_count;

DELIMITER $$
CREATE TRIGGER update_goal_count
# This trigger will update after inserting data into the table Compete
AFTER INSERT ON Compete
FOR EACH ROW
BEGIN
    -- Update the total goals in the Team table
    UPDATE Team
    SET Goals = Goals + NEW.Scores
    WHERE TeamName = NEW.TeamName;
END $$

DELIMITER ;

# Testing the trigger
-- as the constarins will need a matches record to be insert before we adding new Compete record
INSERT INTO Matches VALUES
(2, 'Group Stage', '2007-09-11', 
'20:00:00', 'Shanghai Hongkou Football Stadium', 'Japan', 'England');

-- Make a update to the table Competer
INSERT INTO Compete VALUES 
('Japan', 2, 2);

-- See whether it updated the goal count to ensure the trigger works well.
SELECT * 
FROM Team
WHERE TeamName = 'Japan';

