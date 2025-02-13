from datetime import timedelta, datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session, jsonify, current_app
from app.db import get_db_connection  # Assuming you have a custom db module to manage DB connections
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector
from werkzeug.utils import secure_filename
import os
from app import app

# Initialize the blueprint
users_bp = Blueprint('auth', __name__)

# Ensure the Flask app secret key is set to manage sessions
# app.secret_key = 'your_secret_key'

# Set session lifetime to 30 minutes (can be configured based on needs)
''''
@users_bp.before_app_request
def check_session_timeout():
    if 'loggedin' in session:
        last_activity = session.get('last_activity', datetime.utcnow())
        timeout_duration = current_app.config['PERMANENT_SESSION_LIFETIME']
        if (datetime.utcnow() - last_activity).total_seconds() > timeout_duration.total_seconds():
            flash('Your session has expired due to inactivity. Please log in again.', 'warning')
            session.clear()  # Clear session data
            return redirect(url_for('auth.login'))  # Redirect to the login page

        # Update the session's last activity time
        session['last_activity'] = datetime.utcnow()'''


@users_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Get DB connection using context manager
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
                user = cursor.fetchone()

                if user:
                    if check_password_hash(user['password'], password):
                        session['loggedin'] = True
                        session['id'] = user['id']
                        session['username'] = user['username']
                        session['first_name'] = user['first_name']
                        session['last_name'] = user['last_name']
                        session['profile_image'] = user['profile_image']
                        session['role'] = user['role']
                        session.permanent = True  # Make session permanent
                        session['last_activity'] = datetime.utcnow()  # Set last activity time
                        flash('Login successful!', 'success')
                        return redirect(url_for('main.index'))  # Redirect to the main page
                    else:
                        flash('Invalid password.', 'danger')
                else:
                    flash('Invalid username.', 'danger')

    return render_template('accounts/login.html')


@users_bp.route('/logout')
def logout():
    session.clear()  # Clear session data
    flash('You have logged out successfully.', 'success')
    return redirect(url_for('auth.login'))  # Redirect to login


@users_bp.route('/manage_users')
def manage_users():
   
    try:
        # Get DB connection using context manager
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                if session['role']=='admin':
                    cursor.execute("SELECT * FROM users WHERE role != 'admin'")
                    users = cursor.fetchall()
                elif session['role']=='Head of Department':
                    cursor.execute("SELECT * FROM users WHERE role != 'admin' and role !='Head of Department' and role != 'Dean'")
                    users = cursor.fetchall()


                # Get the count of users that are not admins
                num = len(users)

    except Exception as e:
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))
    if session['role']=='admin':
        return render_template('accounts/manage_users.html', username=session.get('username'), role=session.get('role'), num=num, users=users)
    elif session['role']=='Head of Department':
        return render_template('accounts/moderator/manage_users.html', username=session.get('username'), role=session.get('role'), num=num, users=users)


@users_bp.route('/api/manage_users_count', methods=['GET'])
def get_users_count():
    try:
        # Get DB connection using context manager
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute("SELECT COUNT(*) FROM users WHERE role != 'admin'")
                num = cursor.fetchone()[0]  # Extract count value from the tuple

        # Return the count as a JSON response
        return jsonify({"count": num})

    except Exception as e:
        return jsonify({"error": f"An error occurred while fetching data: {str(e)}"}), 500








