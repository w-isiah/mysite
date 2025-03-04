from datetime import datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session,jsonify
from app.db import get_db_connection
import os
import pandas as pd
from flask import Flask, render_template, request, redirect, url_for, flash, send_file
from werkzeug.utils import secure_filename
from io import BytesIO
from app import app
import mysql.connector  # Import mysql.connector at the top of your file
from mysql.connector import Error  # Import the Error class from mysql.connector
ALLOWED_EXTENSIONS = {'xlsx', 'xls'}
# Initialize blueprint
student_bp = Blueprint('student', __name__)


    

def fetch_programmes_and_terms():
    """Fetch programmes and terms for dropdowns."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, programme_name FROM programmes")
    programmes = cursor.fetchall()
    cursor.execute("SELECT id, term FROM terms")
    terms = cursor.fetchall()
    cursor.close()
    conn.close()
    return programmes, terms


@student_bp.route('/manage_student', methods=['GET', 'POST'])
def manage_student():
    try:
        # Database connection and fetching programmes and terms
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        programmes, terms = fetch_programmes_and_terms()

        # Base query for student information
        query = """
                            SELECT 
                si.id AS student_id,
                si.student_teacher,  
                si.reg_no, 
                si.subject,
                si.class_name, 
                si.topic, 
                si.subtopic, 
                si.teaching_time,
                p.programme_name, 
                p.description AS programme_description,
                t.term,
                s.name AS school_name  -- Only select the school name
            FROM student_info si
            LEFT JOIN programmes p ON si.programme_id = p.id
            LEFT JOIN terms t ON si.term_id = t.id
            LEFT JOIN schools s ON si.school_id = s.id  -- Join to the schools table

            """

        params = []

        if request.method == 'POST':
            conditions = []

            # Handle dynamic filtering
            if programme := request.form.get('programme'):
                conditions.append("si.programme_id = %s")
                params.append(programme)
            
            if term := request.form.get('term'):
                conditions.append("si.term_id = %s")
                params.append(term)

            if reg_no := request.form.get('reg_no'):
                conditions.append("si.reg_no LIKE %s")
                params.append(f"%{reg_no}%")

            if conditions:
                query += " WHERE " + " AND ".join(conditions)

            # Debug: Print the query and parameters to ensure correctness
            #print("Executing Query:", query)
            #print("With Parameters:", params)

            cursor.execute(query, params)
            student_info = cursor.fetchall()

            # Debug: Check the fetched data
            #print("Fetched Student Info:", student_info)

        else:
            student_info = []

        cursor.close()
        conn.close()

        # Ensure that student_info is being passed correctly to the template
        #print("Student Info for Rendering:", student_info)

        # Selecting the correct template based on user role
        template = 'student/manage_student.html' if session['role'] == "Head of Department" else 'student/assessor_manage_student.html'
        return render_template(template, username=session['username'], role=session['role'],
                               student_info=student_info, programmes=programmes, terms=terms)
    
    except Exception as e:
        # Log the error for debugging and provide feedback to the user
        print(f"Error occurred: {str(e)}")  # Debug: Log error
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))










@student_bp.route('/add_student', methods=['GET', 'POST'])
def add_student():
    # Establish a database connection
    connection = get_db_connection()
    
    if not connection:
        flash('Failed to connect to the database.', 'danger')
        return render_template('student/add_student.html')

    cursor = connection.cursor(dictionary=True)

    # Fetch dropdown data for programmes, terms, and schools
    cursor.execute('SELECT id, programme_name FROM programmes')
    programmes = cursor.fetchall()
    
    cursor.execute('SELECT id, term FROM terms')
    terms = cursor.fetchall()

    cursor.execute('SELECT id, academic_year FROM academic_year')
    academic_years = cursor.fetchall()

    cursor.execute('SELECT id, name FROM schools')
    schools = cursor.fetchall()

    cursor.execute('SELECT id, study_year FROM study_year')
    study_years = cursor.fetchall()

    if request.method == 'POST':
        # Retrieve form data
        student_teacher = request.form['student_teacher']
        programme_id = request.form['programme_id']
        reg_no = request.form['reg_no']
        term_id = request.form['term_id']
        school_id = request.form['school_id']
        subject = request.form['subject']
        class_name = request.form['class']
        teaching_time = request.form['teaching_time']
        topic = request.form['topic']
        subtopic = request.form['subtopic']
        academic_year_id = request.form['academic_year_id']
        study_year_id = request.form['study_year_id']

        try:
            # Check if the registration number already exists
            cursor.execute("SELECT COUNT(*) FROM student_info WHERE reg_no = %s", (reg_no,))
            result = cursor.fetchone()

            if result['COUNT(*)'] > 0:
                flash('This registration number already exists. Please use a different one.', 'danger')
                return render_template('student/add_student.html', study_years=study_years, academic_years=academic_years, schools=schools, programmes=programmes, terms=terms)

            # Insert data into the student_info table
            query = """
                INSERT INTO student_info (
                    student_teacher, programme_id, reg_no, term_id, school_id, subject, 
                    class_name, teaching_time, topic, subtopic, academic_year_id, study_year_id
                ) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (student_teacher, programme_id, reg_no, term_id, school_id, subject, 
                      class_name, teaching_time, topic, subtopic, academic_year_id, study_year_id)

            cursor.execute(query, values)
            connection.commit()  # Commit the transaction

            flash('Student Teacher added successfully!', 'success')
            return redirect(url_for('student.add_student'))

        except mysql.connector.Error as e:
            connection.rollback()  # Rollback on error
            flash(f'Error: {e}', 'danger')
            return render_template('student/add_student.html', study_years=study_years, academic_years=academic_years, schools=schools, programmes=programmes, terms=terms)

        finally:
            cursor.close()  # Always close the cursor after the operation

    # Return the page with dropdown data on GET request
    return render_template('student/add_student.html',  study_years=study_years, academic_years=academic_years, schools=schools, programmes=programmes, terms=terms)

 
 
  




