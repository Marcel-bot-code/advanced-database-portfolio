-- =============================================================
--  OCNS – Portfolio 2: queries.sql
--  MIT 8103 Advanced Database Systems
--  Run on the ocns_portfolio database from Portfolio 1.
-- =============================================================

-- Q1. SIMPLE FILTER
-- "Which students are in 100 level?" (for the new-intake orientation list)
SELECT matric_no, first_name, last_name
FROM student
WHERE level = 100
ORDER BY last_name, first_name;

-- Q2. JOIN (3 tables)
-- "Which students are registered for NUR101 Anatomy and Physiology I this session?"
SELECT s.matric_no, s.first_name, s.last_name, r.session
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course  c ON r.course_id  = c.course_id
WHERE c.course_code = 'NUR101' AND r.session = '2025/2026'
ORDER BY s.last_name;

-- Q3. GROUP BY
-- "What is the average total score (CA + exam) per course, and how many sat it?"
SELECT c.course_code, c.course_title,
       COUNT(*)                                   AS students,
       ROUND(AVG(r.ca_score + r.exam_score), 1)   AS avg_total
FROM registration r
JOIN course c ON r.course_id = c.course_id
GROUP BY c.course_id, c.course_code, c.course_title
ORDER BY avg_total DESC;

-- Q4. SUBQUERY
-- "Who scored above the class average in their course?"
SELECT c.course_code, s.first_name, s.last_name,
       (r.ca_score + r.exam_score) AS total
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course  c ON r.course_id  = c.course_id
WHERE (r.ca_score + r.exam_score) >
      (SELECT AVG(r2.ca_score + r2.exam_score)
       FROM registration r2
       WHERE r2.course_id = r.course_id)          -- correlated: same course
ORDER BY c.course_code, total DESC;

-- Q5. VIEW
-- Save the results sheet the Registry prints every semester as a virtual table
CREATE OR REPLACE VIEW student_results AS
SELECT s.matric_no,
       CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       p.programme_name,
       c.course_code,
       r.session,
       r.ca_score, r.exam_score,
       (r.ca_score + r.exam_score) AS total,
       CASE
         WHEN r.ca_score + r.exam_score >= 70 THEN 'A'
         WHEN r.ca_score + r.exam_score >= 60 THEN 'B'
         WHEN r.ca_score + r.exam_score >= 50 THEN 'C'
         WHEN r.ca_score + r.exam_score >= 45 THEN 'D'
         ELSE 'F'
       END AS grade
FROM registration r
JOIN student   s ON r.student_id   = s.student_id
JOIN programme p ON s.programme_id = p.programme_id
JOIN course    c ON r.course_id    = c.course_id;

-- Q6. USING THE VIEW
-- "Which students failed a course and need a resit?" (feeds the resit exam list)
SELECT matric_no, student_name, course_code, total, grade
FROM student_results
WHERE grade = 'F'
ORDER BY course_code, student_name;

-- Q7. GROUP BY + HAVING
-- "How much has the Bursary collected per programme, where it is over N500,000?"
SELECT p.programme_name,
       COUNT(DISTINCT pay.student_id) AS paying_students,
       SUM(pay.amount)                AS total_collected
FROM payment pay
JOIN student   s ON pay.student_id = s.student_id
JOIN programme p ON s.programme_id = p.programme_id
WHERE pay.session = '2025/2026'
GROUP BY p.programme_name
HAVING SUM(pay.amount) > 500000
ORDER BY total_collected DESC;

-- Q8. LEFT JOIN (finding what is missing)
-- "Which students have made NO payment this session?" (Bursary follow-up list)
SELECT s.matric_no, s.first_name, s.last_name, s.level
FROM student s
LEFT JOIN payment pay
       ON pay.student_id = s.student_id AND pay.session = '2025/2026'
WHERE pay.payment_id IS NULL
ORDER BY s.last_name;