# Allowed file extensions for image upload (if you're accepting profile images)
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# Function to check if the uploaded file is a valid image
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@users_bp.route('/add_user', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        # Get the form data
        username = request.form['username']
        password = request.form['password']
        role = request.form['role']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        other_name = request.form['other_name']
        
        # Handle profile image upload (if present)
        profile_image = None
        if 'profile_image' in request.files:
            image_file = request.files['profile_image']
            if image_file and allowed_file(image_file.filename):
                # Secure the file name and save it to the static folder
                filename = secure_filename(image_file.filename)
                profile_image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

                # Make sure the upload folder exists, create it if not
                if not os.path.exists(app.config['UPLOAD_FOLDER']):
                    os.makedirs(app.config['UPLOAD_FOLDER'])

                image_file.save(profile_image_path)
                profile_image = os.path.join(UPLOAD_FOLDER, filename)  # Save the relative path in the DB

        # Password hashing for security
        hashed_password = generate_password_hash(password)

        # Get DB connection using context manager
        with get_db_connection() as connection:
            with connection.cursor() as cursor:
                # Check if the username already exists
                cursor.execute('SELECT 1 FROM users WHERE username = %s', (username,))
                if cursor.fetchone():
                    flash('Username already exists. Please choose a different one.', 'danger')
                    return render_template('accounts/add_user.html', role=session.get('role'), username=session.get('username'))

                try:
                    # Insert user data, including first name, last name, other name, and profile image
                    cursor.execute('''
                        INSERT INTO users (username, password, role, first_name, last_name, other_name, profile_image)
                        VALUES (%s, %s, %s, %s, %s, %s, %s)
                    ''', (username, hashed_password, role, first_name, last_name, other_name, profile_image))
                    connection.commit()
                    flash('User added successfully!', 'success')
                except mysql.connector.Error as err:
                    flash(f'Error: {err}', 'danger')

        return redirect(url_for('auth.manage_users'))  # Redirect to user management page

    # Rendering different templates based on role
    if session['role'] == 'admin':
        return render_template('accounts/add_user.html', role=session.get('role'), username=session.get('username'))
    elif session['role'] == 'Head of Department':
        return render_template('accounts/moderator/add_user.html', role=session.get('role'), username=session.get('username'))










# Route for editing user information
@users_bp.route('/edit_user/<int:id>', methods=['GET', 'POST'])
def edit_user(id):
    
    # Get DB connection using context manager
    with get_db_connection() as connection:
        with connection.cursor(dictionary=True) as cursor:
            if request.method == 'POST':
                # Get form data
                username = request.form['username']
                first_name = request.form['first_name']
                last_name = request.form['last_name']
                other_name = request.form['other_name']
                password = request.form['password']
                role = request.form['role']
                profile_image = request.files.get('profile_image')

                # Handle password update, only if password is provided
                if password:
                    hashed_password = generate_password_hash(password)
                else:
                    cursor.execute('SELECT password FROM users WHERE id = %s', (id,))
                    hashed_password = cursor.fetchone()['password']

                # Handle profile image upload if a new image is provided
                if profile_image and allowed_file(profile_image.filename):
                    # Generate a secure filename
                    filename = secure_filename(profile_image.filename)
                    # Define the path where the file will be saved
                    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                    # Save the file to the server
                    profile_image.save(file_path)
                    # Use the filename in the database
                    profile_image = filename
                else:
                    # Keep the current profile image if no new image is uploaded
                    cursor.execute('SELECT profile_image FROM users WHERE id = %s', (id,))
                    profile_image = cursor.fetchone()['profile_image']
                
                # Update user information in the database
                try:
                    cursor.execute('''
                        UPDATE users
                        SET username = %s, first_name = %s, last_name = %s, other_name = %s, password = %s, role = %s, profile_image = %s
                        WHERE id = %s
                    ''', (username, first_name, last_name, other_name, hashed_password, role, profile_image, id))
                    connection.commit()
                    flash('User updated successfully!', 'success')
                except mysql.connector.Error as err:
                    flash(f'Error: {err}', 'danger')

                # Redirect to the user management page after successful update
                return redirect(url_for('auth.manage_users'))

            # If the request method is GET, retrieve the user's data to pre-fill the form
            cursor.execute('SELECT * FROM users WHERE id = %s', (id,))
            user = cursor.fetchone()
    
    # Render the appropriate template based on user role
    if session['role'] == 'admin':
        return render_template('accounts/edit_user.html', role=session.get('role'), username=session.get('username'), user=user)
    elif session['role'] == 'Head of Department':
        return render_template('accounts/moderator/edit_user.html', role=session.get('role'), username=session.get('username'), user=user)









@users_bp.route('/delete_user/<int:id>', methods=['GET'])
def delete_user(id):

    # Get DB connection using context manager
    with get_db_connection() as connection:
        with connection.cursor() as cursor:
            try:
                cursor.execute('DELETE FROM users WHERE id = %s', (id,))
                connection.commit()
                flash('User deleted successfully!', 'success')
            except mysql.connector.Error as err:
                flash(f'Error: {err}', 'danger')

    return redirect(url_for('auth.manage_users'))






@users_bp.route('/edit_user_profile/<int:id>', methods=['GET', 'POST'])
def edit_user_profile(id):
    # Get DB connection using context manager
    with get_db_connection() as connection:
        with connection.cursor(dictionary=True) as cursor:
            if request.method == 'POST':
                # Get form data, but exclude role from this part
                username = request.form.get('username')
                first_name = request.form.get('first_name')
                last_name = request.form.get('last_name')
                other_name = request.form.get('other_name')
                password = request.form.get('password')
                profile_image = request.files.get('profile_image')

                # Handle password update, only if password is provided
                if password:
                    hashed_password = generate_password_hash(password)
                else:
                    cursor.execute('SELECT password FROM users WHERE id = %s', (id,))
                    hashed_password = cursor.fetchone()['password']

                # Handle profile image upload if a new image is provided
                if profile_image and allowed_file(profile_image.filename):
                    # Generate a secure filename
                    filename = secure_filename(profile_image.filename)
                    # Define the path where the file will be saved
                    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                    # Save the file to the server
                    profile_image.save(file_path)
                    # Use the filename in the database
                    profile_image = filename
                else:
                    # Keep the current profile image if no new image is uploaded
                    cursor.execute('SELECT profile_image FROM users WHERE id = %s', (id,))
                    profile_image = cursor.fetchone()['profile_image']

                # Update user information in the database, excluding 'role'
                try:
                    cursor.execute(''' 
                        UPDATE users 
                        SET username = %s, first_name = %s, last_name = %s, other_name = %s, password = %s, profile_image = %s 
                        WHERE id = %s
                    ''', (username, first_name, last_name, other_name, hashed_password, profile_image, id))
                    connection.commit()
                    flash('User updated successfully!', 'success')
                except mysql.connector.Error as err:
                    flash(f'Error: {err}', 'danger')

                # Redirect to the user management page after successful update
                return redirect(url_for('auth.manage_users'))

            # If the request method is GET, retrieve the user's data to pre-fill the form
            cursor.execute('SELECT * FROM users WHERE id = %s', (id,))
            user = cursor.fetchone()

    if session['role'] == 'admin':
        return render_template('accounts/edit_user_profile.html', role=session.get('role'), username=session.get('username'), user=user)
    elif session['role'] == 'Head of Department':
        return render_template('accounts/h_edit_user_profile.html', role=session.get('role'), username=session.get('username'), user=user)
    else:
        return render_template('accounts/a_edit_user_profile.html', role=session.get('role'), username=session.get('username'), user=user)


