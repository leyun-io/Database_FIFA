import mysql.connector

# Please update the following MySQL connection details according to your own database setup
# after running my .sql file as submitted:
# - 'user': Replace 'root' with your MySQL username.
# - 'host': Use 'localhost' if your MySQL server is on your local machine, 
#           otherwise use the server's IP address or hostname.
# - 'database': I have create my database name as 'FIFA_21150766' in 
#               "NgLeYun_21150766_CreatingTable.sql". So this line should not be change 
#               in normal case.
# - 'password': Enter the password for your MySQL user here as it will be different from mine.
# 
# Example: mysql.connector.connect(user='your_username', host='your_host', 
#                                  database='FIFA_21150766', password='your_password')

# Connect to database that have been created.
try:
    DBSconnect = mysql.connector.connect(user='root',
                                         host='localhost',
                                         database='FIFA_21150766',
                                         password='myUserPassword')
    print("Successfully connected to the database.")

except mysql.connector.Error as e:
    print(f"Error connecting to MySQL: {e}")
    # Exit if connection is not successful
    exit(1)

# Create a cursor
cursor = DBSconnect.cursor()

##############

# I want to know how many match have team Norway involved.
# Select data from the compete table and shows only team Norway
try:
    selectCompete = "SELECT TeamName, MatchID FROM Compete WHERE TeamName = %(TeamName)s"
    cursor.execute(selectCompete, {'TeamName': 'Norway'})
    # Make a divider for easy reading
    print('\n===========================\n')    
    print('Match that Norway involved')  
    for row in cursor:
        print(row)
    # Ensure all data is fetched
    cursor.fetchall()  
except mysql.connector.Error as e:
    print(f"Error: {e}")
    
##############

# Make use of a query that I have defined in mysql 
try:
    # call the procedure
    cursor.callproc("GetPlayerByTeamAndPosition", 
                   ('China PR', 'Forward'))
    
    # Make a divider for easy reading
    print('\n===========================\n')
    print('Here are the forward position player from China PR team: ')
    
    # Print the result out line by line
    for result_set in cursor.stored_results():
        for row in result_set.fetchall():
            print(row)

except mysql.connector.Error as e:
    print(f"Error: {e}")    

##############
    
# Create a cursor and execute the query
try:
    # To define a query: I wan to know which team scored more than 10 goals in total
    find10Goal = "SELECT TeamName, Goals FROM Team WHERE Goals > 10;"
    cursor.execute(find10Goal)
    
    # Make a divider for easy reading
    print('\n===========================\n')
    # Fetch and print the results
    print("Team that have scored more than 10 goals: ")
    for row in cursor:
        print(row)
    
    # Ensure all data is fetched    
    cursor.fetchall() 
except mysql.connector.Error as e:
    print(f"Error executing query: {e}")

##############
    
# Try inserting a new match record into the compete table
try:
    # Insert new Match data into the compete table, 
    # create a variable and store the process of adding new data into the Matches table    
    insertNewMatch = ("INSERT INTO Matches (MatchID, Knockout, Date, "
                      "Time, StadiumName, Team1ID, Team2ID)"
                      "VALUES (%s, %s, %s, %s, %s, %s, %s)")

    # Enter the match data that want to add in
    newMatchData = (20, 'Group Stage', '2007-09-18', 
                    '20:00:00', 'Tianjin Olympic Sports Center Stadium', 'Korea DPR', 'Sweden');

    # Execute the process
    cursor.execute(insertNewMatch, newMatchData)
    
    # Commit the transaction    
    DBSconnect.commit()  
    
    # Make a divider for easy reading
    print('\n===========================\n')    
    print(f"Inserted {cursor.rowcount} row(s) into Team table.")
    
    
except mysql.connector.Error as e:
    print(f"Error: {e}")    

##############

# Insert new Compete data into the compete table, 
try:
    # create a variable and store the process of adding new data into the Compete table
    insertNewCompete = ("INSERT INTO Compete (TeamName, MatchID, Scores)"
                        "VALUES (%s, %s, %s)")
    
    # Enter the data that want to add in
    newCompeteData = ('Korea DPR', 20, 1)

    # Execute the process
    cursor.execute(insertNewCompete, newCompeteData)

    # Commit the transaction 
    DBSconnect.commit()     

    # Double check the result by printing it out to ensure that the new data has successfully added.
    # Make a divider for easy reading
    print('\n===========================\n')
    print('The Match that Korea involved (after inserting)')
    
    cursor.execute(selectCompete, {'TeamName': 'Korea DPR'})

    for row in cursor:
        print(row)
        
    # Ensure all data is fetched    
    cursor.fetchall()  

except mysql.connector.Error as e:
    print(f"Error: {e}")

##############

# Update Team data
try:
    queryUpdate = "UPDATE Team SET Goals = %s WHERE TeamName = %s"
    updateGoalCount = (9, 'Australia')
    
    cursor.execute(queryUpdate, updateGoalCount)

    # Commit the transaction    
    DBSconnect.commit()  
    
    # Make a divider for easy reading
    print('\n===========================\n')
    print(f"Updated score for TeamName {updateGoalCount[0]} in MatchID {updateGoalCount[1]}")
    
    # Print out the result to show that the table is successfully updated
    printResult = "SELECT * FROM Team WHERE TeamName = 'Australia'"
    cursor.execute(printResult)
    print('Updated team performance for Australia: ')
    for row in cursor:
        print(row)
    
    # Ensure all data is fetched    
    cursor.fetchall()     
    
except mysql.connector.Error as e:
    print(f"Error: {e}")

##############
# Deleting a record
try:
    
    # Insert a record for deletion testing
    newMatchData = (21, 'Group Stage', '2007-09-20', 
                    '17:00:00', 'Hangzhou Dragon Stadium', 'Norway', 'Ghana');    
    cursor.execute(insertNewMatch, newMatchData)
    
    deleteRecord = "DELETE FROM Matches WHERE MatchID = %s"
    matchIDtoDelete = (21, ) 

    cursor.execute(deleteRecord, matchIDtoDelete)
    
    # Commit the deletion
    DBSconnect.commit()
    
    # Make a divider for easy reading
    print('\n===========================\n')    
    print(f"Deleted match with ID {matchIDtoDelete[0]}")
    
    # Check whether the deletion is successful
    printResult = "SELECT MatchID, Team1ID, Team2ID FROM Matches"
    cursor.execute(printResult)
    print('Print out the detail for matches (after deletion)')    
    for row in cursor:
        print(row)
    
    # Ensure all data is fetched    
    cursor.fetchall()     
    
except mysql.connector.Error as e:
    print(f"Error: {e}")



cursor.close()
DBSconnect.close()
