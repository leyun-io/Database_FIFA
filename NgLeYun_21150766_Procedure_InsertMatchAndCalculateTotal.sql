# Student Name: Ng Le Yun
# Student ID: 21150766
# File Name: NgLeYun_21150766_Procedure_InsertMatchAndCalculateTotal
# Section 3 Part 4 Increase the database functionality with advanced concepts
# Purpose of File: Insert more match into the matches table and calculates the total number of matches.
# Use Case: After a new match is scheduled, we can uses this procedure to update the database. 

# This procedure will insert new match into the table
DROP PROCEDURE IF EXISTS InsertMatchAndCalculateTotal;

DELIMITER $$

-- Parameter pass in here will updated to the Matches table
CREATE PROCEDURE InsertMatchAndCalculateTotal(
    IN p_MatchID INT,
    IN p_Knockout VARCHAR(48),
    IN p_Date DATE,
    IN p_Time TIME,
    IN p_StadiumName VARCHAR(255),
    IN p_Team1ID VARCHAR(48),
    IN p_Team2ID VARCHAR(48),
    OUT p_TotalMatches INT
)
BEGIN
    -- User-defined variable for checking the date range
    SET @startDate := '2007-09-10';
    SET @endDate := '2007-09-30';
    -- Check if p_Date is within the specified range
    IF p_Date >= '2007-09-10' AND p_Date <= '2007-09-30' THEN
        -- Insert new match details into the Matches table
		INSERT INTO Matches(MatchID, Knockout, Date, Time, StadiumName, Team1ID, Team2ID)
		VALUES(p_MatchID, p_Knockout, p_Date, p_Time, p_StadiumName, p_Team1ID, p_Team2ID);
    ELSE
        -- Handle the scenario where p_Date is outside the specified range
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date is outside the allowed range (10 to 30 September 2007).';
    END IF;
    
    -- Calculate the total number of matches after inserting the new match
    SELECT COUNT(*) INTO p_TotalMatches FROM Matches;
END $$

DELIMITER ;

# Testing the Procedure

CALL InsertMatchAndCalculateTotal(14, 'Group Stage', '2007-09-15', '20:00:00', 
								  'Hangzhou Dragon Stadium', 'Australia', 'Norway', @TotalMatches);

SELECT * FROM Matches;
SELECT  @TotalMatches;