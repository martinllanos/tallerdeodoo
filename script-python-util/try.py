#!/usr/bin/python3

## try.py
import psycopg2
from config import config
 
def connect():
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
 
        # create a cursor
        cur = conn.cursor()
        
 # execute a statement
        print('PostgreSQL database version:')
        cur.execute('SELECT version()')
 
        # display the PostgreSQL database server version
        db_version = cur.fetchone()
        print(db_version)
       
     # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
 
 
if __name__ == '__main__':
    connect()

# How it works.

#     First, read database connection parameters from the database.ini file.
#     Next, create a new database connection by calling the connect() function.
#     Then, create a new cursor and execute an SQL statement to get the PostgreSQL database version.
#     After that, read the result set by calling the  fetchone() method of the cursor object.
#     Finally, close the communication with the database server by calling the close() method of the cursor and connection objects.

# The connect() function raises the DatabaseError exception if an error occurred. To see how it works, we can change the connection parameters in the database.ini file.

# For example, if we change the host to  localhosts, the program will output the following message:
# 1 Connecting to the PostgreSQL database...
# 2 could not translate host name "localhosts" to address: Unknown host

# The following displays error message when we change the database to a non-existing one: supplier
# 1 Connecting to the PostgreSQL database...
# 2 FATAL: database "supplier" does not exist

# If we change the user to  postgress, it will not be authenticated successfully as shown below:
# 1 Connecting to the PostgreSQL database...
# 2 FATAL: password authentication failed for user "postgress"

# In this tutorial, we have shown you how to connect to the PostgreSQL database server in Python. We will reuse the config() function in the subsequent tutorial.