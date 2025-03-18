import os
from dotenv import load_dotenv

# Load environment variables from a .env file if it exists
load_dotenv()

class Config:
    # For session management, load SECRET_KEY from environment variable or default to '1234'
    SECRET_KEY = os.environ.get('SECRET_KEY', '1234')  
    
    # MySQL configurations, loading from environment variables or default values
    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'localhost')  # Default to 'localhost'
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')  # Default to 'root'
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', 'Mine@1234')  # Default password
    MYSQL_DB = os.environ.get('MYSQL_DB', 'teaching_practice')  # Default database name

# Example of how to use the Config class:
if __name__ == '__main__':
    # Accessing configuration values
    print(f"SECRET_KEY: {Config.SECRET_KEY}")
    print(f"MYSQL_HOST: {Config.MYSQL_HOST}")
    print(f"MYSQL_USER: {Config.MYSQL_USER}")
    print(f"MYSQL_PASSWORD: {Config.MYSQL_PASSWORD}")
    print(f"MYSQL_DB: {Config.MYSQL_DB}")
