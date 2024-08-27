# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_Procedure_GetPlayerByTeam
# Section 3 Part 4 Increase the database functionality with advanced concepts
# Purpose of File: Retrieves player details based on team and position.
# Use Case: we might want to find players from a specific team playing in a particular position. We can easily extract the data by specifying the team and position, simplifying the analysis process.

# This Procedure wil show the player detail when the team name and the player's position is prompted
DROP PROCEDURE IF EXISTS GetPlayerByTeamAndPosition;

DELIMITER $$

CREATE PROCEDURE GetPlayerByTeamAndPosition
(
    IN p_TeamName VARCHAR(48),
    IN p_Position VARCHAR(12)
)
BEGIN
    -- Check whether therequested position is there
    IF p_Position IS NOT NULL AND TRIM(p_Position) <> '' THEN
        -- If the position is valid, select players from the specified team and position
        SELECT * 
        FROM Player 
        WHERE TeamName = p_TeamName AND Position = p_Position;
    ELSE
        -- If the position is not stated, select all players from the specified team
        SELECT * 
        FROM Player 
        WHERE TeamName = p_TeamName;
    END IF;
END $$

DELIMITER ;

# Testing the procedure

-- Call the procedure to print out 
CALL GetPlayerByTeamAndPosition('Japan', 'Goalkeeper');