@student_bp.route('/edit_student/<int:student_id>', methods=['GET', 'POST'])
def edit_student(student_id):
    try:
        # Connect to the database
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)

        # Fetch student details from the database
        cursor.execute("SELECT * FROM student_info WHERE id = %s", (student_id,))
        student = cursor.fetchone()

        # Fetch dropdown data for programmes, terms, schools, academic_years, and study_years
        cursor.execute('SELECT id, programme_name FROM programmes')
        programmes = cursor.fetchall()
        
        cursor.execute('SELECT id, term FROM terms')
        terms = cursor.fetchall()

        cursor.execute('SELECT id, name FROM schools')
        schools = cursor.fetchall()

        cursor.execute('SELECT id, academic_year FROM academic_year')
        academic_years = cursor.fetchall()

        cursor.execute('SELECT id, study_year FROM study_year')
        study_years = cursor.fetchall()

        # If student doesn't exist, flash a message and redirect
        if not student:
            flash("Student not found!", "danger")
            return redirect(url_for('student.manage_student'))

        if request.method == 'POST':
            # Collect form data, including academic_year_id and study_year_id
            form_data = {key: request.form[key] for key in ('student_teacher', 'programme_id', 'reg_no', 'term_id', 
                                                            'subject', 'class', 'topic', 'subtopic', 'teaching_time', 
                                                            'school_id', 'academic_year_id', 'study_year_id')}

            # Check if all required fields are filled
            if not all(form_data.values()):
                flash("All fields are required!", "danger")
            else:
                try:
                    # Extract the form values explicitly
                    student_teacher = form_data['student_teacher']
                    programme_id = form_data['programme_id']
                    reg_no = form_data['reg_no']
                    term_id = form_data['term_id']
                    subject = form_data['subject']
                    class_name = form_data['class']
                    topic = form_data['topic']
                    subtopic = form_data['subtopic']
                    teaching_time = form_data['teaching_time']
                    school_id = form_data['school_id']
                    academic_year_id = form_data['academic_year_id']
                    study_year_id = form_data['study_year_id']

                    # Update the student information in the database
                    query = """
                        UPDATE student_info
                        SET student_teacher = %s, programme_id = %s, reg_no = %s, term_id = %s,
                            subject = %s, class_name = %s, topic = %s, subtopic = %s, teaching_time = %s,
                            school_id = %s, academic_year_id = %s, study_year_id = %s
                        WHERE id = %s
                    """
                    # Values must match the placeholders in the SQL query
                    values = (student_teacher, programme_id, reg_no, term_id, subject, class_name, topic, subtopic, 
                              teaching_time, school_id, academic_year_id, study_year_id, student_id)

                    cursor.execute(query, values)
                    connection.commit()

                    flash("Student updated successfully!", "success")
                    return redirect(url_for('main.index'))  # Redirect after successful update

                except Exception as e:
                    flash(f"An error occurred: {str(e)}", "danger")

        cursor.close()
        connection.close()

        # Render the template with student details, programmes, terms, schools, academic_years, and study_years
        return render_template('student/edit_student.html', username=session['username'], student=student, 
                               programmes=programmes, terms=terms, schools=schools, academic_years=academic_years,
                               study_years=study_years)

    except Exception as e:
        flash(f"An error occurred: {str(e)}", "danger")
        return redirect(url_for('main.index'))










