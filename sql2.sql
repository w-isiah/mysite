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



