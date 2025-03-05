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


ALTER TABLE terms
ADD COLUMN academic_year varchar(255) AFTER year,
ADD COLUMN study_year varchar(255) AFTER academic_year;



DROP TABLE IF EXISTS `assessment_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_criteria` (
  `criteria_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria_name` varchar(255) DEFAULT NULL,
  `aspect_id` int(11) NOT NULL,
  PRIMARY KEY (`criteria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_criteria`
--

LOCK TABLES `assessment_criteria` WRITE;
/*!40000 ALTER TABLE `assessment_criteria` DISABLE KEYS */;
INSERT INTO `assessment_criteria` VALUES (55,'a) Schemes of work',16),(56,'b) Lesson plan(s)',16),(57,'c) Effectiveness of preparation',16),(58,'d) Teacher/learner records',16),(59,'a) Choice of methodology',17),(60,'b) Application',17),(61,'c) Inclusiveness',17),(62,'e) Life Skills and values',17),(63,'a) SMARTness',18),(64,'b) Domains addressed',18),(65,'c) Sequencing (Levels)',18),(66,'d) Learner centred',18),(67,'e) Reflect content',18),(69,'a) Selection of resources',19),(70,'b) Use of resources',19),(71,'c) Variety of resources',19),(72,'a) Related to learning framework/curriculum',20),(73,'b) Appropriateness',20),(74,'c) Comprehensiveness',20),(75,'d) Use of relevant examples and illustrations',20),(76,'a) Classroom set up/organisation',21),(77,'b) Classroom movement',21),(78,'c) Variety of display',21),(79,'d) Display of learners work',21),(80,'e) Class discipline',21),(81,'f) Classroom management',21),(82,'a) Teacher-learner relationship',22),(83,'b) Inclusive',22),(84,'c) Personality and presentation',22),(85,'d) Knowledge of content',22),(86,'e) Role modeling',22),(87,'f) Competence and confidence',22),(88,'g) Time management',22),(89,'a) Relevant assessment activities',23),(90,'b) Adequate assessment activities',23),(91,'c) Marking and correction of learner\'s work',23),(92,'d) Follow up on learner\'s work',23),(93,'e) Lesson Conclusion',23),(94,'f) Self-evaluation/reflection',23);
/*!40000 ALTER TABLE `assessment_criteria` ENABLE KEYS */;
UNLOCK TABLES;












CREATE TABLE `academic_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_year` varchar(255)  NULL,
  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



CREATE TABLE `study_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



ALTER TABLE student_info

ADD COLUMN academic_year_id INT(11) NULL,

ADD COLUMN study_year_id INT(11) NULL;
