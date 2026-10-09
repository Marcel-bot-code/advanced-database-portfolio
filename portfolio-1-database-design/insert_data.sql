-- =============================================================
--  OCNS sample data – insert_data.sql
--  All people below are FICTIONAL (made up for the portfolio)
--  Run create_tables.sql first.
-- =============================================================

-- 1. Departments (HOD filled in after lecturers exist)
INSERT INTO department (dept_name, office_phone) VALUES
  ('General Nursing',         '0803 100 2001'),
  ('Midwifery',               '0803 100 2002'),
  ('Basic Medical Sciences',  '0803 100 2003'),
  ('General Studies',         '0803 100 2004');

-- 2. Programmes
INSERT INTO programme (programme_name, duration_years, department_id) VALUES
  ('Basic Nursing',                    3, 1),
  ('ND Nursing',                       2, 1),
  ('Post-Basic Midwifery',             2, 2),
  ('Community Health Nursing',         3, 1),
  ('Pre-Nursing Science Foundation',   1, 3);

-- 3. Lecturers
INSERT INTO lecturer (staff_no, first_name, last_name, email, department_id) VALUES
  ('OCNS/STF/001', 'Adaeze', 'Okonkwo', 'adaeze.okonkwo@ocns-demo.edu', 1),
  ('OCNS/STF/002', 'Tunde', 'Bakare', 'tunde.bakare@ocns-demo.edu', 1),
  ('OCNS/STF/003', 'Ngozi', 'Eze', 'ngozi.eze@ocns-demo.edu', 2),
  ('OCNS/STF/004', 'Ibrahim', 'Musa', 'ibrahim.musa@ocns-demo.edu', 3),
  ('OCNS/STF/005', 'Ifeoma', 'Nwosu', 'ifeoma.nwosu@ocns-demo.edu', 1),
  ('OCNS/STF/006', 'Emeka', 'Obi', 'emeka.obi@ocns-demo.edu', 3),
  ('OCNS/STF/007', 'Blessing', 'Udo', 'blessing.udo@ocns-demo.edu', 2),
  ('OCNS/STF/008', 'Samuel', 'Etim', 'samuel.etim@ocns-demo.edu', 4),
  ('OCNS/STF/009', 'Chioma', 'Agu', 'chioma.agu@ocns-demo.edu', 1),
  ('OCNS/STF/010', 'Yusuf', 'Bello', 'yusuf.bello@ocns-demo.edu', 3),
  ('OCNS/STF/011', 'Grace', 'Akpan', 'grace.akpan@ocns-demo.edu', 4),
  ('OCNS/STF/012', 'Kelechi', 'Iwu', 'kelechi.iwu@ocns-demo.edu', 2);

-- Heads of Department (the 3NF fix: HOD is a lecturer, stored by ID)
UPDATE department SET hod_lecturer_id = 1  WHERE department_id = 1;
UPDATE department SET hod_lecturer_id = 3  WHERE department_id = 2;
UPDATE department SET hod_lecturer_id = 4  WHERE department_id = 3;
UPDATE department SET hod_lecturer_id = 8  WHERE department_id = 4;

-- 4. Students (20)
INSERT INTO student (matric_no, first_name, last_name, level, programme_id) VALUES
  ('OCNS/BN/2025/001', 'Amaka', 'Okafor', 100, 1),
  ('OCNS/BN/2025/002', 'Chinedu', 'Adeyemi', 200, 1),
  ('OCNS/BN/2025/003', 'Fatima', 'Danjuma', 300, 1),
  ('OCNS/BN/2025/004', 'Oluwaseun', 'Ekanem', 100, 1),
  ('OCNS/BN/2025/005', 'Ebere', 'Nwachukwu', 200, 1),
  ('OCNS/BN/2025/006', 'Godwin', 'Ibe', 300, 1),
  ('OCNS/BN/2025/007', 'Hauwa', 'Lawal', 100, 1),
  ('OCNS/ND/2025/008', 'Ikenna', 'Okeke', 100, 2),
  ('OCNS/ND/2025/009', 'Joy', 'Essien', 200, 2),
  ('OCNS/ND/2025/010', 'Kemi', 'Ogunleye', 100, 2),
  ('OCNS/ND/2025/011', 'Lucky', 'Asuquo', 200, 2),
  ('OCNS/ND/2025/012', 'Mercy', 'Eze', 100, 2),
  ('OCNS/MW/2025/013', 'Nnamdi', 'Umeh', 100, 3),
  ('OCNS/MW/2025/014', 'Oge', 'Ojo', 200, 3),
  ('OCNS/MW/2025/015', 'Precious', 'Inyang', 100, 3),
  ('OCNS/CH/2025/016', 'Rita', 'Chukwu', 100, 4),
  ('OCNS/CH/2025/017', 'Sani', 'Abubakar', 200, 4),
  ('OCNS/CH/2025/018', 'Tobi', 'Ade', 300, 4),
  ('OCNS/PN/2025/019', 'Uche', 'Onyema', 100, 5),
  ('OCNS/PN/2025/020', 'Victoria', 'Bassey', 100, 5);

