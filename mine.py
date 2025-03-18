import os
import mysql.connector
from datetime import datetime

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', '1234')  # For session management
    MYSQL_HOST = 'localhost'  # Change to your MySQL server details
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = 'Mine@1234'
    MYSQL_DB = 'teaching_practice'
    BACKUP_DIR = os.getcwd()  # Use the current working directory as the backup directory

def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host=Config.MYSQL_HOST,
            user=Config.MYSQL_USER,
            password=Config.MYSQL_PASSWORD,
            database=Config.MYSQL_DB
        )
        print("Connection successful")
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

def backup_database(connection):
    try:
        cursor = connection.cursor()

        # Get the list of tables in the database
        cursor.execute(f"SHOW TABLES")
        tables = cursor.fetchall()

        # Prepare filename with current timestamp
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        backup_filename = f"{Config.MYSQL_DB}_backup_{timestamp}.sql"
        backup_filepath = os.path.join(Config.BACKUP_DIR, backup_filename)

        with open(backup_filepath, 'w') as backup_file:
            # Iterate over each table and back up its data
            for table in tables:
                table_name = table[0]
                print(f"Backing up table: {table_name}")

                # Write the table creation statement (schema)
                cursor.execute(f"SHOW CREATE TABLE {table_name}")
                create_table_query = cursor.fetchone()[1]
                backup_file.write(f"-- Table: {table_name}\n")
                backup_file.write(f"{create_table_query};\n\n")

                # Retrieve all rows in the table
                cursor.execute(f"SELECT * FROM {table_name}")
                rows = cursor.fetchall()

                # Generate the INSERT statements for the data
                if rows:
                    columns = [desc[0] for desc in cursor.description]
                    for row in rows:
                        # Properly escape single quotes in string values
                        values = ", ".join([f"'{str(value).replace("'", "''")}'" if value is not None else "NULL" for value in row])
                        insert_statement = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({values});\n"
                        backup_file.write(insert_statement)
                    backup_file.write("\n")

        print(f"Backup completed successfully! Backup file: {backup_filepath}")

    except mysql.connector.Error as err:
        print(f"Error during backup process: {err}")
    finally:
        # Ensure that cursor and connection are closed
        cursor.close()
        connection.close()
        print("Connection closed.")

# Get the database connection
connection = get_db_connection()

if connection:
    print(f"Connected to MySQL server at {Config.MYSQL_HOST} with user {Config.MYSQL_USER} on database {Config.MYSQL_DB}")
    # Back up the database
    backup_database(connection)
else:
    print("Connection failed")
