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
    t.id AS term_id,
    a.assessor_id IS NOT NULL AS assigned,  -- Assigned status based on presence of assessor in assign_assessor table
    u.username AS assessor_name,  -- Assessor's name
    s.name AS school_name  -- School's name from the schools table
FROM student_info si
LEFT JOIN programmes p ON si.programme_id = p.id
LEFT JOIN terms t ON si.term_id = t.id
LEFT JOIN assign_assessor a ON si.id = a.student_id AND si.term_id = a.term_id  -- Join on both student_id and term_id
LEFT JOIN users u ON a.assessor_id = u.id  -- Join with users to get assessor name
LEFT JOIN schools s ON si.school_id = s.id  -- Join the schools table to get school name





CREATE TABLE assessments (
    assessment_id INT(11) NOT NULL AUTO_INCREMENT,
    student_id INT(11) NOT NULL,
    coverage DECIMAL(5,2) DEFAULT NULL,
    quality DECIMAL(5,2) DEFAULT NULL,
    quantity DECIMAL(5,2) DEFAULT NULL,
    attractiveness DECIMAL(5,2) DEFAULT NULL,
    accuracy DECIMAL(5,2) DEFAULT NULL,
    grading DECIMAL(5,2) DEFAULT NULL,
    relevance DECIMAL(5,2) DEFAULT NULL,
    printing DECIMAL(5,2) DEFAULT NULL,
    durability DECIMAL(5,2) DEFAULT NULL,
    originality DECIMAL(5,2) DEFAULT NULL,
    explanation DECIMAL(5,2) DEFAULT NULL,
    storage DECIMAL(5,2) DEFAULT NULL,
    assessor_id INT(11) NOT NULL,
    score_type ENUM('im', 'ee') NOT NULL,
    PRIMARY KEY (assessment_id),
    FOREIGN KEY (assessor_id) REFERENCES assessors(assessor_id) ON DELETE CASCADE
);









CREATE TABLE assessments (
    id INT(11) NOT NULL AUTO_INCREMENT,  -- Primary key for assessment
    student_id INT(11) NOT NULL,
    coverage DECIMAL(5,2) DEFAULT NULL,
    quality DECIMAL(5,2) DEFAULT NULL,
    quantity DECIMAL(5,2) DEFAULT NULL,
    attractiveness DECIMAL(5,2) DEFAULT NULL,
    accuracy DECIMAL(5,2) DEFAULT NULL,
    grading DECIMAL(5,2) DEFAULT NULL,
    relevance DECIMAL(5,2) DEFAULT NULL,
    printing DECIMAL(5,2) DEFAULT NULL,
    durability DECIMAL(5,2) DEFAULT NULL,
    originality DECIMAL(5,2) DEFAULT NULL,
    explanation DECIMAL(5,2) DEFAULT NULL,
    storage DECIMAL(5,2) DEFAULT NULL,
    assessor_id INT(11) NOT NULL,
    score_type ENUM('im', 'ee') NOT NULL,
    PRIMARY KEY (id),  -- Setting id as the primary key
    FOREIGN KEY (assessor_id) REFERENCES assessors(assessor_id) ON DELETE CASCADE  -- Foreign key relationship to assessors table
);




CREATE TABLE d_f_scores (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- Primary key for assessment
    student_id INT(11) NOT NULL,
    coverage DECIMAL(5,2) DEFAULT NULL,
    quality DECIMAL(5,2) DEFAULT NULL,
    quantity DECIMAL(5,2) DEFAULT NULL,
    attractiveness DECIMAL(5,2) DEFAULT NULL,
    accuracy DECIMAL(5,2) DEFAULT NULL,
    grading DECIMAL(5,2) DEFAULT NULL,
    relevance DECIMAL(5,2) DEFAULT NULL,
    printing DECIMAL(5,2) DEFAULT NULL,
    durability DECIMAL(5,2) DEFAULT NULL,
    originality DECIMAL(5,2) DEFAULT NULL,
    explanation DECIMAL(5,2) DEFAULT NULL,
    storage DECIMAL(5,2) DEFAULT NULL,
    assessor_id INT(11) NOT NULL,
    score_type ENUM('im', 'ee') NOT NULL,
    term_id INT(11) NOT NULL
);




ALTER TABLE users
ADD COLUMN a_role varchar(255) NOT NULL DEFAULT 'Normal';


CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL DEFAULT 'user',
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    other_name VARCHAR(50) DEFAULT NULL,
    profile_image VARCHAR(255) DEFAULT NULL,
    a_internal_role VARCHAR(255) DEFAULT NULL,
    a_external_role VARCHAR(255) DEFAULT NULL
);





CREATE TABLE d_assign_assessor (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,       -- Unique ID for the assignment
    assessor_id INT(11),                         -- ID of the assessor
    student_id INT(11),                          -- ID of the student being assessed
    assigned_by INT(11),                         -- ID of the user assigning the assessor (e.g., admin or teacher)
    term_id INT(11),                             -- Term ID for the assignment (e.g., academic term or year)
    assessment_column VARCHAR(50)              -- The specific assessment column (criterion) being evaluated (e.g., 'coverage_im', 'quality_im')
    
);




CREATE TABLE d_internal_assign_assessor (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    assessor_id INT(11),
    assigned_by INT(11),
    term_id INT(11),
    school_id INT(11)
);


CREATE TABLE d_external_assign_assessor (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    assessor_id INT(11),
    assigned_by INT(11),
    term_id INT(11),
    school_id INT(11)
);