-- 5. Courses (12)
INSERT INTO course (course_code, course_title, credit_units, semester, lecturer_id) VALUES
  ('NUR101', 'Anatomy and Physiology I', 3, 'First', 4),
  ('NUR102', 'Fundamentals of Nursing I', 3, 'First', 1),
  ('NUR103', 'Introduction to Microbiology', 2, 'First', 6),
  ('GST101', 'Use of English', 2, 'First', 8),
  ('NUR104', 'Medical-Surgical Nursing I', 3, 'Second', 2),
  ('NUR105', 'Pharmacology for Nurses', 3, 'Second', 10),
  ('NUR106', 'Community Health Nursing I', 2, 'Second', 9),
  ('MID101', 'Foundations of Midwifery', 3, 'First', 3),
  ('MID102', 'Antenatal Care', 3, 'Second', 7),
  ('GST102', 'Computer Applications', 2, 'Second', 11),
  ('NUR201', 'Mental Health Nursing', 3, 'First', 5),
  ('MID103', 'Neonatal Care', 2, 'Second', 12);

-- 6. Course registrations with scores (50 rows)
INSERT INTO registration (student_id, course_id, session, ca_score, exam_score) VALUES
  (1, 10, '2025/2026', 30.70, 45.50),
  (1, 11, '2025/2026', 28.30, 33.00),
  (1, 5, '2025/2026', 37.60, 26.90),
  (2, 6, '2025/2026', 37.20, 29.90),
  (2, 7, '2025/2026', 22.10, 54.30),
  (3, 11, '2025/2026', 32.50, 47.20),
  (3, 10, '2025/2026', 33.00, 46.50),
  (3, 3, '2025/2026', 23.20, 34.10),
  (4, 11, '2025/2026', 24.20, 38.20),
  (4, 7, '2025/2026', 30.60, 38.70),
  (5, 7, '2025/2026', 19.30, 47.20),
  (5, 3, '2025/2026', 30.70, 36.70),
  (5, 11, '2025/2026', 32.60, 50.00),
  (6, 3, '2025/2026', 31.00, 46.50),
  (6, 6, '2025/2026', 33.70, 47.80),
  (7, 6, '2025/2026', 35.00, 57.30),
  (7, 11, '2025/2026', 19.00, 30.40),
  (7, 4, '2025/2026', 35.00, 47.00),
  (8, 3, '2025/2026', 19.80, 52.30),
  (8, 5, '2025/2026', 34.20, 39.10),
  (9, 11, '2025/2026', 26.30, 38.50),
  (9, 10, '2025/2026', 32.40, 38.20),
  (9, 7, '2025/2026', 21.30, 49.40),
  (10, 4, '2025/2026', 21.70, 32.90),
  (10, 10, '2025/2026', 28.00, 34.60),
  (11, 1, '2025/2026', 35.70, 56.60),
  (11, 6, '2025/2026', 22.10, 44.60),
  (11, 2, '2025/2026', 28.90, 30.70),
  (12, 3, '2025/2026', 34.50, 47.80),
  (12, 1, '2025/2026', 30.80, 37.30),
  (13, 8, '2025/2026', 26.30, 27.00),
  (13, 10, '2025/2026', 34.00, 26.90),
  (13, 9, '2025/2026', 26.10, 55.90),
  (14, 4, '2025/2026', 38.60, 34.60),
  (14, 12, '2025/2026', 32.40, 39.70),
  (15, 12, '2025/2026', 33.80, 44.00),
  (15, 8, '2025/2026', 20.80, 32.20),
  (15, 10, '2025/2026', 28.30, 31.70),
  (16, 1, '2025/2026', 19.80, 41.70),
  (16, 3, '2025/2026', 28.20, 38.40),
  (17, 2, '2025/2026', 27.50, 35.20),
  (17, 1, '2025/2026', 31.30, 45.00),
  (17, 7, '2025/2026', 31.00, 27.60),
  (18, 1, '2025/2026', 26.00, 37.90),
  (18, 6, '2025/2026', 24.50, 26.90),
  (19, 10, '2025/2026', 23.00, 46.90),
  (19, 1, '2025/2026', 38.60, 49.20),
  (19, 3, '2025/2026', 35.30, 39.50),
  (20, 3, '2025/2026', 37.30, 32.00),
  (20, 10, '2025/2026', 30.90, 36.40);

