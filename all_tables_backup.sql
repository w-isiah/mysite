-- Backup of table: academic_year
CREATE TABLE IF NOT EXISTS academic_year (
    `id` TEXT,
    `academic_year` TEXT
);

INSERT INTO academic_year (id, academic_year) VALUES ('5', '2024-2025');
INSERT INTO academic_year (id, academic_year) VALUES ('7', '2024/2025');
-- Backup of table: aspect
CREATE TABLE IF NOT EXISTS aspect (
    `aspect_id` TEXT,
    `aspect_name` TEXT,
    `description` TEXT,
    `competence` TEXT,
    `section_id` TEXT
);

INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('16', 'ASPECT 1', '1.	Teacher Preparation (20 maximum rating)', '.....', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('17', 'ASPECT 2', '2.	Methodology (25 maximum rating)', '.', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('18', 'ASPECT 3', '3.	Competences (25 maximum rating)', '.', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('19', 'ASPECT 4', '4.	Learning Resources (15 maximum rating)', '.', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('20', 'ASPECT 5', '5.	Content (20 maximum rating)', '.', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('21', 'ASPECT 6', '6.	Learning Environment (30 maximum rating)', '.', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('22', 'ASPECT 7', '7.	The Teacher (35 maximum rating)', '.', NULL);
INSERT INTO aspect (aspect_id, aspect_name, description, competence, section_id) VALUES ('23', 'ASPECT 8', '8.	Lesson Evaluation (30 Maximum rating )', '', NULL);
-- Backup of table: assessment_criteria
CREATE TABLE IF NOT EXISTS assessment_criteria (
    `criteria_id` TEXT,
    `criteria_name` TEXT,
    `aspect_id` TEXT
);

INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('55', 'a) Schemes of work', '16');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('56', 'b) Lesson plan(s)', '16');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('57', 'c) Effectiveness of preparation', '16');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('58', 'd) Teacher/learner records', '16');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('59', 'a) Choice of methodology', '17');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('60', 'b) Application', '17');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('61', 'c) Inclusiveness', '17');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('62', 'e) Life Skills and values', '17');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('63', 'a) SMARTness', '18');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('64', 'b) Domains addressed', '18');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('65', 'c) Sequencing (Levels)', '18');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('66', 'd) Learner centred', '18');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('67', 'e) Reflect content', '18');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('69', 'a) Selection of resources', '19');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('70', 'b) Use of resources', '19');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('71', 'c) Variety of resources', '19');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('72', 'a) Related to learning framework/curriculum', '20');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('73', 'b) Appropriateness', '20');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('74', 'c) Comprehensiveness', '20');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('75', 'd) Use of relevant examples and illustrations', '20');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('76', 'a) Classroom set up/organisation', '21');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('77', 'b) Classroom movement', '21');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('78', 'c) Variety of display', '21');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('79', 'd) Display of learners work', '21');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('80', 'e) Class discipline', '21');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('81', 'f) Classroom management', '21');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('82', 'a) Teacher-learner relationship', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('83', 'b) Inclusive', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('84', 'c) Personality and presentation', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('85', 'd) Knowledge of content', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('86', 'e) Role modeling', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('87', 'f) Competence and confidence', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('88', 'g) Time management', '22');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('89', 'a) Relevant assessment activities', '23');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('90', 'b) Adequate assessment activities', '23');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('91', 'c) Marking and correction of learner''s work', '23');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('92', 'd) Follow up on learner''s work', '23');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('93', 'e) Lesson Conclusion', '23');
INSERT INTO assessment_criteria (criteria_id, criteria_name, aspect_id) VALUES ('94', 'f) Self-evaluation/reflection', '23');
-- Backup of table: assessor_assignments
CREATE TABLE IF NOT EXISTS assessor_assignments (
    `assignment_id` TEXT,
    `student_id` TEXT,
    `assessor_id` TEXT,
    `term_id` TEXT,
    `assignment_date` TEXT
);

-- Backup of table: assign_assessor
CREATE TABLE IF NOT EXISTS assign_assessor (
    `id` TEXT,
    `assessor_id` TEXT,
    `student_id` TEXT,
    `assigned_by` TEXT,
    `term_id` TEXT
);

INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('28', '15', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('29', '16', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('30', '18', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('31', '19', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('32', '21', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('33', '22', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('34', '23', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('35', '24', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('36', '26', '250', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('37', '15', '257', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('38', '26', '257', '27', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('39', '18', '253', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('40', '15', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('41', '18', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('42', '16', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('43', '19', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('44', '21', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('45', '22', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('46', '23', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('47', '24', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('48', '25', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('49', '26', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('50', '28', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('51', '29', '252', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('52', '26', '301', '17', '4');
INSERT INTO assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('53', '18', '254', '17', '4');
-- Backup of table: database_backups
CREATE TABLE IF NOT EXISTS database_backups (
    `id` TEXT,
    `backup_file_name` TEXT,
    `backup_file_path` TEXT,
    `backup_date` TEXT,
    `file_size` TEXT,
    `created_by` TEXT,
    `backup_status` TEXT,
    `description` TEXT
);

-- Backup of table: d_assign_assessor
CREATE TABLE IF NOT EXISTS d_assign_assessor (
    `id` TEXT,
    `assessor_id` TEXT,
    `assigned_by` TEXT,
    `term_id` TEXT,
    `school_id` TEXT
);

INSERT INTO d_assign_assessor (id, assessor_id, assigned_by, term_id, school_id) VALUES ('4', '15', '17', '4', '2');
INSERT INTO d_assign_assessor (id, assessor_id, assigned_by, term_id, school_id) VALUES ('5', '29', '17', '4', '2');
-- Backup of table: d_external_assign_assessor
CREATE TABLE IF NOT EXISTS d_external_assign_assessor (
    `id` TEXT,
    `assessor_id` TEXT,
    `assigned_by` TEXT,
    `term_id` TEXT,
    `school_id` TEXT
);

INSERT INTO d_external_assign_assessor (id, assessor_id, assigned_by, term_id, school_id) VALUES ('1', '29', '17', '4', '2');
-- Backup of table: d_f_scores
CREATE TABLE IF NOT EXISTS d_f_scores (
    `id` TEXT,
    `student_id` TEXT,
    `coverage` TEXT,
    `quality` TEXT,
    `quantity` TEXT,
    `attractiveness` TEXT,
    `accuracy` TEXT,
    `grading` TEXT,
    `relevance` TEXT,
    `printing` TEXT,
    `durability` TEXT,
    `originality` TEXT,
    `explanation` TEXT,
    `storage` TEXT,
    `assessor_id` TEXT,
    `score_type` TEXT,
    `term_id` TEXT,
    `comment` TEXT
);

INSERT INTO d_f_scores (id, student_id, coverage, quality, quantity, attractiveness, accuracy, grading, relevance, printing, durability, originality, explanation, storage, assessor_id, score_type, term_id, comment) VALUES ('1', '252', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '33.00', '15', 'im', '4', 'trhtrhrstg');
-- Backup of table: d_internal_assign_assessor
CREATE TABLE IF NOT EXISTS d_internal_assign_assessor (
    `id` TEXT,
    `assessor_id` TEXT,
    `assigned_by` TEXT,
    `term_id` TEXT,
    `school_id` TEXT
);

INSERT INTO d_internal_assign_assessor (id, assessor_id, assigned_by, term_id, school_id) VALUES ('16', '19', '17', '4', '4');
-- Backup of table: general_comments
CREATE TABLE IF NOT EXISTS general_comments (
    `id` TEXT,
    `student_id` TEXT,
    `assessor_id` TEXT,
    `term_id` TEXT,
    `comment` TEXT,
    `marks_scores_sku` TEXT,
    `created_at` TEXT,
    `updated_at` TEXT
);

INSERT INTO general_comments (id, student_id, assessor_id, term_id, comment, marks_scores_sku, created_at, updated_at) VALUES ('55', '250', '15', '3', 'dome', '1258566951', '2025-03-08 03:42:15', '2025-03-08 03:42:15');
-- Backup of table: marks
CREATE TABLE IF NOT EXISTS marks (
    `mark_id` TEXT,
    `student_id` TEXT,
    `term_id` TEXT,
    `assessor_id` TEXT,
    `school_id` TEXT,
    `marks` TEXT,
    `assessment_type` TEXT,
    `date_awarded` TEXT,
    `marks_scores_sku` TEXT
);

INSERT INTO marks (mark_id, student_id, term_id, assessor_id, school_id, marks, assessment_type, date_awarded, marks_scores_sku) VALUES ('128', '250', '3', '15', '4', '16', 'system', '2025-03-08', '1258566951');
-- Backup of table: mudulate_marks
CREATE TABLE IF NOT EXISTS mudulate_marks (
    `mark_id` TEXT,
    `student_id` TEXT,
    `term_id` TEXT,
    `assessor_id` TEXT,
    `school_id` TEXT,
    `marks` TEXT,
    `assessment_type` TEXT,
    `date_awarded` TEXT
);

INSERT INTO mudulate_marks (mark_id, student_id, term_id, assessor_id, school_id, marks, assessment_type, date_awarded) VALUES ('7', '252', '4', '17', '2', '88', 'modulate', '2025-02-21');
-- Backup of table: m_assign_assessor
CREATE TABLE IF NOT EXISTS m_assign_assessor (
    `id` TEXT,
    `assessor_id` TEXT,
    `student_id` TEXT,
    `assigned_by` TEXT,
    `term_id` TEXT
);

INSERT INTO m_assign_assessor (id, assessor_id, student_id, assigned_by, term_id) VALUES ('1', '15', '250', '17', '4');
-- Backup of table: programmes
CREATE TABLE IF NOT EXISTS programmes (
    `id` TEXT,
    `programme_name` TEXT,
    `description` TEXT,
    `created_at` TEXT,
    `updated_at` TEXT
);

INSERT INTO programmes (id, programme_name, description, created_at, updated_at) VALUES ('1', 'Computer Science', 'A programme that focuses on the fundamentals of computing, programming, and data structures.', '2024-12-10 12:28:51', '2024-12-10 12:28:51');
INSERT INTO programmes (id, programme_name, description, created_at, updated_at) VALUES ('3', 'Business Administration 12', 'A programme that prepares students for management roles in business and organizations.', '2024-12-10 12:28:51', '2024-12-10 12:53:12');
INSERT INTO programmes (id, programme_name, description, created_at, updated_at) VALUES ('12', 'Bachelor in Pre-Primary Education', 'A programme that prepares students to work with learners in early learning institutions.', '2025-02-06 19:58:49', '2025-02-06 19:58:49');
-- Backup of table: ratings
CREATE TABLE IF NOT EXISTS ratings (
    `id` TEXT,
    `rating` TEXT,
    `description` TEXT,
    `mark` TEXT,
    `assessment_criteria_id` TEXT
);

INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('11', 'No scheme available', 'No scheme available', '0', '55');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('12', 'Has just started scheming', 'Has just started scheming', '1', '55');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('13', 'Has an incomplete scheme', 'Has an incomplete scheme', '2', '55');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('14', 'Almost finished scheme', 'Almost finished scheme', '3', '55');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('15', 'Has complete scheme but not approved', 'Has complete scheme but not approved', '4', '55');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('16', 'Has complete and approved scheme', 'Has complete and approved scheme', '5', '55');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('17', 'No lesson plan available', 'No lesson plan available', '0', '56');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('18', 'Plan does not follow format', 'Plan does not follow format', '1', '56');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('19', 'Plan follows format but not complete', 'Plan follows format but not complete', '2', '56');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('20', 'Complete but no self evaluation', 'Complete but no self evaluation', '3', '56');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('21', 'complete but evaluation doesn''t focus on self', 'complete but evaluation doesn''t focus on self', '4', '56');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('22', 'Complete and accurate self evaluated lesson plan', 'Complete and accurate self evaluated lesson plan', '5', '56');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('23', 'Not Prepared', 'Not Prepared', '0', '57');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('24', 'Only schemes', 'Only schemes', '1', '57');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('25', 'Plus lesson plan', 'Plus lesson plan', '2', '57');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('26', 'Plus Activity Plans', 'Plus Activity Plans', '3', '57');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('27', 'Plus prepared Materials', 'Plus prepared Materials', '4', '57');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('28', 'With all requirements', 'With all requirements', '5', '57');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('29', 'No learner records kept', 'No learner records kept', '0', '58');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('30', 'Some learner records outline seen', 'Some learner records outline seen', '1', '58');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('31', 'Some learner records are missing', 'Some learner records are missing', '2', '58');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('32', 'Some learner records are not regularly kept', 'Some learner records are not regularly kept', '3', '58');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('33', 'Learner records kept but not accurate', 'Learner records kept but not accurate', '4', '58');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('34', 'All learner records accurately kept', 'All learner records accurately kept', '5', '58');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('35', 'No method chosen', 'No method chosen', '0', '59');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('36', 'Has no idea of chosen methods', 'Has no idea of chosen methods', '1', '59');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('37', 'Chosen methodology not appropriate for class', 'Chosen methodology not appropriate for class', '2', '59');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('38', 'Appropriate but not used appropriately', 'Appropriate but not used appropriately', '3', '59');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('39', 'Appropriate for lesson but not for class level', 'Appropriate for lesson but not for class level', '4', '59');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('40', 'Appropriate for class and lesson levels', 'Appropriate for class and lesson levels', '5', '59');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('41', 'No method applied', 'No method applied', '0', '60');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('42', 'Techniques identified', 'Techniques identified', '1', '60');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('43', 'No attempt made to utilize the techniques', 'No attempt made to utilize the techniques', '2', '60');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('44', 'Techniques applied but confusion noticed', 'Techniques applied but confusion noticed', '3', '60');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('45', 'Techniques applied in some instances', 'Techniques applied in some instances', '4', '60');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('46', 'Techniques applied appropriately', 'Techniques applied appropriately', '5', '60');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('47', 'No method chosen', 'No method chosen', '0', '61');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('48', 'More than two methods planned for in the lesson', 'More than two methods planned for in the lesson', '1', '61');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('49', 'Limited understanding of methods seen', 'Limited understanding of methods seen', '2', '61');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('50', 'Most methods planned for were never used', 'Most methods planned for were never used', '3', '61');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('51', 'Most of the methods planned used appropriately', 'Most of the methods planned used appropriately', '4', '61');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('52', 'All planned for methods used appropriately', 'All planned for methods used appropriately', '5', '61');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('53', 'No method chosen', 'No method chosen', '0', '62');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('54', 'More than two methods planned for in the lesson', 'More than two methods planned for in the lesson', '1', '62');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('55', 'Limited understanding of methods seen', 'Limited understanding of methods seen', '2', '62');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('56', 'Most methods planned for were never used', 'Most methods planned for were never used', '3', '62');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('57', 'Most of the methods planned used appropriately', 'Most of the methods planned used appropriately', '4', '62');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('58', 'All planned for methods used appropriately', 'All planned for methods used appropriately', '5', '62');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('59', 'No competence identified', 'No competence identified', '0', '63');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('60', 'Competences identified', 'Competences identified', '1', '63');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('61', 'Compound competences identified', 'Compound competences identified', '2', '63');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('62', 'Simple, but not so clear competences identified', 'Simple, but not so clear competences identified', '3', '63');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('63', 'Simple, clear but not easily managed competences', 'Simple, clear but not easily managed competences', '4', '63');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('64', 'Simple, clear and easily managed', 'Simple, clear and easily managed', '5', '63');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('65', 'No domain addressed by a competence', 'No domain addressed by a competence', '0', '64');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('66', 'Domains identified in some competences', 'Domains identified in some competences', '1', '64');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('67', 'Activities to develop domains shown', 'Activities to develop domains shown', '2', '64');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('68', 'One domain dominates', 'One domain dominates', '3', '64');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('69', 'Two domains catered for', 'Two domains catered for', '4', '64');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('70', 'Three domains catered for', 'Three domains catered for', '5', '64');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('71', 'No levels identified', 'No levels identified', '0', '65');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('72', 'Levels identified', 'Levels identified', '1', '65');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('73', 'Levels don''t have current learners in mind', 'Levels don''t have current learners in mind', '2', '65');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('74', 'Sequencing not done', 'Sequencing not done', '3', '65');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('75', 'Sequencing done but not simple to complex', 'Sequencing done but not simple to complex', '4', '65');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('76', 'Seq
uencing done from simple to complex', 'Sequencing done from simple to complex', '5', '65');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('77', 'No mention of who the focus will be on', 'No mention of who the focus will be on', '0', '66');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('78', 'Approach to lesson identified', 'Approach to lesson identified', '1', '66');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('79', 'Teacher centred approach used', 'Teacher centred approach used', '2', '66');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('80', 'Limited learner involvement seen. Teacher takes over a lot', 'Limited learner involvement seen. Teacher takes over a lot', '3', '66');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('81', 'Mix of teacher and learner participation', 'Mix of teacher and learner participation', '4', '66');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('82', 'Learners involved most of the time. Teacher was a guide', 'Learners involved most of the time. Teacher was a guide', '5', '66');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('83', 'No content specified', 'No content specified', '0', '67');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('84', 'Content identified', 'Content identified', '1', '67');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('85', 'Content not from approved syllabus', 'Content not from approved syllabus', '2', '67');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('86', 'Content from approved syllabus but not broken down appropriately', 'Content from approved syllabus but not broken down appropriately', '3', '67');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('87', 'Content was from syllabus, but not well structured in the planning', 'Content was from syllabus, but not well structured in the planning', '4', '67');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('88', 'Content was from approved syllabus, well structured in the planning', 'Content was from approved syllabus, well structured in the planning', '5', '67');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('89', 'Resources not selected', 'Resources not selected', '0', '69');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('90', 'Some few resources selected', 'Some few resources selected', '1', '69');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('91', 'Resources selected but are not from learners'' environment', 'Resources selected but are not from learners'' environment', '2', '69');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('92', 'Resources selected are mainly for the teacher', 'Resources selected are mainly for the teacher', '3', '69');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('93', 'Resources selected but cant be used by some learners', 'Resources selected but cant be used by some learners', '4', '69');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('94', 'Resources selected appropriately for learners', 'Resources selected appropriately for learners', '5', '69');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('95', 'Resources not used', 'Resources not used', '0', '70');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('96', 'Resources used by the teacher for a short time', 'Resources used by the teacher for a short time', '1', '70');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('97', 'Resources used by the teacher all the time', 'Resources used by the teacher all the time', '2', '70');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('98', 'Resources used by some learners for a short time', 'Resources used by some learners for a short time', '3', '70');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('99', 'Resources used by most learners all the time', 'Resources used by most learners all the time', '4', '70');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('100', 'Resources used by all learners all the time', 'Resources used by all learners all the time', '5', '70');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('101', 'No resource identified', 'No resource identified', '0', '71');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('102', 'No resource used in the lesson', 'No resource used in the lesson', '1', '71');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('103', 'One resource used in the lesson', 'One resource used in the lesson', '2', '71');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('104', 'Two resources used in lesson', 'Two resources used in lesson', '3', '71');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('105', 'Three resources used in lesson', 'Three resources used in lesson', '4', '71');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('106', 'More than three resources used by learners', 'More than three resources used by learners', '5', '71');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('107', 'Content not related to curriculum', 'Content not related to curriculum', '0', '72');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('108', 'Content is related to the curriculum, but competences are not accurate.', 'Content is related to the curriculum, but competences are not accurate.', '1', '72');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('109', 'About 10% of content is related to the curriculum.', 'About 10% of content is related to the curriculum.', '2', '72');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('110', 'About 30% of the content is related to learning and the curriculum.', 'About 30% of the content is related to learning and the curriculum.', '3', '72');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('111', 'About 80% of the content is related to learning and the curriculum', 'About 80% of the content is related to learning and the curriculum', '4', '72');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('112', 'All content is related to learning and the curriculum.', 'All content is related to learning and the curriculum.', '5', '72');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('113', 'No content identified', 'No content identified', '0', '73');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('114', 'Content does not match competence and learner level', 'Content does not match competence and learner level', '1', '73');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('115', 'Content fits some competences', 'Content fits some competences', '2', '73');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('116', 'Content fits most of the competences', 'Content fits most of the competences', '3', '73');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('117', 'Content is appropriate, but slightly above class level', 'Content is appropriate, but slightly above class level', '4', '73');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('118', 'Content meets the level of the learner well', 'Content meets the level of the learner well', '5', '73');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('119', 'No content identified', 'No content identified', '0', '74');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('120', 'Content is based on repeating same things', 'Content is based on repeating same things', '1', '74');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('121', 'Content covers only one domain', 'Content covers only one domain', '2', '74');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('122', 'Content covers two domains', 'Content covers two domains', '3', '74');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('123', 'Content covers all the three domains but not explained', 'Content covers all the three domains but not explained', '4', '74');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('124', 'Content covers all the three domains and well explained', 'Content covers all the three domains and well explained', '5', '74');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('125', 'No content identified', 'No content identified', '0', '75');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('126', 'No illustrations or examples used', 'No illustrations or examples used', '1', '75');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('127', 'Illustrations without examples used', 'Illustrations without examples used', '2', '75');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('128', 'Relevant experiences from teacher used all the time', 'Relevant experiences from t
eacher used all the time', '3', '75');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('129', 'Relevant experiences used from learners used', 'Relevant experiences used from learners used', '4', '75');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('130', 'Relevant examples including learners'' experience used all the time', 'Relevant examples including learners'' experience used all the time', '5', '75');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('131', 'One fixed whole group', 'One fixed whole group', '0', '76');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('132', 'Two large groups in class', 'Two large groups in class', '1', '76');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('133', 'Three groups that are used once in a while', 'Three groups that are used once in a while', '2', '76');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('134', 'Four groups that are used sometimes', 'Four groups that are used sometimes', '3', '76');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('135', 'Many fixed groups present and used', 'Many fixed groups present and used', '4', '76');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('136', 'Different groups are formed when need arises', 'Different groups are formed when need arises', '5', '76');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('137', 'No movement space', 'No movement space', '0', '77');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('138', 'Stays at the front all the time', 'Stays at the front all the time', '1', '77');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('139', 'Moves around as mannerism', 'Moves around as mannerism', '2', '77');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('140', 'Moves in class once in a while', 'Moves in class once in a while', '3', '77');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('141', 'Occasionally moves to all parts of the class', 'Occasionally moves to all parts of the class', '4', '77');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('142', 'Purposeful movement in whole class', 'Purposeful movement in whole class', '5', '77');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('143', 'No display', 'No display', '0', '78');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('144', 'Old displays present', 'Old displays present', '1', '78');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('145', 'Displays above class level', 'Displays above class level', '2', '78');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('146', 'Most part of the class is filled with one category of displays', 'Most part of the class is filled with one category of displays', '3', '78');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('147', 'Most part of the class has displays', 'Most part of the class has displays', '4', '78');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('148', 'Various displays seen in class', 'Various displays seen in class', '5', '78');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('149', 'No display', 'No display', '0', '79');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('150', 'Old learners work displayed', 'Old learners work displayed', '1', '79');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('151', 'Some recent learners work displayed in one corner', 'Some recent learners work displayed in one corner', '2', '79');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('152', 'Relevant but old displays seen', 'Relevant but old displays seen', '3', '79');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('153', 'Relevant recent displays seen', 'Relevant recent displays seen', '4', '79');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('154', 'Learners'' work dominates class', 'Learners'' work dominates class', '5', '79');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('161', 'Unruly class', 'Unruly class', '0', '80');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('162', 'Rules available but not followed', 'Rules available but not followed', '1', '80');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('163', 'Rules sometimes followed', 'Rules sometimes followed', '2', '80');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('164', 'Class disciplined in presence of teacher', 'Class disciplined in presence of teacher', '3', '80');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('165', 'Class always follows discipline guide', 'Class always follows discipline guide', '4', '80');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('166', 'Very disciplined class', 'Very disciplined class', '5', '80');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('167', 'Class on its own', 'Class on its own', '0', '81');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('168', 'No system to manage class', 'No system to manage class', '1', '81');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('169', 'Sometimes managed well', 'Sometimes managed well', '2', '81');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('170', 'Adequately managed class', 'Adequately managed class', '3', '81');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('171', 'Well managed class', 'Well managed class', '4', '81');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('172', 'Very well managed class', 'Very well managed class', '5', '81');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('173', 'Harsh teacher', 'Harsh teacher', '0', '82');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('174', 'Authoritative teacher', 'Authoritative teacher', '1', '82');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('175', 'Laisse fair', 'Laisse fair', '2', '82');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('176', 'Flexible teacher', 'Flexible teacher', '3', '82');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('177', 'Firm teacher', 'Firm teacher', '4', '82');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('178', 'Warm relationship', 'Warm relationship', '5', '82');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('179', 'Is not aware of some learners in class', 'Is not aware of some learners in class', '0', '83');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('180', 'Ignores some learners', 'Ignores some learners', '1', '83');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('181', 'Pays too much attention to some learners', 'Pays too much attention to some learners', '2', '83');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('182', 'Sometimes pays attention to learners in need', 'Sometimes pays attention to learners in need', '3', '83');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('183', 'Most times caters for all learners', 'Most times caters for all learners', '4', '83');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('184', 'Caters to all learners all the time', 'Caters to all learners all the time', '5', '83');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('185', 'Very timid', 'Very timid', '0', '84');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('186', 'Scared of learners', 'Scared of learners', '1', '84');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('187', 'Learners control teacher', 'Learners control teacher', '2', '84');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('188', 'Listens to views of learners', 'Listens to views of learners', '3', '84');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('189', 'Parental in presentation', 'Parental in presentation', '4', '84');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('190', 'Professional in presentation', 'Professional in presentation', '5', '84');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('191', 'Has no knowledge of content', 'Has no knowledge of content', '0', '85');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('192', 'Misrepresents content', 'Misrepresents content', '1', '85');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('193', 'Has slight knowledge of content', 'Has slight knowledge of content', '2', '85');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('194', 'Has some facts not clear, but most is clear', 'Has some facts not clear, but most is clear', '3', '85');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('195', 'Good command of basic content', 'Good command of basic content', '4', '85');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('196', 'Expert in the content', 'Expert in the content', '5', '85');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('197', 'Has no idea of what to be done', 'Has no idea of what to be done', '0', '86');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('198', 'Struggles to understand lesson', 'Struggles to understand lesson', '1', '86');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('199', 'Not a role model for learners', 'Not a role model for learners', '2', '86');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('200', 'Sometimes role models desired skills', 'Sometimes role models desired skills', '3', '86');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('201', 'Good role model of skills', 'Good role model of skills', '4', '86');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('202', 'Very good role model of skills', 'Very good role model of skills', '5', '86');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('203', 'Failed to express self in class', 'Failed to express self in class', '0', '87');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('204', 'Easily distracted or derailed by learner
s', 'Easily distracted or derailed by learners', '1', '87');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('205', 'Concentrates much on own mannerisms', 'Concentrates much on own mannerisms', '2', '87');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('206', 'Speaks only to a few learners near him/her', 'Speaks only to a few learners near him/her', '3', '87');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('207', 'Confident but sometimes overwhelmed by class', 'Confident but sometimes overwhelmed by class', '4', '87');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('208', 'Confident and has full control of class', 'Confident and has full control of class', '5', '87');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('209', 'Never specified any time in plan', 'Never specified any time in plan', '0', '88');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('210', 'Specified time in plan but never started on time', 'Specified time in plan but never started on time', '1', '88');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('211', 'Took less time than planned', 'Took less time than planned', '2', '88');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('212', 'Overshot the planned time a little', 'Overshot the planned time a little', '3', '88');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('213', 'Managed to complete in time', 'Managed to complete in time', '4', '88');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('214', 'Worked within planned time', 'Worked within planned time', '5', '88');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('215', 'Assessment activities were not planned and not given', 'Assessment activities were not planned and not given', '0', '89');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('216', 'Assessment activities were planned but not given', 'Assessment activities were planned but not given', '1', '89');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('217', 'Assessment activities never matched lesson', 'Assessment activities never matched lesson', '2', '89');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('218', 'Assessment activities were too easy for the level', 'Assessment activities were too easy for the level', '3', '89');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('219', 'Assessment activities were too hard for the level', 'Assessment activities were too hard for the level', '4', '89');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('220', 'Assessment activities were relevant for level', 'Assessment activities were relevant for level', '5', '89');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('221', 'Assessment activities were not planned', 'Assessment activities were not planned', '0', '90');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('222', 'Assessment activities were planned but not given', 'Assessment activities were planned but not given', '1', '90');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('223', 'Assessment activities were given but not done', 'Assessment activities were given but not done', '2', '90');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('224', 'Assessment activities were too few for the level', 'Assessment activities were too few for the level', '3', '90');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('225', 'Assessment activities were too much for the level', 'Assessment activities were too much for the level', '4', '90');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('226', 'Assessment activities were adequate for the level', 'Assessment activities were adequate for the level', '5', '90');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('227', 'No assessment activity given', 'No assessment activity given', '0', '91');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('228', 'Work planned but not given and no marking done', 'Work planned but not given and no marking done', '1', '91');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('229', 'Work not marked', 'Work not marked', '2', '91');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('230', 'Work marked for some learners, no corrections given', 'Work marked for some learners, no corrections given', '3', '91');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('231', 'Work marked but no corrections done', 'Work marked but no corrections done', '4', '91');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('232', 'Work marked and corrections provided', 'Work marked and corrections provided', '5', '91');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('233', 'No follow up activity not planned and not given', 'No follow up activity not planned and not given', '0', '92');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('234', 'Follow up activity planned but not given', 'Follow up activity planned but not given', '1', '92');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('235', 'Follow up work given but too little for learners'' level', 'Follow up work given but too little for learners'' level', '2', '92');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('236', 'Follow up work provided but a little beyond capacity of learners', 'Follow up work provided but a little beyond capacity of learners', '3', '92');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('237', 'Follow up work provided but not adequate', 'Follow up work provided but not adequate', '4', '92');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('238', 'Adequate follow up work provided', 'Adequate follow up work provided', '5', '92');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('239', 'Lesson never ended as planned', 'Lesson never ended as planned', '0', '93');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('240', 'Lesson not concluded although it had ended', 'Lesson not concluded although it had ended', '1', '93');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('241', 'Lesson not concluded although the conclusion had been planned', 'Lesson not concluded although the conclusion had been planned', '2', '93');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('242', 'Lesson concluded hurriedly and had limited attention of learners', 'Lesson concluded hurriedly and had limited attention of learners', '3', '93');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('243', 'Lesson concluded but no agreements made for next lesson', 'Lesson concluded but no agreements made for next lesson', '4', '93');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('244', 'Lesson concluded and agreements for next lesson made with learners', 'Lesson concluded and agreements for next lesson made with learners', '5', '93');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('245', 'No self evaluation done', 'No self evaluation done', '0', '94');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('246', 'Self-evaluation is a repeat of what was said of other previous lessons', 'Self-evaluation is a repeat of what was said of other previous lessons', '1', '94');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('247', 'One point given to show lesson taught and not really self-evaluation', 'One point given to show lesson taught and not really self-evaluation', '2', '94');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('248', 'Self-evaluation is based on blaming learners and others', 'Self-evaluation is based on blaming learners and others', '3', '94');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('249', 'Self-evaluation done but reflected both learner and teacher', 'Self-evaluation done but reflected both learner and teacher', '4', '94');
INSERT INTO ratings (id, rating, description, mark, assessment_criteria_id) VALUES ('250', 'Self evaluation reflected teacher''s own areas to show personal growth', 'Self evaluation reflected teacher''s own areas to show personal growth', '5', '94');
-- Backup of table: schools
CREATE TABLE IF NOT EXISTS schools (
    `id` TEXT,
    `category_id` TEXT,
    `name` TEXT,
    `address` TEXT,
    `description` TEXT,
    `contact` TEXT,
    `created_at` TEXT,
    `updated_at` TEXT
);

INSERT INTO schools (id, category_id, name, address, description, contact, created_at, updated_at) VALUES ('2', '2', 'St. Bruno Sserunkuuma''s SS', 'kamengo', 'Secondary School', '0778449169', '2025-02-04 20:16:36', '2025-02-04 20:16:36');
INSERT INTO schools (id, category_id, name, address, description, contact, created_at, updated_at) VALUES ('3', '1', 'Mengo Senoir School', 'Mengo', 'Good School', '07777777', '2025-03-03 15:53:39', '2025-03-03 15:53:39');
INSERT INTO schools (id, category_id, name, address, description, contact, created_at, updated_at) VALUES ('4', '1', 'Hilton High', 'school', 'secondary', '0759623689', '2025-03-03 15:58:07', '2025-03-03 15:58:07');
-- Backup of table: school_category
CREATE TABLE IF NOT EXISTS school_category (
    `id` TEXT,
    `category_name` TEXT,
    `description` TEXT,
    `created_at` TEXT,
    `updated_at` TEXT
);

INSERT INTO school_category (id, category_name, description, created_at, updated_at) VALUES ('1', 'Main Campus', 'Main Campus', '2025-01-30 04:29:54', '2025-01-30 04:29:54');
INSERT INTO school_category (id, category_name, description, created_at, updated_at) VALUES ('2', 'DEC', 'DEC', '2025-01-30 04:36:21', '2025-01-30 04:36:21');
-- Backup of table: scores
CREATE TABLE IF NOT EXISTS scores (
    `id` TEXT,
    `school_id` TEXT,
    `student_id` TEXT,
    `aspect_id` TEXT,
    `criteria_id` TEXT,
    `assessor_id` TEXT,
    `term_id` TEXT,
    `score` TEXT,
    `created_at` TEXT,
    `updated_at` TEXT,
    `comment` TEXT,
    `marks_scores_sku` TEXT
);

INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2347', '4', '250', '16', '55', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2348', '4', '250', '16', '56', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2349', '4', '250', '16', '57', '15', '3', '4.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2350', '4', '250', '16', '58', '15', '3', '5.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2351', '4', '250', '17', '59', '15', '3', '2.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2352', '4', '250', '17', '60', '15', '3', '5.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2353', '4', '250', '17', '61', '15', '3', '5.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2354', '4', '250', '17', '62', '15', '3', '2.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2355', '4', '250', '18', '63', '15', '3', '4.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2356', '4', '250', '18', '64', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2357', '4', '250', '18', '65', '15', '3', '4.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2358', '4', '250', '18', '66', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2359', '4', '250', '18', '67', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2360', '4', '250', '19', '69', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2361', '4', '250', '19', '70', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2362', '4', '250', '19', '71', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2363', '4', '250', '20', '72', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2364', '4', '250', '20', '73', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2365', '4', '250', '20', '74', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2366', '4', '250', '20', '75', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2367', '4', '250', '21', '76', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2368', '4', '250', '21', '77', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2369', '4', '250', '21', '78', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2370', '4', '250', '21', '79', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2371', '4', '250', '21', '80', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2372', '4', '250', '21', '81', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2373', '4', '250', '22', '82', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2374', '4', '250', '22', '83', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2375', '4', '250', '22', '84', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2376', '4', '250', '22', '85', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2377', '4', '250', '22', '86', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2378', '4', '250', '22', '87', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2379', '4', '250', '22', '88', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2380', '4', '250', '23', '89', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2381', '4', '250', '23', '90', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2382', '4', '250', '23', '91', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2383', '4', '250', '23', '92', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2384', '4', '250', '23', '93', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
INSERT INTO scores (id, school_id, student_id, aspect_id, criteria_id, assessor_id, term_id, score, created_at, updated_at, comment, marks_scores_sku) VALUES ('2385', '4', '250', '23', '94', '15', '3', '0.00', '2025-03-08 03:42:15', '2025-03-08 03:42:15', NULL, '1258566951');
-- Backup of table: student_info
CREATE TABLE IF NOT EXISTS student_info (
    `id` TEXT,
    `student_teacher` TEXT,
    `programme_id` TEXT,
    `reg_no` TEXT,
    `subject` TEXT,
    `term_id` TEXT,
    `class_name` TEXT,
    `topic` TEXT,
    `subtopic` TEXT,
    `teaching_time` TEXT,
    `school_id` TEXT,
    `academic_year_id` TEXT,
    `study_year_id` TEXT
);

INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('250', 'AALIYAH  IBRAHIM MUGALU', '12', '24/U/PPD/01894/PD', 'Science', '3', 'S3 East', 'gears', 'Topic 2', '2025-02-12 19:03:00', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('251', 'AHEREZA SHIVAN', '12', '24/U/PPD/02298/PD', 'Science', '3', 'S3 East', 'Topc 2', 'Topic 3', '2025-02-12 19:03:00', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('252', 'AISHA BINT SWALLEH', '12', '24//U/PPD/02536/PD', 'Science', '5', 'S3 East', 'Topc 3', 'Topic 4', '2025-02-13 19:02:59', '4', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('253', 'AMUGE IRENE', '12', '24/U/PPD/03175/PD', 'Science', '3', 'S3 East', 'Topc 4', 'Topic 5', '2025-02-14 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('254', 'ANKWASE SHANITA', '12', '24/U/PPD/03292/PD', 'Science', '4', 'S3 East', 'Topc 5', 'Topic 6', '2025-02-15 19:02:59', '2', '5', '5');
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('255', 'AYO CHRISTINE NYACHOT', '12', '24/U/PPD/04106/PD', 'Science', '4', 'S3 East', 'Topc 6', 'Topic 7', '2025-02-16 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('256', 'BALIWALI NAUME FLORENCE', '12', '24/U/PPD/04232/PD', 'Science', '4', 'S3 East', 'Topc 7', 'Topic 8', '2025-02-17 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('257', 'KATONO EVE MIREMBE', '12', '24/U/PPD/05778/PD', 'Science', '4', 'S3 East', 'Topc 8', 'Topic 9', '2025-02-18 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('258', 'KEMBABAZI  MARTHA', '12', '24/U/PPD/05949/PD', 'Science', '4', 'S3 East', 'Topc 9', 'Topic 10', '2025-02-19 19:02:59', '4', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('259', 'KEMIGISA CHARITY', '12', '24/U/PPD/05955/PD', 'Science', '4', 'S3 East', 'Topc 10', 'Topic 11', '2025-02-20 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('260', 'KISAKYE MARY', '12', '24/U/PPD/06253/PD', 'Science', '4', 'S3 East', 'Topc 11', 'Topic 12', '2025-02-21 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('261', 'KYAZIKE VICTORIA', '12', '24/U/PPD/17954/PD', 'Science', '4', 'S3 East', 'Topc 12', 'Topic 13', '2025-02-22 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('262', 'LOGOSE PATIENCE', '12', '24/U/PPD/06704/PD', 'Science', '4', 'S3 East', 'Topc 13', 'Topic 14', '2025-02-23 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('263', 'LUBULUA PRISCILLA', '12', '24/U/PPD/06770/PD', 'Science', '4', 'S3 East', 'Topc 14', 'Topic 15', '2025-02-24 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('264', 'LUSIBA JOHN', '12', '24/U/PPD/06832/PD', 'Science', '4', 'S3 East', 'Topc 15', 'Topic 16', '2025-02-25 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('265', 'MIREMBE ESTHER', '12', '24/U/PPD/07195/PD', 'Science', '4', 'S3 East', 'Topc 16', 'Topic 17', '2025-02-26 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('266', 'MUDONDO LETICIA', '12', '24/U/PPD/07298/PD', 'Science', '4', 'S3 East', 'Topc 17', 'Topic 18', '2025-02-27 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('267', 'MUSEMYA LOUBEN BONNY', '12', '24/U/PPD/07795/PD', 'Science', '4', 'S3 East', 'Topc 18', 'Topic 19', '2025-02-28 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('268', 'MUSIMENTA MARTHA', '12', '24/U/PPD/07828/PD', 'Science', '4', 'S3 East', 'Topc 19', 'Topic 20', '2025-03-01 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('269', 'MUTESI QUEEN  SHIFAH', '12', '24/U/PPD/07921/PD', 'Science', '4', 'S3 East', 'Topc 20', 'Topic 21', '2025-03-02 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('270', 'NABANKEMA RACHEAL', '12', '24/U/PPD/08189/PD', 'Science', '4', 'S3 East', 'Topc 21', 'Topic 22', '2025-03-03 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('271', 'NABASUMBA PRECIOUS', '12', '24/U/PPD/08198/PD', 'Science', '4', 'S3 East', 'Topc 22', 'Topic 23', '2025-03-04 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('272', 'NABATANZI FLAVIA CHARITY', '12', '24/U/PPD/08211/PD', 'Science', '4', 'S3 East', 'Topc 23', 'Topic 24', '2025-03-05 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('273', 'NABBAALE JOAN ELIZABETH ', '12', '24/U/PPD/19243/PD', 'Science', '4', 'S3 East', 'Topc 24', 'Topic 25', '2025-03-06 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('274', 'NABUKEERA TEDDY', '12', '24/U/PPD/08324/PD', 'Science', '4', 'S3 East', 'Topc 25', 'Topic 26', '2025-03-07 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('275', 'NAHABWE UNIKEY', '12', '24/U/PPD/08518/PD', 'Science', '4', 'S3 East', 'Topc 26', 'Topic 27', '2025-03-08 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('276', 'NAKAGGWA REHEMAH', '12', '24/U/PPD/08642/PD', 'Science', '4', 'S3 East', 'Topc 27', 'Topic 28', '2025-03-09 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('277', 'NAKATO THEOPISTA NABAKKA', '12', '24/U/PPD/08742/PD', 'Science', '4', 'S3 East', 'Topc 28', 'Topic 29', '2025-03-10 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('278', 'NAKAZZI JESCA MIREMBE', '12', '24/U/PPD/08809/PD', 'Science', '4', 'S3 East', 'Topc 29', 'Topic 30', '2025-03-11 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('279', 'NAKIWALA ANGELLA', '12', '24/U/PPD/08945/PD', 'Science', '4', 'S3 East', 'Topc 30', 'Topic 31', '2025-03-12 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('280', 'NALUMANSI HALIMA', '12', '24/U/PPD/09103/PD', 'Science', '4', 'S3 East', 'Topc 31', 'Topic 32', '2025-03-13 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('281', 'NALUYANGE GRACE', '12', '24/U/PPD/09130/PD', 'Science', '4', 'S3 East', 'Topc 32', 'Topic 33', '2025-03-14 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('282', 'NAMAGAMBE RITAH', '12', '24/U/PPD/09159/PD', 'Science', '4', 'S3 East', 'Topc 33', 'Topic 34', '2025-03-15 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('283', 'NAMALA ESTHER', '12', '24/U/PPD/09201/PD', 'Science', '4', 'S3 East', 'Topc 34', 'Topic 35', '2025-03-16 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('284', 'NAMATA FAITH JOVIA', '12', '24/U/PPD/09241/PD', 'Science', '4', 'S3 East', 'Topc 35', 'Topic 36', '2025-03-17 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('285', 'NAMAGANDA CHRISTINE', '12', '24/U/PPD/09167/PD', 'Science', '4', 'S3 East', 'Topc 36', 'Topic 37', '2025-03-18 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('286', 'NAMPIJJA MARIA GORRET', '12', '24/U/PPD/18301/PD', 'Science', '4', 'S3 East', 'Topc 37', 'Topic 38', '2025-03-19 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('287', 'NANTEZA  EDITH ', '12', '24/U/PPD/09849/PD', 'Science', '4', 'S3 East', 'Topc 38', 'Topic 39', '2025-03-20 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('288', 'NANZIRI PAULINE', '12', '24/U/PPD/09908/PD', 'Science', '4', 'S3 East', 'Topc 39', 'Topic 40', '2025-03-21 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('289', 'NASSUNA RINAH', '12', '24/U/PPD/10007/PD', 'Science', '4', 'S3 East', 'Topc 40', 'Topic 41', '2025-03-22 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('290', 'NAYIGA WINNIE', '12', '24/U/PPD/10119/PD', 'Science', '4', 'S3 East', 'Topc 41', 'Topic 42', '2025-03-23 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('291', 'NIWASIIMA YVONNE DOROTHY', '12', '24/U/PPD/10328/PD', 'Science', '4', 'S3 East', 'Topc 42', 'Topic 43', '2025-03-24 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('292', 'PULISI FRANCIS', '12', '24/U/PPD/11430/PD', 'Science', '4', 'S3 East', 'Topc 43', 'Topic 44', '2025-03-25 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('293', 'TUSUBIRA PRISCILLA', '12', '24/U/PPD/14985/PD', 'Science', '4', 'S3 East', 'Topc 44', 'Topic 45', '2025-03-26 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('294', 'WAISWA GEORGE ', '12', '24/U/PPD/12390/PD', 'Science', '4', 'S3 East', 'Topc 45', 'Topic 46', '2025-03-27 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('295', 'WAMBI PATRICK', '12', '24/U/PPD/12447/PD', 'Science', '4', 'S3 East', 'Topc 46', 'Topic 47', '2025-03-28 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('296', 'WANYANA JULIAN TRACY ', '12', '24/U/PPD/12518/PD', 'Science', '3', 'S3 East', 'Topc 47', 'Topic 48', '2025-03-29 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('297', 'ZAWEDDE IMMACULATE', '12', '24/U/PPD/12656/PD', 'Science', '4', 'S3 East', 'Topc 48', 'Topic 49', '2025-03-30 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('298', 'NAKAYIWA SWABURAH', '12', '24/U/PPD/07788/PD', 'Science', '4', 'S3 East', 'Topc 49', 'Topic 50', '2025-03-31 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('299', 'NDAGIRE MAUREEN', '12', '24/U/PPD/10146/PD', 'Science', '4', 'S3 East', 'Topc 50', 'Topic 51', '2025-04-01 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('300', 'NAMMENGO PATRICIA BIRUNGI', '12', '24/U/PPD/09350/PD', 'Science', '4', 'S3 East', 'Topc 51', 'Topic 52', '2025-04-02 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('301', 'UWAMAHORO  PATIENCE ', '12', '24/U/PPD/12334/PD', 'Science', '4', 'S3 East', 'Topc 52', 'Topic 53', '2025-04-03 19:02:59', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('302', 'Ssekajja Allan', '1', '24/U/PPD/094/PD', 'one', '4', 'S5 East', 'uganda presidents', 'Cancer', '2025-02-22 18:52:00', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('303', 'Kisenyoi Ronald', '1', '18/p/uu', 'Civil Engineering', '4', 'one', 'Mechanics ', 'Geears', '2025-03-02 00:38:00', NULL, NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('304', 'Ssekajja Allan', '1', '24/U/PPD/28/PD', 'Math', '4', 's3.A', 'dhghdfh', 'rrrr', '2025-03-02 00:42:00', NULL, NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('305', 'Ssekajja Allan', '1', '24/U/PPD/28/PD', 'Math', '4', 's3.A', 'dhghdfh', 'rrrr', '2025-03-02 00:42:00', NULL, NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('306', 'Ssekajja Allan', '1', '24/U/PPD/28/PD', 'Math', '4', 's3.A', 'dhghdfh', 'rrrr', '2025-03-02 00:42:00', NULL, NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('307', 'Ssekajja Allan', '3', '24//U/PPD/02836/PD', 'Math', '4', 's3.A', 'uganda presidents', 'that', '2025-03-02 12:27:00', '2', NULL, NULL);
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('308', 'oliva', '1', '18/u/PE/1234', 'Math', '4', 'S5 East', 'gears', 'Cancer', '2025-03-05 22:25:00', '4', '5', '5');
INSERT INTO student_info (id, student_teacher, programme_id, reg_no, subject, term_id, class_name, topic, subtopic, teaching_time, school_id, academic_year_id, study_year_id) VALUES ('309', 'minu', '1', '18/u/100/PE', 'Math', '4', 'fggf', 'uganda presidents', 'rfff', '2025-03-05 23:26:00', '4', '5', '5');
-- Backup of table: study_year
CREATE TABLE IF NOT EXISTS study_year (
    `id` TEXT,
    `study_year` TEXT
);

INSERT INTO study_year (id, study_year) VALUES ('5', 'year 1');
-- Backup of table: terms
CREATE TABLE IF NOT EXISTS terms (
    `id` TEXT,
    `term` TEXT,
    `year` TEXT,
    `academic_year` TEXT,
    `study_year` TEXT
);

INSERT INTO terms (id, term, year, academic_year, study_year) VALUES ('3', 'Semester_2 Year 2024', NULL, NULL, NULL);
INSERT INTO terms (id, term, year, academic_year, study_year) VALUES ('4', 'Semester 1', NULL, 'None', 'None');
INSERT INTO terms (id, term, year, academic_year, study_year) VALUES ('7', 'Semester_2 2024', NULL, NULL, NULL);
-- Backup of table: users
CREATE TABLE IF NOT EXISTS users (
    `id` TEXT,
    `username` TEXT,
    `password` TEXT,
    `role` TEXT,
    `first_name` TEXT,
    `last_name` TEXT,
    `other_name` TEXT,
    `profile_image` TEXT,
    `a_internal_role` TEXT,
    `a_external_role` TEXT
);

INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('4', 'zasa', 'pbkdf2:sha256:600000$eLu3rJ3QRuAfdsVM$e53db89a5bf6ffc32534726d96d2b7ce8b7b36ac847e2e9def6a4b85ca3abc70', 'admin', 'Ssaazi', 'John', 'None', 'profilepc.jpg', NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('15', 'mine', 'scrypt:32768:8:1$3BynFx3PnimjYz6F$639a7da39ed1e4ddf8541fcad9b131c36f6d7444de9a37fce893f0ff31b8a97fa504667aa41b64129d691d319d9802c07842f16dd0aab5405aa84a8ac619f28e', 'School Practice Supervisor', 'Nakintu', 'Glosh', 'None', '480780559_122226799778034217_7301661802774207710_n.jpg', NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('16', 'werr', 'pbkdf2:sha256:600000$C1HRu9mMNAZOMDUX$c26fbefb4523eeff038d4c7281bea261b3d4d1bbe86f3bb29629b128750d1544', 'School Practice Supervisor', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('17', 'isaaya', 'scrypt:32768:8:1$WXjVaTpY25bFwk0S$f88f82d9a315e6952852da1dc54c84ff4f94dc684914bcfc23370653f119bfba914a39582340d87f7a047d709f63cf4fca97b14caa853492df00eb0250591287', 'Head of Department', 'Isiah', 'Walusimbi', 'Kimuli', '480780559_122226799778034217_7301661802774207710_n.jpg', NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('18', 'lulu', 'pbkdf2:sha256:600000$QRxeKxLvOLkfpdc1$50ef15c38c40393ec637718d2d989aeadf3fc8edbc1979104f31be07571db6f6', 'School Practice Supervisor', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('19', 'kaka', 'scrypt:32768:8:1$axiZ8haAYocRG7un$715b2f23e4fab8f41838d374d5a0a8ec424f91ab4bca2a0e07853b7585104f25f74afbd5303ad7a3231234f30cc7fee6ad1d65d065b5c635f1208c88eda1ad6d', 'School Practice Supervisor', 'mine', 'him', 'None', NULL, '1', NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('20', 'kuku', 'pbkdf2:sha256:600000$b4bcXoSF1Xd1qR2X$5aa5d4f4db65a74c2f6988a4224097d3ddd6463243d0ee5044f3b435914a2be0', 'Head of Department', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('21', 'richard', 'pbkdf2:sha256:600000$4eaFDUGwmT3uEpwD$f36bea0ce9e4ad8b365357c20a8f56ec5750c958e4ad8ac520a5f762366a228a', 'School Practice Supervisor', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('22', 'jon', 'scrypt:32768:8:1$5kHGXfDkoHtbByeV$dd9f87820dd29a56b30401af860da4e5bc5cdd57cc37205cd812b5ec33a0e76a89d4e036c06ddc2d72f1f58a5a7c2b025ab96173f18c41741fa7a0997a998478', 'School Practice Supervisor', 'rrrr', 'rrrr', 'None', NULL, '1', NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('23', 'tcy', 'pbkdf2:sha256:600000$bPtLha45hw473oP5$a0fd598c81ec0d6f747d9c6a0ac0b806b7c9227b550157a46e5237bd75a1c3f1', 'School Practice Supervisor', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('24', 'lil baker man ', 'pbkdf2:sha256:600000$wrOaVNpqs2AfQ56G$95f41bf5d796bae4fc74bf7bb3c07a7c27574941818cb7130f91612a904f3a67', 'School Practice Supervisor', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('25', 'jorv', 'scrypt:32768:8:1$NkxgXhXix7jAMNbg$5abc5d6b26d8fed16ae0ed3b26096062e9031f3ef77a6353407d8fde2f235636d1e9d81e2c8ff3dd2da06015b221a09c0f6f1ef5b0f5f6821534a9fd2f4e23f3', 'School Practice Supervisor', 'kigundu', 'Jorvan', 'None', '481075742_1030215035638192_6631936856548270382_n.jpg', NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('26', 'walusimbiisaaya', 'pbkdf2:sha256:600000$4PmnygCTkGVN3qWd$8d2149dc90b5147e4bf4ebaa1abcaedaf44f7249c616bc01209e5a85142a2d3e', 'School Practice Supervisor', '', '', NULL, NULL, NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('27', 'ejuu', 'pbkdf2:sha256:600000$3ozp54LeQivnYbZm$87a8542dc6aad5e8997ad4469d1a2a75ea7ad0f8deba535b4ca2e1f1d9d5cc1e', 'Head of Department', 'jj', 'jj', 'None', 'ejju1.jpg', NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('28', 'keno', 'pbkdf2:sha256:600000$MZxi2rzKC6HBOcKr$2a78242d244992f620e99daad76c45d4f0da787181cf3ee60db7ac5d1d153c6a', 'School Practice Supervisor', 'Lubega', 'Kennedy', 'Kyazze', 'uploads\gloria.png', NULL, NULL);
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('29', 'hope', 'scrypt:32768:8:1$gMrbJrREVpapeQMV$563299f06ba9a0232389d0d3dc742a6cc51bbf904dd96616f8bf3841fc5b53091eb831880fa385a9683ce293c6f44f421bf6e229f925ba8a1695b944718d02a1', 'School Practice Supervisor', 'hope', 'aine', '', '481075742_1030215035638192_6631936856548270382_n.jpg', '0', '1');
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('30', 'niga', 'scrypt:32768:8:1$vxOTe3zENCSAmIK2$2f10f5b4fa2f74c4bafcf286a4070834f00477dde3d3eb77d7c2d5c5923f520eab10543a121b3d97ca90f0cb98a4ad1ccd17c032aa30cd27420f23ce20e86654', 'School Practice Supervisor', 'Isiah', 'Walusimbi', '', NULL, NULL, '1');
INSERT INTO users (id, username, password, role, first_name, last_name, other_name, profile_image, a_internal_role, a_external_role) VALUES ('31', 'sans', 'scrypt:32768:8:1$mX8sbs1LBpLvlBB8$a900cfb2e309d3d42ed3b6d543e55f24904d34a147671bfd13ac05bd45da83cf763c45b885b0cb713e8fdad0cea685e502ef4c75577a00d2082faf7c41a64129', 'School Practice Supervisor', 'mine', 'minu', '', NULL, NULL, NULL);
