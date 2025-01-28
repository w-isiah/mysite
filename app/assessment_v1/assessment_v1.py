from datetime import timedelta, datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session, jsonify, current_app
from app.db import get_db_connection  # Now importing from the db module
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector
from psycopg2 import Error
import pandas as pd
from flask import send_file
import io
import logging
# Initialize blueprint
assessment_bp = Blueprint('assessment', __name__)

# Assessment check route - for viewing the status of assessments for students
@assessment_bp.route('/assessment_check')
def assessment_check():


    # Get the logged-in user's ID (assessor)
    
    username=session['username']
    role0=session['role']
    role2='School Practice Supervisor'
    role1='Head OF Department'
    assessor_id = session.get('id')
    
    if not assessor_id:
        return redirect(url_for('auth.login'))  # Redirect to login page if not authenticated

    query = """
    SELECT s.id AS student_id,
           s.student_teacher,
           s.year,
           s.programme_id,
           s.reg_no,
           s.subject,
           s.term_id,
           s.class_name,
           s.topic,
           s.subtopic,
           s.teaching_time,
           IF(sc.assessor_id = %s, 'assessed', 'unassessed') AS status
    FROM student_info s
    LEFT JOIN scores sc ON s.id = sc.student_id
    GROUP BY s.id, s.student_teacher, s.year, s.programme_id, s.reg_no, s.subject,
             s.term_id, s.class_name, s.topic, s.subtopic, s.teaching_time
    """
    
    try:
        # Use context manager to handle connection and cursor to prevent leakage
        with get_db_connection() as conn:
            with conn.cursor(dictionary=True) as cursor:
                cursor.execute(query, (assessor_id,))
                data = cursor.fetchall()  # Fetch all assessment data
    except Exception as e:
        # Log error and show a friendly message
        current_app.logger.error(f"Error fetching assessment data: {e}")
        return render_template('error.html', message="An error occurred while retrieving data.")
    if role0==role1:
        return render_template('assessment_v1/assessment_check.html', data=data)
    elif role0==role2:
        return render_template('assessment_v1/assessor/assessment_check.html', data=data)








@assessment_bp.route('/check_student', methods=['GET', 'POST'])
def check_student():
    role = session.get('role')  # Get the logged-in user's role
    user_id = session.get('id')  # Get the logged-in user's ID
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    if not user_id:
        return redirect(url_for('login'))  # Redirect if the user is not logged in

    try:
        if request.method == 'POST':
            reg_no = request.form.get('reg_no')  # Get registration number from form input

            # Fetch student details
            cursor.execute("SELECT * FROM student_info WHERE reg_no = %s", (reg_no,))
            student = cursor.fetchone()

            if not student:
                return render_student_template(role, message="No student found with the given registration number.")

            # Fetch scores for the student assessed by the logged-in user
            cursor.execute("""
                SELECT si.student_teacher, SUM(s.score) AS score
                FROM student_info si
                JOIN scores s ON si.id = s.student_id
                JOIN users u ON s.assessor_id = u.id
                WHERE si.reg_no = %s AND u.id = %s
                GROUP BY si.student_teacher
            """, (reg_no, user_id))
            mark = cursor.fetchone()

            # Fetch the maximum possible score for the student
            cursor.execute("""
                SELECT 3 * COUNT(*) AS max_score
                FROM scores
                WHERE assessor_id = %s AND student_id = %s
            """, (user_id, student['id']))
            max_score_data = cursor.fetchone()
            max_score = max_score_data['max_score'] if max_score_data else 0

            if mark and mark.get('score') is not None:
                # Calculate the percentage score
                score = mark['score']
                total_percentage = (score / max_score) * 100 if max_score > 0 else 0
                total = round(min(total_percentage, 100), 2)  # Cap the percentage to 100
                logging.info(f"Score: {score}, Max Score: {max_score}, Percentage: {total_percentage}")
                return render_student_template(role, student=student, mark=mark, total=total)
            else:
                return render_student_template(role, student=student, message="No scores found for this student.")

        # Handle GET requests
        return render_student_template(role)

    except Exception as e:
        logging.error(f"Error occurred: {e}")
        return render_student_template(role, message="An error occurred while processing the request.")
    finally:
        cursor.close()
        connection.close()



def render_student_template(role, **kwargs):
    """
    Helper function to render templates based on the user's role.
    """
    template_base = 'student_assessment'
    if role == 'Head OF Department':
        template = f'{template_base}/check_student.html'
    elif role == 'School Practice Supervisor':
        template = f'{template_base}/assessor/check_student.html'
    else:
        return redirect(url_for('auth.login'))

    return render_template(template, username=session.get('username'), role=role, **kwargs)











