from flask import Flask
from config import Config
from flask_wtf.csrf import CSRFProtect
from datetime import timedelta

# In config.py or directly in your app's configuration
# Initialize Flask app
app = Flask(__name__)
app.config.from_object(Config)
app.config['SECRET_KEY'] = 'your_secret_key_here'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(minutes=3000)
csrf = CSRFProtect(app)


# Import blueprints
from app.auth.auth import users_bp
from app.main.main import main_bp
from app.students.students  import student_bp
from app.aspects.aspects  import aspects_bp
from app.aspect_questions.aspect_questions import aspect_qns_bp
from app.assessment_v1.assessment_v1 import assessment_bp
from app.scores.scores import scores_bp

# Register blueprints
app.register_blueprint(scores_bp,url_prefix='/scores')
app.register_blueprint(assessment_bp,url_prefix='/assessment')
app.register_blueprint(aspect_qns_bp,url_prefix='/aspect_qns')
app.register_blueprint(aspects_bp, url_prefix='/aspects')
app.register_blueprint(student_bp, url_prefix='/student')
app.register_blueprint(users_bp, url_prefix='/users')
app.register_blueprint(main_bp, url_prefix='/')



