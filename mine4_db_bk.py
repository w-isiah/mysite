import os
import subprocess

# Add MySQL's bin folder to PATH at runtime
os.environ['PATH'] += r";C:\Program Files\MySQL\MySQL Server 8.0\bin"  # Adjust path accordingly

# Now run your original backup command
mysqldump_command = [
    'mysqldump',
    '--host', 'localhost',
    '--user', 'root',
    '--password=Mine@1234',
    'teaching_practice',
    '--result-file=backup.sql',
]

try:
    subprocess.run(mysqldump_command, check=True)
    print("Backup successful!")
except subprocess.CalledProcessError as e:
    print(f"Backup failed! Error: {e}")