@student_bp.route('/a_edit_student/<int:student_id>', methods=['GET', 'POST'])
def a_edit_student(student_id):
    try:
        # Connect to the database
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)

        # Fetch student details from the database
        cursor.execute("SELECT * FROM student_info WHERE id = %s", (student_id,))
        student = cursor.fetchone()

        # If student doesn't exist, flash a message and redirect
        if not student:
            flash("Student not found!", "danger")
            return redirect(url_for('student.manage_student'))

        if request.method == 'POST':
            # Collect form data
            form_data = {
                'subject': request.form.get('subject'),
                'class': request.form.get('class'),
                'topic': request.form.get('topic'),
                'subtopic': request.form.get('subtopic'),
                'teaching_time': request.form.get('teaching_time'),
            }

            # Check if all required fields are filled
            if not all(form_data.values()):
                flash("All fields are required!", "danger")
            else:
                try:
                    # Extract form values explicitly
                    subject = form_data['subject']
                    class_name = form_data['class']
                    topic = form_data['topic']
                    subtopic = form_data['subtopic']
                    teaching_time = form_data['teaching_time']

                    # Update the student information in the database
                    query = """
                        UPDATE student_info
                        SET subject = %s, class_name = %s, topic = %s, subtopic = %s, teaching_time = %s
                        WHERE id = %s
                    """
                    # Values must match the placeholders in the SQL query
                    values = (subject, class_name, topic, subtopic, teaching_time, student_id)

                    cursor.execute(query, values)
                    connection.commit()

                    flash("Student updated successfully!", "success")
                    return redirect(url_for('main.index'))  # Redirect after successful update

                except Exception as e:
                    flash(f"An error occurred: {str(e)}", "danger")

        cursor.close()
        connection.close()

        # Render the template with student details
        return render_template('student/assessor_edit_student.html', username=session['username'], student=student)

    except Exception as e:
        flash(f"An error occurred: {str(e)}", "danger")
        return redirect(url_for('main.index'))












