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

    if "id" not in session:
        flash("You must be logged in to submit scores.", "danger")
        return redirect(url_for("auth.login"))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        assessor_id = session["id"]
        student_id = request.form.get("student_teacher_id")
        term_id = request.form.get("term_id")
        school_id = request.form.get("school_id")

        print(f"Received data: student_id={student_id}, term_id={term_id}, school_id={school_id}")

        aspect_ids = request.form.getlist("aspect_id[]")
        scores = request.form.getlist("score[]")
        criteria_ids = request.form.getlist("criteria_id[]")
        comment = request.form.get("comment")  # Get the comment text from the form

        if not all([student_id, term_id, aspect_ids, scores, criteria_ids, school_id, comment]):
            flash("Missing required fields. Please check your input.", "danger")
            return redirect(url_for("main.index"))

        if len(aspect_ids) != len(scores) or len(scores) != len(criteria_ids):
            flash("Data mismatch error. Please ensure all inputs align.", "danger")
            return redirect(url_for("main.index"))

        try:
            scores_float = [float(score) for score in scores]
            total_score = sum(scores_float)
            print(f"Total score: {total_score}")
        except ValueError as e:
            flash(f"Error converting scores: {str(e)}", "danger")
            return redirect(url_for("main.index"))

        max_score = 3 * len(criteria_ids)
        print(f"Max score: {max_score}")

        if max_score > 0:
            total_percentage = (total_score / max_score) * 100
            total_percentage = round(min(total_percentage, 100), 0)

            cursor.execute("""
                INSERT INTO marks (student_id, assessor_id, term_id, school_id, marks, assessment_type, date_awarded)
                VALUES (%s, %s, %s, %s, %s, %s, CURDATE())
                ON DUPLICATE KEY UPDATE marks = %s, date_awarded = CURDATE()
            """, (student_id, assessor_id, term_id, school_id, total_percentage, "system", total_percentage))

            conn.commit()
            print(f"Inserted into marks: student_id={student_id}, assessor_id={assessor_id}, total_percentage={total_percentage}")
        else:
            flash("Invalid max score calculated. No data inserted into marks.", "danger")
            return redirect(url_for("main.index"))

        # Insert the comment into the general_comments table
        cursor.execute("""
            INSERT INTO general_comments (student_id, assessor_id, term_id, comment)
            VALUES (%s, %s, %s, %s)
        """, (student_id, assessor_id, term_id, comment))

        conn.commit()
        print(f"Inserted into general_comments: student_id={student_id}, assessor_id={assessor_id}, comment={comment}")

        data_to_insert_scores = []
        for idx, criteria_id in enumerate(criteria_ids):
            score = scores_float[idx]
            aspect_id = aspect_ids[idx]

            data_to_insert_scores.append(
                (student_id, aspect_id, criteria_id, assessor_id, term_id, school_id, score)
            )

        cursor.executemany("""
            INSERT INTO scores (student_id, aspect_id, criteria_id, assessor_id, term_id, school_id, score)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, data_to_insert_scores)
        conn.commit()

        print("Inserted into scores table successfully.")

        flash("Scores and comments saved successfully!", "success")

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
        conn.close()











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

