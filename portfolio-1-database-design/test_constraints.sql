-- Each statement below SHOULD FAIL. The error proves the constraint works.
-- 1. UNIQUE: duplicate matric number
INSERT INTO student (matric_no, first_name, last_name, level, programme_id)
VALUES ('OCNS/BN/2025/001', 'Test', 'Duplicate', 100, 1);
-- 2. CHECK: exam score of 150 (allowed 0-60)
INSERT INTO registration (student_id, course_id, session, ca_score, exam_score)
VALUES (1, 4, '2026/2027', 30, 150);
-- 3. FOREIGN KEY: student in a programme that does not exist
INSERT INTO student (matric_no, first_name, last_name, level, programme_id)
VALUES ('OCNS/XX/2025/999', 'Ghost', 'Student', 100, 99);
-- 4. UNIQUE (student_id, course_id, session): registering the same course twice
INSERT INTO registration (student_id, course_id, session, ca_score, exam_score)
SELECT student_id, course_id, session, 20, 40 FROM registration WHERE registration_id = 1;
-- 5. NOT NULL: payment with no date
INSERT INTO payment (student_id, amount, payment_date, paystack_ref, session)
VALUES (1, 5000, NULL, 'OCNSDEMO-TEST', '2025/2026');
-- 6. CHECK: level 500 (allowed 100, 200, 300)
INSERT INTO student (matric_no, first_name, last_name, level, programme_id)
VALUES ('OCNS/BN/2025/500', 'Wrong', 'Level', 500, 1);
