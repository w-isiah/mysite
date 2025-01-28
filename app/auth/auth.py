from datetime import timedelta, datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session, jsonify, current_app
from app.db import get_db_connection  # Assuming you have a custom db module to manage DB connections
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector

# Initialize the blueprint
users_bp = Blueprint('auth', __name__)

# Ensure the Flask app secret key is set to manage sessions
# Add this in your Flask app initialization, for example:
# app.secret_key = 'your_secret_key'

# Set session lifetime to 30 minutes (can be configured based on needs)
'''users_bp.before_app_request
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

                if user and check_password_hash(user['password'], password):
                    session['loggedin'] = True
                    session['id'] = user['id']
                    session['username'] = user['username']
                    session['role'] = user['role']
                    session.permanent = True  # Make session permanent
                    session['last_activity'] = datetime.utcnow()  # Set last activity time
                    flash('Login successful!', 'success')
                    return redirect(url_for('main.index'))  # Redirect to the main page
                else:
                    flash('Invalid username or password.', 'danger')

    return render_template('accounts/login.html')


@users_bp.route('/logout')
def logout():
    session.clear()  # Clear session data
    flash('You have logged out successfully.', 'success')
    return redirect(url_for('auth.login'))  # Redirect to login


@users_bp.route('/manage_users')
def manage_users():
    if 'role' not in session or session['role'] != 'admin':
        flash('You are not authorized to access this page.', 'danger')
        return redirect(url_for('main.index'))

    try:
        # Get DB connection using context manager
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                # Fetch all users that are not admins
                cursor.execute("SELECT * FROM users WHERE role != 'admin'")
                users = cursor.fetchall()

                # Get the count of users that are not admins
                cursor.execute("SELECT COUNT(*) FROM users WHERE role != 'admin'")
                num = cursor.fetchone()  # Extract count value from the tuple

    except Exception as e:
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))

    # Safely access session variables
    return render_template('accounts/manage_users.html', username=session.get('username'), role=session.get('role'), num=num, users=users)


@users_bp.route('/api/manage_users_count', methods=['GET'])
def get_users_count():
    try:
        # Get DB connection using context manager
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                # Get the count of users that are not admins
                cursor.execute("SELECT COUNT(*) FROM users WHERE role != 'admin'")
                num = cursor.fetchone()[0]  # Extract count value from the tuple

        # Return the count as a JSON response
        return jsonify({"count": num})

    except Exception as e:
        # Handle any errors and return a failure message
        return jsonify({"error": f"An error occurred while fetching data: {str(e)}"}), 500


@users_bp.route('/add_user', methods=['GET', 'POST'])
def add_user():
    if 'role' not in session or session['role'] != 'admin':
        flash('You are not authorized to access this page.', 'danger')
        return redirect(url_for('main.index'))

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        role = request.form['role']

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
                    cursor.execute('INSERT INTO users (username, password, role) VALUES (%s, %s, %s)',
                                   (username, hashed_password, role))
                    connection.commit()
                    flash('User added successfully!', 'success')
                except mysql.connector.Error as err:
                    flash(f'Error: {err}', 'danger')

        return redirect(url_for('auth.manage_users'))  # Redirect to user management page

    return render_template('accounts/add_user.html', role=session.get('role'), username=session.get('username'))  # Render the add user form


@users_bp.route('/edit_user/<int:id>', methods=['GET', 'POST'])
def edit_user(id):
    if 'role' not in session or session['role'] != 'admin':
        flash('You are not authorized to access this page.', 'danger')
        return redirect(url_for('main.index'))

    # Get DB connection using context manager
    with get_db_connection() as connection:
        with connection.cursor(dictionary=True) as cursor:
            if request.method == 'POST':
                username = request.form['username']
                password = request.form['password']
                role = request.form['role']
                
                # Password hashing for security
                hashed_password = generate_password_hash(password)

                try:
                    # Update user information in the database
                    cursor.execute('UPDATE users SET username = %s, password = %s, role = %s WHERE id = %s',
                                   (username, hashed_password, role, id))
                    connection.commit()

                    # Flash success message
                    flash('User updated successfully!', 'success')

                except mysql.connector.Error as err:
                    # Flash error message if something goes wrong with the database query
                    flash(f'Error: {err}', 'danger')

                return redirect(url_for('auth.manage_users'))

            # If the request method is GET, retrieve the user's data
            cursor.execute('SELECT * FROM users WHERE id = %s', (id,))
            user = cursor.fetchone()

    return render_template('accounts/edit_user.html', role=session.get('role'), username=session.get('username'), user=user)


@users_bp.route('/delete_user/<int:id>', methods=['GET'])
def delete_user(id):
    if 'role' not in session or session['role'] != 'admin':
        flash('You are not authorized to access this page.', 'danger')
        return redirect(url_for('main.index'))

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
