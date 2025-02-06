from datetime import datetime
from flask import Blueprint, render_template, request, redirect, url_for, flash, session,jsonify
from app.db import get_db_connection
import os
import pandas as pd
from flask import Flask, render_template, request, redirect, url_for, flash, send_file
from werkzeug.utils import secure_filename
from io import BytesIO
from app import app
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


@student_bp.route('/manage_students', methods=['GET', 'POST'])
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
                    t.term
                FROM student_info si
                LEFT JOIN programmes p ON si.programme_id = p.id
               LEFT JOIN terms t ON si.term_id = t.id
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
            print("Executing Query:", query)
            print("With Parameters:", params)

            cursor.execute(query, params)
            student_info = cursor.fetchall()

            # Debug: Check the fetched data
            print("Fetched Student Info:", student_info)

        else:
            student_info = []

        cursor.close()
        conn.close()

        # Ensure that student_info is being passed correctly to the template
        print("Student Info for Rendering:", student_info)

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
    # Connect to the database
    connection = get_db_connection()
    
    if not connection:
        flash('Failed to connect to the database.', 'danger')
        return render_template('add_student.html')

    # Fetch programs and terms for the dropdown
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT id, programme_name FROM programmes')
    programmes = cursor.fetchall()
    
    cursor.execute('SELECT id, term FROM terms')
    terms = cursor.fetchall()
    
    if request.method == 'POST':
        # Get form data
        student_teacher = request.form['student_teacher']
        programme_id = request.form['programme_id']
        reg_no = request.form['reg_no']
        term_id = request.form['term_id']
        subject = request.form['subject']
        class_name = request.form['class']
        teaching_time = request.form['teaching_time']
        topic = request.form['topic']
        subtopic = request.form['subtopic']

        # Insert data into the student_info table
        cursor = connection.cursor()
        query = """
            INSERT INTO student_info (
                student_teacher, programme_id, reg_no, term_id, subject, class_name, teaching_time, topic, subtopic
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (student_teacher, programme_id, reg_no, term_id, subject, class_name, teaching_time, topic, subtopic)

        try:
            cursor.execute(query, values)
            connection.commit()
            flash('Student Teacher added successfully!', 'success')
            return redirect(url_for('student/add_student'))  # Redirect after successful submission
        except Error as e:
            connection.rollback()
            flash(f'Error: {e}', 'danger')
            return render_template('student/add_student.html', programmes=programmes, terms=terms)

    return render_template('student/add_student.html', programmes=programmes, terms=terms)





@student_bp.route('/edit_student/<int:student_id>', methods=['GET', 'POST'])
def edit_student(student_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM student_info WHERE id = %s", (student_id,))
        student = cursor.fetchone()
        programmes, terms = fetch_programmes_and_terms()

        if not student:
            flash("Student not found!", "danger")
            return redirect(url_for('student.manage_student'))

        if request.method == 'POST':
            form_data = {key: request.form[key] for key in ('student_teacher', 'term_id', 'programme_id', 'reg_no',
                                                            'subject', 'class', 'topic', 'subtopic', 'teaching_time')}
            if not all(form_data.values()):
                flash("All fields are required!", "danger")
            else:
                try:
                    form_data['teaching_time'] = datetime.strptime(form_data['teaching_time'], "%Y-%m-%dT%H:%M")
                    cursor.execute("""
                        UPDATE student_info
                        SET student_teacher = %s, term_id = %s, programme_id = %s, reg_no = %s,
                            subject = %s, class_name = %s, topic = %s, subtopic = %s, teaching_time = %s
                        WHERE id = %s
                    """, (*form_data.values(), student_id))
                    conn.commit()
                    flash("Student updated successfully!", "success")
                    return redirect(url_for('student.manage_student'))
                except ValueError:
                    flash("Invalid teaching time format!", "danger")

        cursor.close()
        conn.close()
        template = 'student/edit_student.html' if session['role'] == "Head of Department" else 'student/assessor_edit_student.html'
        return render_template(template, username=session['username'], role=session['role'], terms=terms, student=student, programmes=programmes)
    except Exception as e:
        flash(f"An error occurred: {str(e)}", "danger")
        return redirect(url_for('student.manage_student'))



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


# Initialize a Flask Blueprint for student-related routes
student_bp = Blueprint('student', __name__)

@student_bp.route('/manage_students', methods=['GET', 'POST'])
def manage_student():
    """
    View for managing students. Displays filtered student information.
    Handles GET (initial display) and POST (filtering based on form data) requests.
    """
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch dropdown data
        cursor.execute("SELECT id, programme_name FROM programmes")
        programmes = cursor.fetchall()
        cursor.execute("SELECT id, term FROM terms")
        terms = cursor.fetchall()

        # Base SQL query to retrieve student details
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
        params = []

        # Handle POST request to filter students
        if request.method == 'POST':
            conditions = []  # Collect filtering conditions
            if programme := request.form.get('programme'):
                conditions.append("si.programme_id = %s")
                params.append(programme)
            if term := request.form.get('term'):
                conditions.append("si.term_id = %s")
                params.append(term)
            if reg_no := request.form.get('reg_no'):
                conditions.append("si.reg_no LIKE %s")
                params.append(f"%{reg_no}%")

            # Append conditions to the query if any
            if conditions:
                query += " WHERE " + " AND ".join(conditions)
                cursor.execute(query, params)
                student_info = cursor.fetchall()  # Get filtered results
            else:
                student_info = []  # No filter, empty results
        else:
            student_info = []  # Default empty list for GET request

        cursor.close()
        conn.close()

        # Render appropriate template based on user role
        template = 'student/manage_student.html' if session['role'] == "Head of Department" else 'student/assessor_manage_student.html'
        return render_template(template, username=session['username'], role=session['role'],
                               student_info=student_info, programmes=programmes, terms=terms)
    except Exception as e:
        # Handle errors gracefully
        flash(f"An error occurred while fetching data: {str(e)}", 'danger')
        return redirect(url_for('main.index'))



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








@student_bp.route('/add_student', methods=['GET', 'POST'])
def add_student():
    """
    View for adding a new student.
    Handles GET (render form) and POST (process form submission) requests.
    """
    try:
        # Fetch dropdown data
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, programme_name FROM programmes")
        programmes = cursor.fetchall()
        cursor.execute("SELECT id, term FROM terms")
        terms = cursor.fetchall()
        cursor.close()
        conn.close()

        if request.method == 'POST':
            # Extract form data
            form_data = {key: request.form[key] for key in ('student_teacher', 'programme_id', 'reg_no','term_id','subject', 'class', 'topic' , 'subtopic', 'teaching_time')}
            if not all(form_data.values()):  # Validate form data
                flash("All fields are required.", "danger")
            else:
                conn = get_db_connection()
                cursor = conn.cursor(dictionary=True)
                # Check if student with the same reg_no already exists
                cursor.execute("SELECT * FROM student_info WHERE reg_no = %s", (form_data['reg_no'],))
                if cursor.fetchone():
                    flash(f"Student with registration number {form_data['reg_no']} already exists.", "danger")
                else:
                    # Insert new student record
                    cursor.execute("""
                        INSERT INTO student_info (
                            student_teacher, programme_id, reg_no, term_id, subject, class_name, topic, subtopic, teaching_time
                        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """, tuple(form_data.values()))
                    conn.commit()
                    flash("Student added successfully!", "success")
                cursor.close()
                conn.close()
                return redirect(url_for('student.manage_student'))

        # Render appropriate template based on user role
        template = 'student/add_student.html' if session['role'] == "Head of Department" else 'student/assessor_add_student.html'
        return render_template(template, username=session['username'], role=session['role'], programmes=programmes, terms=terms)
    except Exception as e:
        # Handle errors gracefully
        flash(f"An error occurred: {str(e)}", "danger")
        return redirect(url_for('student.manage_student'))






@student_bp.route('/edit_student/<int:student_id>', methods=['GET', 'POST'])
def edit_student(student_id):
    """
    View for editing a student's details.
    Handles GET (render form) and POST (update details) requests.
    """
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        # Fetch existing student record
        cursor.execute("SELECT * FROM student_info WHERE id = %s", (student_id,))
        student = cursor.fetchone()

        # Fetch programmes and terms for dropdown
        cursor.execute("SELECT id, programme_name FROM programmes")
        programmes = cursor.fetchall()
        cursor.execute("SELECT id, term FROM terms")
        terms = cursor.fetchall()

        if not student:
            flash("Student not found!", "danger")
            return redirect(url_for('student.manage_student'))

        if request.method == 'POST':
            # Extract and validate form data
            form_data = {key: request.form[key] for key in ('student_teacher', 'term_id', 'programme_id', 'reg_no',
                                                            'subject', 'class', 'topic', 'subtopic', 'teaching_time')}
            if not all(form_data.values()):
                flash("All fields are required!", "danger")
            else:
                try:
                    # Convert teaching_time to datetime
                    form_data['teaching_time'] = datetime.strptime(form_data['teaching_time'], "%Y-%m-%dT%H:%M")
                    # Update student record in the database
                    cursor.execute("""
                        UPDATE student_info
                        SET student_teacher = %s, term_id = %s, programme_id = %s, reg_no = %s,
                            subject = %s, class_name = %s, topic = %s, subtopic = %s, teaching_time = %s
                        WHERE id = %s
                    """, (*form_data.values(), student_id))
                    conn.commit()
                    flash("Student updated successfully!", "success")
                    return redirect(url_for('student.manage_student'))
                except ValueError:
                    flash("Invalid teaching time format!", "danger")

        cursor.close()
        conn.close()

        # Render appropriate template based on user role
        template = 'student/edit_student.html' if session['role'] == "Head of Department" else 'student/assessor_edit_student.html'
        return render_template(template, username=session['username'], role=session['role'], terms=terms, student=student, programmes=programmes)
    except Exception as e:
        # Handle errors gracefully
        flash(f"An error occurred: {str(e)}", "danger")
        return redirect(url_for('student.manage_student'))


@student_bp.route('/delete_student/<string:get_id>')
def delete_student(get_id):
    """
    Deletes a student record based on the provided ID.
    """
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        # Execute delete query
        cursor.execute("DELETE FROM student_info WHERE id = %s", (get_id,))
        conn.commit()
        flash('Student deleted successfully', 'success')
    except Exception as e:
        # Handle errors during deletion
        flash(f'Error deleting student: {str(e)}', 'danger')
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

    return redirect(url_for('student.manage_student'))


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

        return render_template('student/register_student.html', student=student, terms=terms)

    except Exception as e:
        flash(f"An error occurred while fetching data: {str(e)}", "danger")
        return redirect(url_for('student.manage_student'))


    return redirect(url_for('student.manage_student'))










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
        if 'file' not in request.files:
            flash('No file part', 'danger')
            return redirect(request.url)
        
        file = request.files['file']
        
        if file.filename == '':
            flash('No selected file', 'danger')
            return redirect(request.url)
        
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)
            
            # Process the uploaded Excel file
            try:
                # Read the Excel file using pandas
                df = pd.read_excel(file_path)

                # Open a database connection
                connection = get_db_connection()
                cursor = connection.cursor()

                # List to store valid rows (those that don't have a duplicate reg_no)
                rows_to_insert = []
                existing_reg_nos = []
                errors = []
                seen_reg_nos = set()  # Set to track seen registration numbers
                duplicate_reg_nos = []  # List to store duplicate reg_no values within the file

                # Iterate through the DataFrame and check each row
                for index, row in df.iterrows():
                    reg_no = row['Registration No']
                    programme_name = row['Programme']
                    term = row['Term']

                    # Check for duplicate registration numbers in the uploaded file
                    if reg_no in seen_reg_nos:
                        duplicate_reg_nos.append(reg_no)  # Add to the list of duplicates
                    else:
                        seen_reg_nos.add(reg_no)  # Add to the seen set

                    # Check if the registration number already exists in the database
                    cursor.execute("SELECT COUNT(*) FROM student_info WHERE reg_no = %s", (reg_no,))
                    reg_no_exists = cursor.fetchone()[0]

                    if reg_no_exists > 0:
                        # If reg_no exists, add it to the list of existing reg_nos
                        existing_reg_nos.append(reg_no)
                    else:
                        # Check if the programme exists in the database
                        cursor.execute("SELECT COUNT(*) FROM programmes WHERE programme_name = %s", (programme_name,))
                        programme_exists = cursor.fetchone()[0]
                        
                        # Check if the term exists in the database
                        cursor.execute("SELECT COUNT(*) FROM terms WHERE term = %s", (term,))
                        term_exists = cursor.fetchone()[0]
                        
                        if not programme_exists:
                            errors.append(f"Programme '{programme_name}' does not exist in the database for row {index + 1}.")
                        if not term_exists:
                            errors.append(f"Term '{term}' does not exist in the database for row {index + 1}.")
                        
                        if programme_exists and term_exists:
                            # If both programme and term exist, add the row to the list of rows to insert
                            rows_to_insert.append(row)

                # If there are any duplicate reg_nos within the file, notify the user
                if duplicate_reg_nos:
                    flash(f"Duplicate registration number(s) found in the file: {', '.join(map(str, duplicate_reg_nos))}. Please remove duplicates and try again.", 'danger')
                    return redirect(request.url)

                # If there are any errors (non-existent programmes or terms), notify the user
                if errors:
                    flash('Errors encountered:\n' + '\n'.join(errors), 'danger')
                    return redirect(request.url)

                # If there are any existing reg_nos, notify the user
                if existing_reg_nos:
                    flash(f"Registration number(s) already exist in the database: {', '.join(existing_reg_nos)}. These entries were skipped.", 'warning')

                # Insert the valid rows (those with new reg_nos and valid programmes/terms) into the database
                for row in rows_to_insert:
                    student_teacher = row['Student Teacher']
                    programme_name = row['Programme']
                    reg_no = row['Registration No']
                    term = row['Term']
                    subject = row['Subject']
                    class_name = row['Class']
                    teaching_time = row['Teaching Time']
                    topic = row['Topic']
                    subtopic = row['Subtopic']

                    # If teaching_time is a datetime or timestamp, ensure it’s properly formatted
                    if isinstance(teaching_time, datetime):
                        teaching_time = teaching_time.strftime('%Y-%m-%d %H:%M:%S')
                    elif isinstance(teaching_time, str):
                        # If it's a string, try to convert it to datetime first
                        teaching_time = datetime.strptime(teaching_time, '%Y-%m-%d %H:%M:%S').strftime('%Y-%m-%d %H:%M:%S')

                    # Lookup programme_id from the programmes table
                    cursor.execute("SELECT id FROM programmes WHERE programme_name = %s", (programme_name,))
                    programme_result = cursor.fetchone()
                    programme_id = programme_result[0] if programme_result else None

                    # Lookup term_id from the terms table
                    cursor.execute("SELECT id FROM terms WHERE term = %s", (term,))
                    term_result = cursor.fetchone()
                    term_id = term_result[0] if term_result else None

                    # Insert data into the student_info table
                    sql = """
                    INSERT INTO student_info (student_teacher, programme_id, reg_no, subject, term_id, 
                    class_name, topic, subtopic, teaching_time)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """
                    cursor.execute(sql, (student_teacher, programme_id, reg_no, subject, term_id, 
                                         class_name, topic, subtopic, teaching_time))

                # Commit the changes and close the connection
                connection.commit()
                connection.close()

                flash(f'{len(rows_to_insert)} new record(s) uploaded successfully!', 'success')
                return redirect(url_for('student.upload_excel'))
            except Exception as e:
                flash(f'Error processing the file: {e}', 'danger')
                return redirect(url_for('student.upload_excel'))
        else:
            flash('Invalid file format. Please upload an Excel file.', 'danger')
            return redirect(request.url)

    return render_template('student/upload_excel.html', username=session['username'], role=session['role'])
