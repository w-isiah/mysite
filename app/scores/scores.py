from datetime import timedelta, datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session, jsonify, current_app
from app.db import get_db_connection  # Assuming you have a custom db module to manage DB connections
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector

# Initialize the blueprint
scores_bp = Blueprint('scores', __name__)

from flask import session, flash, redirect, url_for, render_template, request
import logging

from flask import session, flash, redirect, url_for, render_template, request
import logging

@scores_bp.route("/save_scores", methods=["POST"])
def save_scores():
    role0 = session.get('role')
    
    # Ensure the user is logged in by checking the session
    if "id" not in session:
        flash("You must be logged in to submit scores.", "danger")
        return redirect(url_for("auth.login"))

    # Connect to the database
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Get form data
        assessor_id = session["id"]
        student_id = request.form.get("student_teacher_id")
        term_id = request.form.get("term_id")
        school_id = request.form.get("school_id")

        print(f"Received data: student_id={student_id}, term_id={term_id}, school_id={school_id}")

        # Get the list of aspect ids, scores, comments, and criteria ids
        aspect_ids = request.form.getlist("aspect_id[]")
        scores = request.form.getlist("score[]")
        comments = request.form.getlist("comment[]")
        criteria_ids = request.form.getlist("criteria_id[]")

        # Validate form inputs
        if not all([student_id, term_id, aspect_ids, scores, comments, criteria_ids, school_id]):
            flash("Missing required fields. Please check your input.", "danger")
            return redirect(url_for("main.index"))

        # Check if lengths of the lists match
        if len(aspect_ids) != len(scores) or len(scores) != len(comments) or len(comments) != len(criteria_ids):
            flash("Data mismatch error. Please ensure all inputs align.", "danger")
            return redirect(url_for("main.index"))

        # Convert scores to floats and calculate the sum
        try:
            scores_float = [float(score) for score in scores]
            total_score = sum(scores_float)
            print(f"Total score: {total_score}")
        except ValueError as e:
            flash(f"Error converting scores: {str(e)}", "danger")
            return redirect(url_for("main.index"))

        # Calculate max score (assuming 3 points per criterion)
        max_score = 3 * len(criteria_ids)  # Assuming 3 points per criterion, adjust if needed
        print(f"Max score: {max_score}")

        if max_score > 0:
            # Calculate the total percentage for the overall evaluation
            total_percentage = (total_score / max_score) * 100  # Calculate percentage
            total_percentage = round(min(total_percentage, 100), 0)  # Cap the percentage to 100%

            # Prepare data to insert into the marks table (only one record per evaluation)
            cursor.execute("""
                INSERT INTO marks (student_id, assessor_id, term_id, school_id, marks, assessment_type, date_awarded)
                VALUES (%s, %s, %s, %s, %s, %s, CURDATE())
                ON DUPLICATE KEY UPDATE marks = %s, date_awarded = CURDATE()
            """, (student_id, assessor_id, term_id, school_id, total_percentage, "system", total_percentage))

            # Commit after the insert
            conn.commit()
            print(f"Inserted into marks: student_id={student_id}, assessor_id={assessor_id}, total_percentage={total_percentage}")
        else:
            flash("Invalid max score calculated. No data inserted into marks.", "danger")
            return redirect(url_for("main.index"))

        # Insert data into the scores table for individual aspects and criteria (including school_id)
        data_to_insert_scores = []
        for idx, criteria_id in enumerate(criteria_ids):
            score = scores_float[idx]
            comment = comments[idx]
            aspect_id = aspect_ids[idx]

            # Prepare data for the scores table, now including school_id
            data_to_insert_scores.append(
                (student_id, aspect_id, criteria_id, assessor_id, term_id, school_id, score, comment)
            )

        # Insert into scores table
        cursor.executemany("""
            INSERT INTO scores (student_id, aspect_id, criteria_id, assessor_id, term_id, school_id, score, comment)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, data_to_insert_scores)
        conn.commit()

        print("Inserted into scores table successfully.")

        flash("Scores saved successfully!", "success")

        # Render a summary page with the saved data based on the role
        if role0 == "Head of Department":
            return render_template("scores/evaluation_summary.html", username=session['username'], role=session['role'], student_id=student_id, term_id=term_id)
        elif role0 == "School Practice Supervisor":
            return render_template("scores/assessor/evaluation_summary.html", username=session['username'], role=session['role'], student_id=student_id, term_id=term_id)
        else:
            flash("Unauthorized role. Cannot view the summary.", "danger")
            return redirect(url_for("main.index"))

    except Exception as e:
        logging.error(f"An error occurred while saving scores: {str(e)}")
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

