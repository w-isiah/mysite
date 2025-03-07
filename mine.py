import os
import mysql.connector

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', '1234')  # For session management
    MYSQL_HOST = 'localhost'  # Change to your MySQL server details
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = ''
    MYSQL_DB = 'teaching_practice'

def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host=Config.MYSQL_HOST,
            user=Config.MYSQL_USER,
            password=Config.MYSQL_PASSWORD,
            database=Config.MYSQL_DB
        )
        print("Connection successful")
        # Return both the connection object and configuration details
        return connection, Config.MYSQL_HOST, Config.MYSQL_USER, Config.MYSQL_PASSWORD, Config.MYSQL_DB
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None, None, None, None, None

# Get the connection and configuration details
connection, host, user, password, database = get_db_connection()

if connection:
    print(f"Connected to MySQL server at host: {host} with user: {user} on database: {database}")
else:
    print("Connection failed")
