from datetime import datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.db import get_db_connection

# Initialize blueprint for ratings
ratings_bp = Blueprint('ratings', __name__)


@ratings_bp.route('/manage_ratings', methods=['GET'])
def manage_ratings():
    try:
        # Use a context manager for database connection
        with get_db_connection() as conn:
            # Create a cursor to execute queries
            cursor = conn.cursor(dictionary=True)
            # Execute the query to fetch all ratings, ordered by 'mark' ascending
            cursor.execute("SELECT * FROM ratings ORDER BY mark ASC")
            ratings = cursor.fetchall()  # Fetch all ratings from the database
        
        # Render the template with ratings and session data
        return render_template('ratings/manage_ratings.html', 
                               username=session.get('username'), 
                               role=session.get('role'), 
                               ratings=ratings)
    
    except Exception as e:
        # Handle any exceptions that occur during the database operation
        return f"An error occurred: {e}", 500

# Route to add a new rating
@ratings_bp.route('/add_rating', methods=['GET', 'POST'])
def add_rating():
    if request.method == 'POST':
        rating_name = request.form['rating_name']
        description = request.form['description']
        mark = request.form['mark']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO ratings (rating, description, mark) VALUES (%s, %s, %s)",
                       (rating_name, description, mark))
        conn.commit()
        conn.close()

        flash('Rating added successfully!', 'success')
        return redirect(url_for('ratings.manage_ratings'))

    return render_template('ratings/add_rating.html')

# Route to edit an existing rating
@ratings_bp.route('/edit_rating/<int:rating_id>', methods=['GET', 'POST'])
def edit_rating(rating_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Fetch the rating based on the rating_id
    cursor.execute("SELECT * FROM ratings WHERE id = %s", (rating_id,))
    rating = cursor.fetchone()

    # If rating is not found, redirect with an error
    if not rating:
        flash('Rating not found!', 'danger')
        return redirect(url_for('ratings.manage_ratings'))

    # If the form is submitted (POST request)
    if request.method == 'POST':
        rating_name = request.form['rating_name']
        description = request.form['description']
        mark = request.form['mark']

        # Update the rating in the database
        cursor.execute("""
            UPDATE ratings
            SET rating = %s, description = %s, mark = %s
            WHERE id = %s
        """, (rating_name, description, mark, rating_id))  # Pass values, not dict
        conn.commit()

        # Close the connection
        conn.close()

        # Flash success message and redirect
        flash('Rating updated successfully!', 'success')
        return redirect(url_for('ratings.manage_ratings'))

    # Close the connection and render the edit page
    conn.close()
    return render_template('ratings/edit_ratings.html', rating=rating)


# Route to delete a rating
@ratings_bp.route('/delete_rating/<int:rating_id>',  methods=['GET', 'POST'])
def delete_rating(rating_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM ratings WHERE id = %s", (rating_id,))
    conn.commit()
    conn.close()

    flash('Rating deleted successfully!', 'danger')
    return redirect(url_for('ratings.manage_ratings'))