@student_bp.route('/delete_student/<string:get_id>')
def delete_student(get_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("DELETE FROM student_info WHERE id = %s", (get_id,))
        conn.commit()
        flash('Student deleted successfully', 'success')
    except Exception as e:
        flash(f'Error deleting student: {str(e)}', 'danger')
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()






@student_bp.route('/manage_students_api', methods=['GET'])
def manage_student_api():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        if request.method == 'GET':
            # Base query for student information
            query = """
                SELECT 
                    si.id AS student_id,
                    si.student_teacher,  
                    si.reg_no, 
                    si.subject,
                    si.class_name, 
                    si.topic, 
                    si.subtopic, 
                    si.teaching_time,
                    p.programme_name, 
                    p.description AS programme_description,
                    t.term
                FROM student_info si
                JOIN programmes p ON si.programme_id = p.id
                JOIN terms t ON si.term_id = t.id
            """

            # Execute the query to fetch all students
            cursor.execute(query)
            students = cursor.fetchall()

            return jsonify({'students': students}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        conn.close()
















@student_bp.route('/register_student/<int:student_id>', methods=['GET', 'POST'])
def register_student(student_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch the student's current details
        cursor.execute("SELECT * FROM student_info WHERE id = %s", (student_id,))
        student = cursor.fetchone()

        # Fetch terms for the dropdown
        cursor.execute("SELECT id, term FROM terms")
        terms = cursor.fetchall()

        if not student:
            flash("Student not found!", "danger")
            return redirect(url_for('student.manage_student'))

        if request.method == 'POST':
            term_id = request.form.get('term_id')
            if not term_id:
                flash("Term is required!", "danger")
            else:
                # Update the term for the student
                cursor.execute(
                    "UPDATE student_info SET term_id = %s WHERE id = %s",
                    (term_id, student_id)
                )
                conn.commit()
                flash("Student's term updated successfully!", "success")
                return redirect(url_for('student.manage_student'))

        cursor.close()
        conn.close()

        return render_template('student/register_student.html',username=session['username'], student=student, terms=terms)

    except Exception as e:
        flash(f"An error occurred while fetching data: {str(e)}", "danger")
        return redirect(url_for('student.manage_student'))


    return redirect(url_for('student.manage_student'))







@student_bp.route('/register_selected_students', methods=['POST'])
def register_selected_students():
    try:
        # Get the list of selected students' IDs
        selected_students = request.form.getlist('students[]')
        if not selected_students:
            flash("No students selected!", "danger")
            return redirect(url_for('student.manage_student'))

        # Connect to the database
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch the terms for the dropdown
        cursor.execute("SELECT id, term FROM terms")
        terms = cursor.fetchall()

        # Check if a term is provided in the form
        term_id = request.form.get('term_id')
        if not term_id:
            flash("Term is required!", "danger")
            return redirect(url_for('student.manage_student'))

        # Loop through the selected students and update their term_id
        for student_id in selected_students:
            cursor.execute(
                "UPDATE student_info SET term_id = %s WHERE id = %s",
                (term_id, student_id)
            )

        # Commit the changes to the database
        conn.commit()
        flash(f"Successfully registered {len(selected_students)} students.", "success")
        return redirect(url_for('student.manage_student'))

    except Exception as e:
        flash(f"An error occurred: {str(e)}", "danger")
        return redirect(url_for('student.manage_student'))

    finally:
        cursor.close()
        conn.close()











# Helper function to check file extension
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


# Route to download the template file
@student_bp.route('/download_template', methods=['GET'])
def download_template():
    # Create a DataFrame with the template structure
    template_data = {
        "Student Teacher": ["", "", ""],
        "Programme": ["", "", ""],
        "Registration No": ["", "", ""],
        "Term": ["", "", ""],
        "Subject": ["", "", ""],
        "Class": ["", "", ""],
        "Teaching Time": ["", "", ""],
        "Topic": ["", "", ""],
        "Subtopic": ["", "", ""]
    }

    df = pd.DataFrame(template_data)

    # Save it to an Excel file in memory
    output = BytesIO()
    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name='Template')
    
    # Move the pointer to the beginning of the BytesIO buffer before sending it
    output.seek(0)

    return send_file(output, as_attachment=True, download_name="student_teacher_template.xlsx", mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")








# Ensure the upload folder exists
if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])



@student_bp.route('/upload_excel', methods=['GET', 'POST'])
def upload_excel():
    if request.method == 'POST':
        file = request.files.get('file')

        if not file or file.filename == '':
            flash('No file selected', 'danger')
            return redirect(request.url)

        if not allowed_file(file.filename):
            flash('Invalid file format. Please upload an Excel file.', 'danger')
            return redirect(request.url)

        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)

        try:
            df = pd.read_excel(file_path)
            processed_data, errors, existing_reg_nos, duplicate_reg_nos = validate_excel_data(df)

            if duplicate_reg_nos:
                flash(f"Duplicate registration numbers found in file: {', '.join(map(str, duplicate_reg_nos))}. Remove duplicates and try again.", 'danger')
                return redirect(request.url)

            if errors:
                flash('Errors encountered:\n' + '\n'.join(errors), 'danger')
                return redirect(request.url)

            if existing_reg_nos:
                flash(f"Registration numbers already exist: {', '.join(existing_reg_nos)}. These entries were skipped.", 'warning')

            insert_into_database(processed_data)

            flash(f'{len(processed_data)} new record(s) uploaded successfully!', 'success')
            return redirect(url_for('student.upload_excel'))
        
        except pd.errors.EmptyDataError:
            flash('Uploaded file is empty.', 'danger')
        except Exception as e:
            flash(f'Error processing the file: {str(e)}', 'danger')

        return redirect(url_for('student.upload_excel'))

    return render_template('student/upload_excel.html', username=session['username'], role=session['role'])






