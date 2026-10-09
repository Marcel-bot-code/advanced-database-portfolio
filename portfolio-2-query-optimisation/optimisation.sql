-- =============================================================
--  OCNS – Portfolio 2: optimisation.sql
--  Before/after EXPLAIN for a search on a non-key column
-- =============================================================

-- STEP 0. Add 2,000 extra (fictional) students so the difference is visible.
-- Two small recursive counts (1..50 and 1..40) are multiplied to give 2,000
-- numbers (staying under the default 1,000-step recursion limit),
-- and a fictional student is built from each number.
INSERT INTO student (matric_no, first_name, last_name, level, programme_id)
WITH RECURSIVE a AS (SELECT 1 AS x UNION ALL SELECT x + 1 FROM a WHERE x < 50),
               b AS (SELECT 1 AS y UNION ALL SELECT y + 1 FROM b WHERE y < 40),
               n AS (SELECT (x - 1) * 40 + y AS i FROM a CROSS JOIN b)
SELECT CONCAT('OCNS/GEN/2026/', LPAD(i, 4, '0')),
       ELT(1 + i % 10, 'Ada','Bayo','Chika','Dayo','Efe','Femi','Gift','Hassan','Ini','Jide'),
       ELT(1 + (i * 7) % 25, 'Okafor','Adeyemi','Danjuma','Ekanem','Nwachukwu','Ibe','Lawal',
           'Okeke','Essien','Ogunleye','Asuquo','Eze','Umeh','Ojo','Inyang','Chukwu',
           'Abubakar','Ade','Onyema','Bassey','Etuk','Obong','Amadi','Wike','Ikpe'),
       ELT(1 + i % 3, 100, 200, 300),
       1 + i % 5
FROM n;

ANALYZE TABLE student;   -- refresh the optimiser's statistics

-- The query: the Registry searching for a student by surname
-- (last_name is NOT a key, so there is no index on it yet)

-- STEP 1. BEFORE
EXPLAIN SELECT * FROM student WHERE last_name = 'Etuk';

-- STEP 2. Add an index on the searched column
CREATE INDEX idx_student_last_name ON student(last_name);
ANALYZE TABLE student;

-- STEP 3. AFTER
EXPLAIN SELECT * FROM student WHERE last_name = 'Etuk';

-- Proof the answer is unchanged, only faster
SELECT COUNT(*) AS etuk_students FROM student WHERE last_name = 'Etuk';
