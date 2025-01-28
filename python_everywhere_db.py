import os
class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', '1234')  # For session management
    MYSQL_HOST = 'assessmentform2025.mysql.pythonanywhere-services.com'  # Change to your MySQL server details
    MYSQL_USER = 'assessmentform20'
    MYSQL_PASSWORD = 'mine@1234'
    MYSQL_DB = 'assessmentform20$default'