def validate_excel_data(df):
    processed_data = []
    errors = []
    existing_reg_nos = []
    duplicate_reg_nos = []
    seen_reg_nos = set()

    with get_db_connection() as connection:
        cursor = connection.cursor()

        for index, row in df.iterrows():
            reg_no = row.get('Registration No')
            programme_name = row.get('Programme')
            term = row.get('Term')

            # ✅ Essential fields check (excluding optional fields)
            if pd.isna(reg_no) or pd.isna(programme_name) or pd.isna(term):
                errors.append(f"Missing required fields in row {index + 1}.")
                continue

            reg_no = str(reg_no).strip()  # Ensure it's a string
            
            if reg_no in seen_reg_nos:
                duplicate_reg_nos.append(reg_no)
                continue
            seen_reg_nos.add(reg_no)

            cursor.execute("SELECT COUNT(*) FROM student_info WHERE reg_no = %s", (reg_no,))
            if cursor.fetchone()[0] > 0:
                existing_reg_nos.append(reg_no)
                continue

            cursor.execute("SELECT id FROM programmes WHERE programme_name = %s", (programme_name,))
            programme_id = cursor.fetchone()

            cursor.execute("SELECT id FROM terms WHERE term = %s", (term,))
            term_id = cursor.fetchone()

            if not programme_id:
                errors.append(f"Programme '{programme_name}' does not exist in row {index + 1}.")
            if not term_id:
                errors.append(f"Term '{term}' does not exist in row {index + 1}.")

            if programme_id and term_id:
                processed_data.append({
                    'student_teacher': row.get('Student Teacher', ''), 
                    'programme_id': programme_id[0], 
                    'reg_no': reg_no,
                    'subject': row.get('Subject') if not pd.isna(row.get('Subject')) else None,
                    'term_id': term_id[0], 
                    'class_name': row.get('Class') if not pd.isna(row.get('Class')) else None,
                    'topic': row.get('Topic') if not pd.isna(row.get('Topic')) else None,
                    'subtopic': row.get('Subtopic') if not pd.isna(row.get('Subtopic')) else None,
                    'teaching_time': format_teaching_time(row.get('Teaching Time'))
                })

    return processed_data, errors, existing_reg_nos, duplicate_reg_nos