-- 7. Fee payments (20)
INSERT INTO payment (student_id, amount, payment_date, paystack_ref, session) VALUES
  (8, 10000.00, '2025-10-06', 'OCNSDEMO-100037', '2025/2026'),
  (15, 246500.00, '2026-03-16', 'OCNSDEMO-100074', '2025/2026'),
  (2, 10000.00, '2026-03-16', 'OCNSDEMO-100111', '2025/2026'),
  (9, 123250.00, '2026-04-20', 'OCNSDEMO-100148', '2025/2026'),
  (16, 281500.00, '2025-11-03', 'OCNSDEMO-100185', '2025/2026'),
  (3, 281500.00, '2026-01-19', 'OCNSDEMO-100222', '2025/2026'),
  (10, 10000.00, '2026-01-19', 'OCNSDEMO-100259', '2025/2026'),
  (17, 246500.00, '2026-05-11', 'OCNSDEMO-100296', '2025/2026'),
  (4, 246500.00, '2025-11-03', 'OCNSDEMO-100333', '2025/2026'),
  (11, 10000.00, '2025-10-06', 'OCNSDEMO-100370', '2025/2026'),
  (18, 12000.00, '2025-10-13', 'OCNSDEMO-100407', '2025/2026'),
  (5, 10000.00, '2025-10-06', 'OCNSDEMO-100444', '2025/2026'),
  (12, 246500.00, '2025-10-06', 'OCNSDEMO-100481', '2025/2026'),
  (19, 12000.00, '2026-01-19', 'OCNSDEMO-100518', '2025/2026'),
  (6, 10000.00, '2026-05-11', 'OCNSDEMO-100555', '2025/2026'),
  (13, 12000.00, '2025-11-03', 'OCNSDEMO-100592', '2025/2026'),
  (20, 10000.00, '2026-01-19', 'OCNSDEMO-100629', '2025/2026'),
  (7, 246500.00, '2026-04-20', 'OCNSDEMO-100666', '2025/2026'),
  (14, 10000.00, '2026-03-16', 'OCNSDEMO-100703', '2025/2026'),
  (1, 140750.00, '2026-01-19', 'OCNSDEMO-100740', '2025/2026');

-- 8. Clinical postings (15)
INSERT INTO clinical_posting (student_id, hospital_name, ward, start_date, supervisor_name) VALUES
  (2, 'Riverside General Hospital', 'Accident & Emergency', '2026-06-01', 'Matron E. Ikwuagwu'),
  (3, 'Riverside General Hospital', 'Paediatrics', '2026-02-02', 'Matron E. Ikwuagwu'),
  (5, 'Riverside General Hospital', 'Antenatal Clinic', '2026-02-02', 'Matron E. Ikwuagwu'),
  (6, 'Oasis Community Health Centre', 'Labour Ward', '2026-06-01', 'Mrs. B. Daniel'),
  (9, 'Riverside General Hospital', 'Antenatal Clinic', '2026-05-04', 'Matron E. Ikwuagwu'),
  (11, 'Riverside General Hospital', 'Paediatrics', '2026-05-04', 'Matron F. Amadi'),
  (13, 'Oasis Community Health Centre', 'Labour Ward', '2026-05-04', 'Matron E. Ikwuagwu'),
  (14, 'Garden City Teaching Hospital', 'Paediatrics', '2026-03-02', 'Matron F. Amadi'),
  (16, 'Oasis Community Health Centre', 'Accident & Emergency', '2026-05-04', 'Matron E. Ikwuagwu'),
  (17, 'Riverside General Hospital', 'Male Surgical', '2026-03-02', 'Mrs. B. Daniel'),
  (18, 'Oasis Community Health Centre', 'Antenatal Clinic', '2026-05-04', 'Mr. O. Jumbo'),
  (1, 'Riverside General Hospital', 'Antenatal Clinic', '2026-02-02', 'Mrs. B. Daniel'),
  (4, 'Riverside General Hospital', 'Paediatrics', '2026-05-04', 'Mrs. B. Daniel'),
  (10, 'Riverside General Hospital', 'Paediatrics', '2026-03-02', 'Mrs. B. Daniel'),
  (15, 'Oasis Community Health Centre', 'Female Medical', '2026-05-04', 'Matron F. Amadi');
