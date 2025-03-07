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
  `study_year` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



ALTER TABLE student_info

ADD COLUMN academic_year_id INT(11) NULL,

ADD COLUMN study_year_id INT(11) NULL;





DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `mark` int(11) DEFAULT NULL,
  `assessment_criteria_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--


INSERT INTO `ratings` VALUES (11,'No scheme available','No scheme available',0,55),(12,'Has just started scheming','Has just started scheming',1,55),(13,'Has an incomplete scheme','Has an incomplete scheme',2,55),(14,'Almost finished scheme','Almost finished scheme',3,55),(15,'Has complete scheme but not approved','Has complete scheme but not approved',4,55),(16,'Has complete and approved scheme','Has complete and approved scheme',5,55),(17,'No lesson plan available','No lesson plan available',0,56),(18,'Plan does not follow format','Plan does not follow format',1,56),(19,'Plan follows format but not complete','Plan follows format but not complete',2,56),(20,'Complete but no self evaluation','Complete but no self evaluation',3,56),(21,'complete but evaluation doesn''t focus on self','complete but evaluation doesn''t focus on self',4,56),(22,'Complete and accurate self evaluated lesson plan','Complete and accurate self evaluated lesson plan',5,56),(23,'Not Prepared','Not Prepared',0,57),(24,'Only schemes','Only schemes',1,57),(25,'Plus lesson plan','Plus lesson plan',2,57),(26,'Plus Activity Plans','Plus Activity Plans',3,57),(27,'Plus prepared Materials','Plus prepared Materials',4,57),(28,'With all requirements','With all requirements',5,57),(29,'No learner records kept','No learner records kept',0,58),(30,'Some learner records outline seen','Some learner records outline seen',1,58),(31,'Some learner records are missing','Some learner records are missing',2,58),(32,'Some learner records are not regularly kept','Some learner records are not regularly kept',3,58),(33,'Learner records kept but not accurate','Learner records kept but not accurate',4,58),(34,'All learner records accurately kept','All learner records accurately kept',5,58),(35,'No method chosen','No method chosen',0,59),(36,'Has no idea of chosen methods','Has no idea of chosen methods',1,59),(37,'Chosen methodology not appropriate for class','Chosen methodology not appropriate for class',2,59),(38,'Appropriate but not used appropriately','Appropriate but not used appropriately',3,59),(39,'Appropriate for lesson but not for class level','Appropriate for lesson but not for class level',4,59),(40,'Appropriate for class and lesson levels','Appropriate for class and lesson levels',5,59),(41,'No method applied','No method applied',0,60),(42,'Techniques identified','Techniques identified',1,60),(43,'No attempt made to utilize the techniques','No attempt made to utilize the techniques',2,60),(44,'Techniques applied but confusion noticed','Techniques applied but confusion noticed',3,60),(45,'Techniques applied in some instances','Techniques applied in some instances',4,60),(46,'Techniques applied appropriately','Techniques applied appropriately',5,60),(47,'No method chosen','No method chosen',0,61),(48,'More than two methods planned for in the lesson','More than two methods planned for in the lesson',1,61),(49,'Limited understanding of methods seen','Limited understanding of methods seen',2,61),(50,'Most methods planned for were never used','Most methods planned for were never used',3,61),(51,'Most of the methods planned used appropriately','Most of the methods planned used appropriately',4,61),(52,'All planned for methods used appropriately','All planned for methods used appropriately',5,61),(53,'No method chosen','No method chosen',0,62),(54,'More than two methods planned for in the lesson','More than two methods planned for in the lesson',1,62),(55,'Limited understanding of methods seen','Limited understanding of methods seen',2,62),(56,'Most methods planned for were never used','Most methods planned for were never used',3,62),(57,'Most of the methods planned used appropriately','Most of the methods planned used appropriately',4,62),(58,'All planned for methods used appropriately','All planned for methods used appropriately',5,62),(59,'No competence identified','No competence identified',0,63),(60,'Competences identified','Competences identified',1,63),(61,'Compound competences identified','Compound competences identified',2,63),(62,'Simple, but not so clear competences identified','Simple, but not so clear competences identified',3,63),(63,'Simple, clear but not easily managed competences','Simple, clear but not easily managed competences',4,63),(64,'Simple, clear and easily managed','Simple, clear and easily managed',5,63),(65,'No domain addressed by a competence','No domain addressed by a competence',0,64),(66,'Domains identified in some competences','Domains identified in some competences',1,64),(67,'Activities to develop domains shown','Activities to develop domains shown',2,64),(68,'One domain dominates','One domain dominates',3,64),(69,'Two domains catered for','Two domains catered for',4,64),(70,'Three domains catered for','Three domains catered for',5,64),(71,'No levels identified','No levels identified',0,65),(72,'Levels identified','Levels identified',1,65),(73,'Levels don''t have current learners in mind','Levels don''t have current learners in mind',2,65),(74,'Sequencing not done','Sequencing not done',3,65),(75,'Sequencing done but not simple to complex','Sequencing done but not simple to complex',4,65),(76,'Sequencing done from simple to complex','Sequencing done from simple to complex',5,65),(77,'No mention of who the focus will be on','No mention of who the focus will be on',0,66),(78,'Approach to lesson identified','Approach to lesson identified',1,66),(79,'Teacher centred approach used','Teacher centred approach used',2,66),(80,'Limited learner involvement seen. Teacher takes over a lot','Limited learner involvement seen. Teacher takes over a lot',3,66),(81,'Mix of teacher and learner participation','Mix of teacher and learner participation',4,66),(82,'Learners involved most of the time. Teacher was a guide','Learners involved most of the time. Teacher was a guide',5,66),(83,'No content specified','No content specified',0,67),(84,'Content identified','Content identified',1,67),(85,'Content not from approved syllabus','Content not from approved syllabus',2,67),(86,'Content from approved syllabus but not broken down appropriately','Content from approved syllabus but not broken down appropriately',3,67),(87,'Content was from syllabus, but not well structured in the planning','Content was from syllabus, but not well structured in the planning',4,67),(88,'Content was from approved syllabus, well structured in the planning','Content was from approved syllabus, well structured in the planning',5,67),(89,'Resources not selected','Resources not selected',0,69),(90,'Some few resources selected','Some few resources selected',1,69),(91,'Resources selected but are not from learners'' environment','Resources selected but are not from learners'' environment',2,69),(92,'Resources selected are mainly for the teacher','Resources selected are mainly for the teacher',3,69),(93,'Resources selected but cant be used by some learners','Resources selected but cant be used by some learners',4,69),(94,'Resources selected appropriately for learners','Resources selected appropriately for learners',5,69),(95,'Resources not used','Resources not used',0,70),(96,'Resources used by the teacher for a short time','Resources used by the teacher for a short time',1,70),(97,'Resources used by the teacher all the time','Resources used by the teacher all the time',2,70),(98,'Resources used by some learners for a short time','Resources used by some learners for a short time',3,70),(99,'Resources used by most learners all the time','Resources used by most learners all the time',4,70),(100,'Resources used by all learners all the time','Resources used by all learners all the time',5,70),(101,'No resource identified','No resource identified',0,71),(102,'No resource used in the lesson','No resource used in the lesson',1,71),(103,'One resource used in the lesson','One resource used in the lesson',2,71),(104,'Two resources used in lesson','Two resources used in lesson',3,71),(105,'Three resources used in lesson','Three resources used in lesson',4,71),(106,'More than three resources used by learners','More than three resources used by learners',5,71),(107,'Content not related to curriculum','Content not related to curriculum',0,72),(108,'Content is related to the curriculum, but competences are not accurate.','Content is related to the curriculum, but competences are not accurate.',1,72),(109,'About 10% of content is related to the curriculum.','About 10% of content is related to the curriculum.',2,72),(110,'About 30% of the content is related to learning and the curriculum.','About 30% of the content is related to learning and the curriculum.',3,72),(111,'About 80% of the content is related to learning and the curriculum','About 80% of the content is related to learning and the curriculum',4,72),(112,'All content is related to learning and the curriculum.','All content is related to learning and the curriculum.',5,72),(113,'No content identified','No content identified',0,73),(114,'Content does not match competence and learner level','Content does not match competence and learner level',1,73),(115,'Content fits some competences','Content fits some competences',2,73),(116,'Content fits most of the competences','Content fits most of the competences',3,73),(117,'Content is appropriate, but slightly above class level','Content is appropriate, but slightly above class level',4,73),(118,'Content meets the level of the learner well','Content meets the level of the learner well',5,73),(119,'No content identified','No content identified',0,74),(120,'Content is based on repeating same things','Content is based on repeating same things',1,74),(121,'Content covers only one domain','Content covers only one domain',2,74),(122,'Content covers two domains','Content covers two domains',3,74),(123,'Content covers all the three domains but not explained','Content covers all the three domains but not explained',4,74),(124,'Content covers all the three domains and well explained','Content covers all the three domains and well explained',5,74),(125,'No content identified','No content identified',0,75),(126,'No illustrations or examples used','No illustrations or examples used',1,75),(127,'Illustrations without examples used','Illustrations without examples used',2,75),(128,'Relevant experiences from teacher used all the time','Relevant experiences from teacher used all the time',3,75),(129,'Relevant experiences used from learners used','Relevant experiences used from learners used',4,75),(130,'Relevant examples including learners'' experience used all the time','Relevant examples including learners'' experience used all the time',5,75),(131,'One fixed whole group','One fixed whole group',0,76),(132,'Two large groups in class','Two large groups in class',1,76),(133,'Three groups that are used once in a while','Three groups that are used once in a while',2,76),(134,'Four groups that are used sometimes','Four groups that are used sometimes',3,76),(135,'Many fixed groups present and used','Many fixed groups present and used',4,76),(136,'Different groups are formed when need arises','Different groups are formed when need arises',5,76),(137,'No movement space','No movement space',0,77),(138,'Stays at the front all the time','Stays at the front all the time',1,77),(139,'Moves around as mannerism','Moves around as mannerism',2,77),(140,'Moves in class once in a while','Moves in class once in a while',3,77),(141,'Occasionally moves to all parts of the class','Occasionally moves to all parts of the class',4,77),(142,'Purposeful movement in whole class','Purposeful movement in whole class',5,77),(143,'No display','No display',0,78),(144,'Old displays present','Old displays present',1,78),(145,'Displays above class level','Displays above class level',2,78),(146,'Most part of the class is filled with one category of displays','Most part of the class is filled with one category of displays',3,78),(147,'Most part of the class has displays','Most part of the class has displays',4,78),(148,'Various displays seen in class','Various displays seen in class',5,78),(149,'No display','No display',0,79),(150,'Old learners work displayed','Old learners work displayed',1,79),(151,'Some recent learners work displayed in one corner','Some recent learners work displayed in one corner',2,79),(152,'Relevant but old displays seen','Relevant but old displays seen',3,79),(153,'Relevant recent displays seen','Relevant recent displays seen',4,79),(154,'Learners'' work dominates class','Learners'' work dominates class',5,79),(161,'Unruly class','Unruly class',0,80),(162,'Rules available but not followed','Rules available but not followed',1,80),(163,'Rules sometimes followed','Rules sometimes followed',2,80),(164,'Class disciplined in presence of teacher','Class disciplined in presence of teacher',3,80),(165,'Class always follows discipline guide','Class always follows discipline guide',4,80),(166,'Very disciplined class','Very disciplined class',5,80),(167,'Class on its own','Class on its own',0,81),(168,'No system to manage class','No system to manage class',1,81),(169,'Sometimes managed well','Sometimes managed well',2,81),(170,'Adequately managed class','Adequately managed class',3,81),(171,'Well managed class','Well managed class',4,81),(172,'Very well managed class','Very well managed class',5,81),(173,'Harsh teacher','Harsh teacher',0,82),(174,'Authoritative teacher','Authoritative teacher',1,82),(175,'Laisse fair','Laisse fair',2,82),(176,'Flexible teacher','Flexible teacher',3,82),(177,'Firm teacher','Firm teacher',4,82),(178,'Warm relationship','Warm relationship',5,82),(179,'Is not aware of some learners in class','Is not aware of some learners in class',0,83),(180,'Ignores some learners','Ignores some learners',1,83),(181,'Pays too much attention to some learners','Pays too much attention to some learners',2,83),(182,'Sometimes pays attention to learners in need','Sometimes pays attention to learners in need',3,83),(183,'Most times caters for all learners','Most times caters for all learners',4,83),(184,'Caters to all learners all the time','Caters to all learners all the time',5,83),(185,'Very timid','Very timid',0,84),(186,'Scared of learners','Scared of learners',1,84),(187,'Learners control teacher','Learners control teacher',2,84),(188,'Listens to views of learners','Listens to views of learners',3,84),(189,'Parental in presentation','Parental in presentation',4,84),(190,'Professional in presentation','Professional in presentation',5,84),(191,'Has no knowledge of content','Has no knowledge of content',0,85),(192,'Misrepresents content','Misrepresents content',1,85),(193,'Has slight knowledge of content','Has slight knowledge of content',2,85),(194,'Has some facts not clear, but most is clear','Has some facts not clear, but most is clear',3,85),(195,'Good command of basic content','Good command of basic content',4,85),(196,'Expert in the content','Expert in the content',5,85),(197,'Has no idea of what to be done','Has no idea of what to be done',0,86),(198,'Struggles to understand lesson','Struggles to understand lesson',1,86),(199,'Not a role model for learners','Not a role model for learners',2,86),(200,'Sometimes role models desired skills','Sometimes role models desired skills',3,86),(201,'Good role model of skills','Good role model of skills',4,86),(202,'Very good role model of skills','Very good role model of skills',5,86),(203,'Failed to express self in class','Failed to express self in class',0,87),(204,'Easily distracted or derailed by learners','Easily distracted or derailed by learners',1,87),(205,'Concentrates much on own mannerisms','Concentrates much on own mannerisms',2,87),(206,'Speaks only to a few learners near him/her','Speaks only to a few learners near him/her',3,87),(207,'Confident but sometimes overwhelmed by class','Confident but sometimes overwhelmed by class',4,87),(208,'Confident and has full control of class','Confident and has full control of class',5,87),(209,'Never specified any time in plan','Never specified any time in plan',0,88),(210,'Specified time in plan but never started on time','Specified time in plan but never started on time',1,88),(211,'Took less time than planned','Took less time than planned',2,88),(212,'Overshot the planned time a little','Overshot the planned time a little',3,88),(213,'Managed to complete in time','Managed to complete in time',4,88),(214,'Worked within planned time','Worked within planned time',5,88),(215,'Assessment activities were not planned and not given','Assessment activities were not planned and not given',0,89),(216,'Assessment activities were planned but not given','Assessment activities were planned but not given',1,89),(217,'Assessment activities never matched lesson','Assessment activities never matched lesson',2,89),(218,'Assessment activities were too easy for the level','Assessment activities were too easy for the level',3,89),(219,'Assessment activities were too hard for the level','Assessment activities were too hard for the level',4,89),(220,'Assessment activities were relevant for level','Assessment activities were relevant for level',5,89),(221,'Assessment activities were not planned','Assessment activities were not planned',0,90),(222,'Assessment activities were planned but not given','Assessment activities were planned but not given',1,90),(223,'Assessment activities were given but not done','Assessment activities were given but not done',2,90),(224,'Assessment activities were too few for the level','Assessment activities were too few for the level',3,90),(225,'Assessment activities were too much for the level','Assessment activities were too much for the level',4,90),(226,'Assessment activities were adequate for the level','Assessment activities were adequate for the level',5,90),(227,'No assessment activity given','No assessment activity given',0,91),(228,'Work planned but not given and no marking done','Work planned but not given and no marking done',1,91),(229,'Work not marked','Work not marked',2,91),(230,'Work marked for some learners, no corrections given','Work marked for some learners, no corrections given',3,91),(231,'Work marked but no corrections done','Work marked but no corrections done',4,91),(232,'Work marked and corrections provided','Work marked and corrections provided',5,91),(233,'No follow up activity not planned and not given','No follow up activity not planned and not given',0,92),(234,'Follow up activity planned but not given','Follow up activity planned but not given',1,92),(235,'Follow up work given but too little for learners'' level','Follow up work given but too little for learners'' level',2,92),(236,'Follow up work provided but a little beyond capacity of learners','Follow up work provided but a little beyond capacity of learners',3,92),(237,'Follow up work provided but not adequate','Follow up work provided but not adequate',4,92),(238,'Adequate follow up work provided','Adequate follow up work provided',5,92),(239,'Lesson never ended as planned','Lesson never ended as planned',0,93),(240,'Lesson not concluded although it had ended','Lesson not concluded although it had ended',1,93),(241,'Lesson not concluded although the conclusion had been planned','Lesson not concluded although the conclusion had been planned',2,93),(242,'Lesson concluded hurriedly and had limited attention of learners','Lesson concluded hurriedly and had limited attention of learners',3,93),(243,'Lesson concluded but no agreements made for next lesson','Lesson concluded but no agreements made for next lesson',4,93),(244,'Lesson concluded and agreements for next lesson made with learners','Lesson concluded and agreements for next lesson made with learners',5,93),(245,'No self evaluation done','No self evaluation done',0,94),(246,'Self-evaluation is a repeat of what was said of other previous lessons','Self-evaluation is a repeat of what was said of other previous lessons',1,94),(247,'One point given to show lesson taught and not really self-evaluation','One point given to show lesson taught and not really self-evaluation',2,94),(248,'Self-evaluation is based on blaming learners and others','Self-evaluation is based on blaming learners and others',3,94),(249,'Self-evaluation done but reflected both learner and teacher','Self-evaluation done but reflected both learner and teacher',4,94),(250,'Self evaluation reflected teacher''s own areas to show personal growth','Self evaluation reflected teacher''s own areas to show personal growth',5,94);



ALTER TABLE marks
ADD COLUMN marks_scores_sku VARCHAR(255) AFTER date_awarded;


ALTER TABLE scores
ADD COLUMN marks_scores_sku VARCHAR(255) AFTER comment;


ALTER TABLE general_comments
ADD COLUMN marks_scores_sku VARCHAR(255) AFTER comment;






CREATE TABLE databse_backups (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for each backup record
    backup_file_name VARCHAR(255) NOT NULL,    -- File name of the backup
    backup_file_path VARCHAR(255) NOT NULL,    -- Path where the backup file is stored
    backup_date DATETIME NOT NULL,             -- Date and time when the backup was created
    file_size INT,                             -- Size of the backup file in bytes
    created_by VARCHAR(100),                   -- User who initiated the backup
    backup_status ENUM('success', 'failed') DEFAULT 'success',  -- Status of the backup
    description TEXT,                          -- Optional description or notes about the backup
    FOREIGN KEY (created_by) REFERENCES users(username) ON DELETE SET NULL  -- Assuming you have a users table for tracking
);



CREATE TABLE database_backups (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for each backup record
    backup_file_name VARCHAR(255) NOT NULL,    -- File name of the backup
    backup_file_path VARCHAR(255) NOT NULL,    -- Path where the backup file is stored
    backup_date DATETIME NOT NULL,             -- Date and time when the backup was created
    file_size INT,                             -- Size of the backup file in bytes
    created_by VARCHAR(100),                   -- User who initiated the backup
    backup_status ENUM('success', 'failed') DEFAULT 'success',  -- Status of the backup
    description TEXT                         -- Optional description or notes about the backup
    
);



ALTER TABLE database_buckups  RENAME TO database_backups;


