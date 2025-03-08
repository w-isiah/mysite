import mysql.connector

# Database connection details
host = 'assessmentform2025.mysql.pythonanywhere-services.com'  
user ='assessmentform2025.mysql.pythonanywhere-services.com'
password ='assessmentform20'
db = 'assessmentform20$assessmentform2025'




# Establish connection to the database using mysql.connector
connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=db
)

try:
    cursor = connection.cursor()

    # Step 1: Retrieve the list of all tables
    cursor.execute(f"SELECT table_name FROM information_schema.tables WHERE table_schema = '{db}';")
    tables = cursor.fetchall()

    # Step 2: Create a single file to store the SQL dump
    with open('all_tables_backup.sql', 'w', encoding='utf-8') as sqlfile:
        for table in tables:
            table_name = table[0]  # Get the table name from the query result
            print(f"Exporting data from table: {table_name}")

            # Step 3: Execute SELECT * for each table
            cursor.execute(f"SELECT * FROM {table_name}")
            rows = cursor.fetchall()

            # Step 4: Get column names for the SQL insert statements
            column_names = [desc[0] for desc in cursor.description]

            # Step 5: Write the SQL header for creating the table (optional)
            sqlfile.write(f"-- Backup of table: {table_name}\n")
            sqlfile.write(f"CREATE TABLE IF NOT EXISTS {table_name} (\n")

            # Write the column definitions (optional)
            column_definitions = []
            for col in column_names:
                column_definitions.append(f"    `{col}` TEXT")
            sqlfile.write(",\n".join(column_definitions) + "\n);\n\n")

            # Step 6: Write the insert statements for each row in the table
            for row in rows:
                values = ', '.join([f"'{str(val).replace("'", "''")}'" if val is not None else "NULL" for val in row])
                sqlfile.write(f"INSERT INTO {table_name} ({', '.join(column_names)}) VALUES ({values});\n")

            print(f"Data from {table_name} exported to all_tables_backup.sql")

finally:
    # Close the connection
    if connection.is_connected():
        connection.close()