@assessment_bp.route('/assess_v1/<int:student_id>', methods=['GET', 'POST'])
def assess_v1(student_id):
    role0 = session.get('role')
    # Establish connection to the database
    conn = get_db_connection()

    try:
        # Fetch student data
        with conn.cursor(dictionary=True) as cursor:
            cursor.execute("SELECT * FROM student_info WHERE id = %s", (student_id,))
            student = cursor.fetchone()

        # Check if the student exists
        if not student:
            return "Student not found", 404  # Return a 404 error if the student does not exist

        # Fetch assessment criteria data with aspect_id included
        with conn.cursor(dictionary=True) as cursor:
            cursor.execute("""
                SELECT s.aspect_id, s.aspect_name, ac.criteria_id, ac.criteria_name, s.description, s.competence
                FROM aspect s
                JOIN assessment_criteria ac ON s.aspect_id = ac.aspect_id
            """)
            data = cursor.fetchall()

    finally:
        conn.close()  # Close the database connection

    # Render the template with the fetched data
    if role0 == 'Head OF Department':
        return render_template('assessment_v1/add_assessment.html',username=session['username'],role=session['role'], student_id=student_id, data=data, student=student)
    elif role0 == 'School Practice Supervisor':
        return render_template('assessment_v1/assessor/add_assessment.html', username=session['username'],role=session['role'],student_id=student_id, data=data, student=student)

@assessment_bp.route('/assessment_report', methods=['GET', 'POST'])
def assessment_report():
    try:
        # Connect to the database
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch Programmes and Terms for filters
        cursor.execute("SELECT id, programme_name FROM programmes")
        programmes = cursor.fetchall()

        cursor.execute("SELECT id, term, year FROM terms ORDER BY year, term")
        terms = cursor.fetchall()

        # Initialize variables
        pivot_data = []  # Initialize an empty list for pivoted data
        assessors = []   # List of assessors
        programme_id = None
        term_id = None
        reg_no = None

        if request.method == 'POST':
            # Get filter values from the form
            programme_id = request.form.get('programme_id')
            term_id = request.form.get('term_id')
            reg_no = request.form.get('reg_no')

            # SQL query to fetch assessment data, including students without assessments
            query = """
                SELECT
                    si.id AS student_id,
                    si.reg_no,
                    si.student_teacher AS student_name,
                    si.subject,
                    t.term,
                    t.year,
                    u.username AS assessor,
                    COALESCE(ROUND((SUM(s.score) / (
                        SELECT 3 * COUNT(*) 
                        FROM scores 
                        WHERE assessor_id = u.id AND student_id = si.id
                    )) * 100, 2), 0) AS total_score,
                    CASE
                        WHEN SUM(s.score) IS NULL THEN 'Not Assessed'
                        ELSE 'Assessed'
                    END AS status
                FROM
                    student_info si
                LEFT JOIN
                    scores s ON si.id = s.student_id
                LEFT JOIN
                    users u ON s.assessor_id = u.id
                LEFT JOIN
                    terms t ON si.term_id = t.id
                WHERE 1=1
            """

            # Add filters dynamically
            filters = []
            if programme_id:
                query += " AND si.programme_id = %s"
                filters.append(programme_id)
            if term_id:
                query += " AND si.term_id = %s"
                filters.append(term_id)
            if reg_no:
                query += " AND si.reg_no LIKE %s"
                filters.append(f"%{reg_no}%")

            # Finalize query with grouping
            query += """
                GROUP BY
                    si.id, si.reg_no, si.student_teacher, si.subject, t.term, t.year, u.username
                ORDER BY si.reg_no
            """

            # Execute query
            cursor.execute(query, tuple(filters))
            data = cursor.fetchall()

            # Transform data into pivot format
            if data:
                df = pd.DataFrame(data)

                # Extract unique assessors
                assessors = df['assessor'].dropna().unique().tolist()

                # Pivot data: assessors as columns
                pivot_table = df.pivot_table(
                    index=["reg_no", "student_name", "subject", "term", "year", "status"],
                    columns="assessor",
                    values="total_score",
                    aggfunc="max",
                    fill_value=0
                ).reset_index()

                # Add average score
                score_columns = [
                    col for col in pivot_table.columns
                    if col not in ['reg_no', 'student_name', 'subject', 'term', 'year', 'status']
                ]
                pivot_table['average_score'] = pivot_table[score_columns].replace(0, pd.NA).mean(axis=1)

                # Convert pivot table to dictionary
                pivot_data = pivot_table.to_dict(orient="records")

                # Handle export to Excel
                if 'export_excel' in request.form:
                    output = io.BytesIO()
                    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
                        pivot_table.to_excel(writer, index=False, sheet_name="Assessment Data")
                    output.seek(0)
                    return send_file(
                        output,
                        as_attachment=True,
                        download_name="assessment_data.xlsx",
                        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                    )

    except Exception as e:
        logging.error(f"Error occurred: {e}")
        return jsonify({"status": "error", "message": str(e)}), 500

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

    # Render the template
    return render_template(
        'assessment_v1/assessment_report.html',
        role=session.get('role'),
        username=session.get('username'),
        programmes=programmes,
        terms=terms,
        data=pivot_data,
        assessors=assessors,
        programme_id=programme_id,
        term_id=term_id,
        reg_no=reg_no
    )