# Function to insert valid data into the database
def insert_into_database(data):
    with get_db_connection() as connection:
        cursor = connection.cursor()
        sql = """
        INSERT INTO student_info (student_teacher, programme_id, reg_no, subject, term_id, 
                                  class_name, topic, subtopic, teaching_time)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        for row in data:
            cursor.execute(sql, (
                row['student_teacher'], row['programme_id'], row['reg_no'], 
                row['subject'], row['term_id'], row['class_name'], 
                row['topic'], row['subtopic'], row['teaching_time']
            ))
        connection.commit()





# Function to format teaching time correctly
def format_teaching_time(teaching_time):
    if isinstance(teaching_time, datetime):
        return teaching_time.strftime('%Y-%m-%d %H:%M:%S')
    elif isinstance(teaching_time, str):
        try:
            return datetime.strptime(teaching_time, '%Y-%m-%d %H:%M:%S').strftime('%Y-%m-%d %H:%M:%S')
        except ValueError:
            return None  # Handle invalid date formats
    return None







@student_bp.route('/manage_assigned_students', methods=['GET', 'POST'])
def manage_assigned_student():
    try:
        # Database connection and fetching programmes and terms
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        programmes, terms = fetch_programmes_and_terms()

        # Fetch assessors with corrected query
        assessors_query = "SELECT id, username FROM users WHERE role != 'admin' AND role != 'Head of Department'"
        cursor.execute(assessors_query)
        assessors = cursor.fetchall()

        # Base query for student information, including checking if the assessor is the current session user
        query = """
        SELECT 
            si.id AS student_id,
            si.student_teacher,  
            si.reg_no, 
            si.subject,
            si.class_name, 
            si.topic, 
            si.subtopic, 
            si.teaching_time,
            p.programme_name, 
            p.description AS programme_description,
            t.term AS term,
            a.assessor_id IS NOT NULL AS assigned,
            u.username AS assessor_name,  -- Added to fetch assessor's name
            CASE 
                WHEN a.assessor_id = %s THEN 'Yes' 
                ELSE 'No' 
            END AS is_assessor_match  -- Determine if the session user is the assigned assessor
        FROM student_info si
        LEFT JOIN programmes p ON si.programme_id = p.id
        LEFT JOIN terms t ON si.term_id = t.id
        LEFT JOIN assign_assessor a ON si.id = a.student_id
        LEFT JOIN users u ON a.assessor_id = u.id  -- Join with users to get assessor name
        """

        params = [session['id']]  # Pass the session's user id to check for matches

        if request.method == 'POST':
            conditions = []

            # Handle dynamic filtering
            if programme := request.form.get('programme'):
                conditions.append("si.programme_id = %s")
                params.append(programme)
            
            if term := request.form.get('term'):
                conditions.append("si.term_id = %s")
                params.append(term)

            if reg_no := request.form.get('reg_no'):
                conditions.append("si.reg_no LIKE %s")
                params.append(f"%{reg_no}%")

            if conditions:
                query += " WHERE " + " AND ".join(conditions)

            # Execute query to fetch students based on filtering
            cursor.execute(query, params)
            student_info = cursor.fetchall()

        else:
            cursor.execute(query, params)
            student_info = cursor.fetchall()

        cursor.close()
        conn.close()

        # Pass the information to the template
        return render_template('student/manage_assigned_student.html', 
                               username=session['username'], 
                               role=session['role'],
                               student_info=student_info, 
                               programmes=programmes, 
                               terms=terms,
                               assessors=assessors)

    except Exception as e:
        # Log the error and provide feedback to the user
        print(f"Error occurred: {str(e)}")  # For debugging
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))









@student_bp.route('/manage_assess_students', methods=['GET', 'POST'])
def manage_assess_students():
    try:
        # Ensure that the session has a valid assessor id
        if 'id' not in session:
            flash('You must be logged in to access this page', 'danger')
            return redirect(url_for('auth.login'))

        # Database connection and fetching programmes and terms
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        programmes, terms = fetch_programmes_and_terms()

        # Fetch assessors with corrected query
        assessors_query = """
            SELECT id, username FROM users WHERE role != 'admin' AND role != 'Head of Department'
        """
        cursor.execute(assessors_query)
        assessors = cursor.fetchall()

        # Base query for student information, modified to only include students assigned to the current assessor
        query = """
            SELECT 
                si.id AS student_id,
                si.student_teacher,  
                si.reg_no, 
                si.subject,
                si.class_name, 
                si.topic, 
                si.subtopic, 
                si.teaching_time,
                p.programme_name, 
                p.description AS programme_description,
                t.term AS term,
                a.assessor_id IS NOT NULL AS assigned,
                u.username AS assessor_name,
                si.term_id AS term_id
            FROM student_info si
            LEFT JOIN programmes p ON si.programme_id = p.id
            LEFT JOIN terms t ON si.term_id = t.id
            LEFT JOIN assign_assessor a ON si.id = a.student_id
            LEFT JOIN users u ON a.assessor_id = u.id
            WHERE a.assessor_id = %s
        """

        # Prepare params for filtering
        params = [session['id']]

        # If it's a POST request, add filters to the query
        if request.method == 'POST':
            conditions = []
            if programme := request.form.get('programme'):
                conditions.append("si.programme_id = %s")
                params.append(programme)
            
            if term := request.form.get('term'):
                conditions.append("si.term_id = %s")
                params.append(term)

            if reg_no := request.form.get('reg_no'):
                conditions.append("si.reg_no LIKE %s")
                params.append(f"%{reg_no}%")

            if conditions:
                query += " AND " + " AND ".join(conditions)

        # Execute query to fetch students based on filtering
        cursor.execute(query, params)
        student_info = cursor.fetchall()

        # For each student, check if a mark exists for the same term_id in the marks table
        for student in student_info:
            term_id = student['term_id']
            student_id = student['student_id']

            # Query to check if the student has a mark for the same term_id by this specific assessor
            mark_query = """
                SELECT marks, marks_scores_sku
                FROM marks 
                WHERE student_id = %s AND term_id = %s AND assessor_id = %s
                LIMIT 1
            """
            cursor.execute(mark_query, (student_id, term_id, session['id']))
            mark_result = cursor.fetchone()

            if mark_result:
                student['status'] = 'Assessed'
                student['mark'] = mark_result['marks']  # Store the mark if available
                student['marks_scores_sku'] = mark_result['marks_scores_sku']
            else:
                # Check if there is any missing data in the student's information
                required_fields = ['term', 'programme_name', 'class_name', 'reg_no', 'subject', 'topic', 'subtopic', 'teaching_time']
                missing_fields = [field for field in required_fields if not student.get(field)]

                if missing_fields:
                    student['status'] = 'Update Student Data'
                    student['mark'] = None
                else:
                    student['status'] = 'Unassessed'
                    student['mark'] = None

        cursor.close()
        conn.close()

        # Pass the information to the template
        return render_template('student/manage_assess_student.html', 
                               username=session['username'], 
                               role=session['role'],
                               student_info=student_info, 
                               programmes=programmes, 
                               terms=terms,
                               assessors=assessors)

    except Exception as e:
        # Log the error and provide feedback to the user
        print(f"Error occurred: {str(e)}")  # For debugging
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))











@student_bp.route('/m_manage_assess_students', methods=['GET', 'POST'])
def m_manage_assess_student():
    try:
        # Ensure that the session has a valid assessor id
        if 'id' not in session:
            flash('You must be logged in to access this page', 'danger')
            return redirect(url_for('auth.login'))

        # Database connection and fetching programmes and terms
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        programmes, terms = fetch_programmes_and_terms()

        # Fetch assessors with corrected query
        assessors_query = "SELECT id, username FROM users WHERE role != 'admin' AND role != 'Head of Department'"
        cursor.execute(assessors_query)
        assessors = cursor.fetchall()

        # Base query for student information, modified to only include students assigned to the current assessor
        query = """
        SELECT 
            si.id AS student_id,
            si.student_teacher,  
            si.reg_no, 
            si.subject,
            si.class_name, 
            si.topic, 
            si.subtopic, 
            si.teaching_time,
            p.programme_name, 
            p.description AS programme_description,
            t.term AS term,
            a.assessor_id IS NOT NULL AS assigned,
            u.username AS assessor_name,  -- Added to fetch assessor's name
            si.term_id AS term_id
        FROM student_info si
        LEFT JOIN programmes p ON si.programme_id = p.id
        LEFT JOIN terms t ON si.term_id = t.id
        LEFT JOIN m_assign_assessor a ON si.id = a.student_id
        LEFT JOIN users u ON a.assessor_id = u.id
        WHERE a.assessor_id = %s
        """

        # Prepare params for filtering
        params = [session['id']]

        # If it's a POST request, add filters to the query
        if request.method == 'POST':
            conditions = []

            # Handle dynamic filtering
            if programme := request.form.get('programme'):
                conditions.append("si.programme_id = %s")
                params.append(programme)
            
            if term := request.form.get('term'):
                conditions.append("si.term_id = %s")
                params.append(term)

            if reg_no := request.form.get('reg_no'):
                conditions.append("si.reg_no LIKE %s")
                params.append(f"%{reg_no}%")

            if conditions:
                query += " AND " + " AND ".join(conditions)

        # Execute query to fetch students based on filtering
        cursor.execute(query, params)
        student_info = cursor.fetchall()

        # For each student, check if a mark exists for the same term_id in the marks table
        for student in student_info:
            term_id = student['term_id']
            student_id = student['student_id']

            # Query to check if the student has a mark for the same term_id by this specific assessor
            mark_query = """
            SELECT marks 
            FROM  mudulate_marks 
            WHERE student_id = %s AND term_id = %s AND assessor_id = %s
            LIMIT 1
            """
            cursor.execute(mark_query, (student_id, term_id, session['id']))
            mark_result = cursor.fetchone()

            if mark_result:
                student['status'] = 'Assessed'
                student['mark'] = mark_result['marks']  # Store the mark if available
            else:
                student['status'] = 'Unassessed'
                student['mark'] = None

        cursor.close()
        conn.close()

        # Pass the information to the template
        return render_template('student/m_manage_assess_student.html', 
                               username=session['username'], 
                               role=session['role'],
                               student_info=student_info, 
                               programmes=programmes, 
                               terms=terms,
                               assessors=assessors)

    except Exception as e:
        # Log the error and provide feedback to the user
        print(f"Error occurred: {str(e)}")  # For debugging
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))
