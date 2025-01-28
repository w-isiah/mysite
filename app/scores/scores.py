from datetime import timedelta, datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session, jsonify, current_app
from app.db import get_db_connection  # Assuming you have a custom db module to manage DB connections
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector

# Initialize the blueprint
scores_bp = Blueprint('scores', __name__)




@scores_bp.route("/save_scores", methods=["POST"])
def save_scores():
    role0 = session.get('role')
    # Ensure the user is logged in by checking the session
    if "id" not in session:
        flash("You must be logged in to submit scores.", "danger")
        return redirect(url_for("auth.login"))

    # Connect to the database
    conn = get_db_connection()

    try:
        # Get form data
        assessor_id = session["id"]
        student_id = request.form.get("student_teacher_id")
        term_id = request.form.get("term_id")

        # Get the list of aspect ids, scores, comments, and criteria ids
        aspect_ids = request.form.getlist("aspect_id[]")  # List of aspect IDs
        scores = request.form.getlist("score[]")  # List of scores
        comments = request.form.getlist("comment[]")  # List of comments
        criteria_ids = request.form.getlist("criteria_id[]")  # List of criteria IDs

        # Validate form inputs
        if not all([student_id, term_id, aspect_ids, scores, comments, criteria_ids]):
            flash("Missing required fields. Please check your input.", "danger")
            return redirect(url_for("main.index"))

        # Check if lengths of the lists match
        if len(aspect_ids) != len(scores) or len(scores) != len(comments) or len(comments) != len(criteria_ids):
            flash("Data mismatch error. Please ensure all inputs align.", "danger")
            return redirect(url_for("main.index"))

        # Prepare data for insertion
        data_to_insert = []
        saved_data = []  # Store data to display after saving
        for idx, criteria_id in enumerate(criteria_ids):
            try:
                score = float(scores[idx])  # Ensure score is numeric
                if not (1 <= score <= 3):  # Validation for score range (1-3)
                    raise ValueError(f"Score must be between 1 and 3 for criteria {criteria_id}.")
            except ValueError as e:
                flash(f"Invalid score for criteria {criteria_id}: {e}", "danger")
                return redirect(url_for("main.index"))

            comment = comments[idx]
            if len(comment) > 255:  # Enforce comment length limit
                flash(f"Comment for criteria {criteria_id} exceeds 255 characters.", "danger")
                return redirect(url_for("main.index"))

            aspect_id = aspect_ids[idx]
            data_to_insert.append(
                (student_id, aspect_id, criteria_id, assessor_id, term_id, score, comment)
            )

            # Save for display
            saved_data.append(
                {
                    "aspect_name": f"Aspect {aspect_id}",  # Replace with actual aspect name from DB if needed
                    "criteria_name": f"Criteria {criteria_id}",
                    "score": score,
                    "comment": comment,
                }
            )

        # Insert data into the database
        with conn.cursor(dictionary=True) as cursor:
            cursor.executemany(
                """
                INSERT INTO scores (student_id, aspect_id, criteria_id, assessor_id, term_id, score, comment)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                """,
                data_to_insert,
            )

        conn.commit()
        flash("Scores saved successfully!", "success")

        # Render a summary page with the saved data
        if role0 == "Head OF Department":
            return render_template("scores/evaluation_summary.html",username=session['username'], role=session['role'], student_id=student_id, term_id=term_id, saved_data=saved_data)
        elif role0 == "School Practice Supervisor":
            return render_template("scores/assessor/evaluation_summary.html", username=session['username'], role=session['role'],student_id=student_id, term_id=term_id, saved_data=saved_data)
        else:
            flash("Unauthorized role. Cannot view the summary.", "danger")
            return redirect(url_for("main.index"))

    except Exception as e:
        flash(f"An error occurred while saving scores: {str(e)}", "danger")
        return redirect(url_for("main.index"))

    finally:
        conn.close()  # Always close the connection





@scores_bp.route("/edit_score/<int:score_id>", methods=["GET", "POST"])
def edit_score(score_id):
    conn = get_db_connection()
    try:
        if request.method == "POST":
            # Handle form submission
            score = request.form.get("score")
            comment = request.form.get("comment")

            # Validate input
            try:
                score = float(score)
            except ValueError:
                flash("Invalid score. Please enter a numeric value.", "danger")
                return redirect(url_for("edit_score", score_id=score_id))

            if len(comment) > 255:
                flash("Comment is too long. Maximum 255 characters allowed.", "danger")
                return redirect(url_for("scores.edit_score", score_id=score_id))

            # Update the database
            with conn.cursor(dictionary=True) as cursor:
                cursor.execute(
                    """
                    UPDATE scores
                    SET score = %s, comment = %s
                    WHERE id = %s
                    """,
                    (score, comment, score_id),
                )
                conn.commit()
                flash("Score updated successfully.", "success")
                return redirect(url_for("student_data", student_id=request.form.get("student_id")))

        # Fetch the record for pre-filling the form
        with conn.cursor(dictionary=True) as cursor:
            cursor.execute(
                """
                SELECT scores.*, aspect.aspect_name as aspect_name, assessment_criteria.criteria_name as criteria_name
                FROM scores
                INNER JOIN aspect ON scores.aspect_id = aspect.aspect_id
                INNER JOIN assessment_criteria ON scores.criteria_id = assessment_criteria.criteria_id
                WHERE scores.id = %s
                """,
                (score_id,),
            )
            record = cursor.fetchone()
            if not record:
                flash("Record not found.", "danger")
                return redirect(url_for("main.index"))

        return render_template("scores/edit_score.html", username=session['username'], role=session['role'],record=record)

    except Exception as e:
        flash(f"Error editing score: {str(e)}", "danger")
        return redirect(url_for("main.index"))

    finally:
        conn.close()

