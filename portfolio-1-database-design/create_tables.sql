-- =============================================================
--  OCNS Student Records & Academic Management System (OasisSRMS)
--  MIT 8103 Advanced Database Systems – Portfolio 1
--  create_tables.sql  (MySQL / MariaDB, InnoDB)
-- =============================================================

-- Allows the script to be re-run from scratch
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS clinical_posting, payment, registration, course,
                     student, lecturer, programme, department;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. DEPARTMENT ("one" side of programme and lecturer)
CREATE TABLE department (
  department_id   INT PRIMARY KEY AUTO_INCREMENT,
  dept_name       VARCHAR(100) NOT NULL UNIQUE,
  hod_lecturer_id INT NULL UNIQUE,          -- FK added after LECTURER exists (see below)
  office_phone    VARCHAR(20)
) ENGINE=InnoDB;

-- 2. PROGRAMME
CREATE TABLE programme (
  programme_id   INT PRIMARY KEY AUTO_INCREMENT,
  programme_name VARCHAR(100) NOT NULL UNIQUE,
  duration_years INT NOT NULL CHECK (duration_years BETWEEN 1 AND 6),
  department_id  INT NOT NULL,
  FOREIGN KEY (department_id) REFERENCES department(department_id)
) ENGINE=InnoDB;

-- 3. LECTURER
CREATE TABLE lecturer (
  lecturer_id   INT PRIMARY KEY AUTO_INCREMENT,
  staff_no      VARCHAR(20)  NOT NULL UNIQUE,
  first_name    VARCHAR(50)  NOT NULL,
  last_name     VARCHAR(50)  NOT NULL,
  email         VARCHAR(100) NOT NULL UNIQUE,
  department_id INT NOT NULL,
  FOREIGN KEY (department_id) REFERENCES department(department_id)
) ENGINE=InnoDB;

-- DEPARTMENT and LECTURER point at each other, so the HOD link is added last
ALTER TABLE department
  ADD CONSTRAINT fk_department_hod
  FOREIGN KEY (hod_lecturer_id) REFERENCES lecturer(lecturer_id);

-- 4. STUDENT
CREATE TABLE student (
  student_id   INT PRIMARY KEY AUTO_INCREMENT,
  matric_no    VARCHAR(30) NOT NULL UNIQUE,
  first_name   VARCHAR(50) NOT NULL,
  last_name    VARCHAR(50) NOT NULL,
  level        INT NOT NULL CHECK (level IN (100, 200, 300)),
  programme_id INT NOT NULL,
  FOREIGN KEY (programme_id) REFERENCES programme(programme_id)
) ENGINE=InnoDB;

-- 5. COURSE
CREATE TABLE course (
  course_id    INT PRIMARY KEY AUTO_INCREMENT,
  course_code  VARCHAR(15)  NOT NULL UNIQUE,
  course_title VARCHAR(150) NOT NULL,
  credit_units INT NOT NULL CHECK (credit_units BETWEEN 1 AND 6),
  semester     VARCHAR(10)  NOT NULL CHECK (semester IN ('First', 'Second')),
  lecturer_id  INT,
  FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id)
) ENGINE=InnoDB;

-- 6. REGISTRATION (in-between table: many students take many courses)
CREATE TABLE registration (
  registration_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id      INT NOT NULL,
  course_id       INT NOT NULL,
  session         VARCHAR(9) NOT NULL,                       -- e.g. 2025/2026
  ca_score        DECIMAL(5,2) CHECK (ca_score   BETWEEN 0 AND 40),
  exam_score      DECIMAL(5,2) CHECK (exam_score BETWEEN 0 AND 60),
  UNIQUE (student_id, course_id, session),                   -- no double registration
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  FOREIGN KEY (course_id)  REFERENCES course(course_id)
) ENGINE=InnoDB;

-- 7. PAYMENT
CREATE TABLE payment (
  payment_id   INT PRIMARY KEY AUTO_INCREMENT,
  student_id   INT NOT NULL,
  amount       DECIMAL(12,2) NOT NULL CHECK (amount > 0),
  payment_date DATE NOT NULL,
  paystack_ref VARCHAR(50) NOT NULL UNIQUE,                  -- one reference, one payment
  session      VARCHAR(9) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student(student_id)
) ENGINE=InnoDB;

-- 8. CLINICAL_POSTING
CREATE TABLE clinical_posting (
  posting_id      INT PRIMARY KEY AUTO_INCREMENT,
  student_id      INT NOT NULL,
  hospital_name   VARCHAR(150) NOT NULL,
  ward            VARCHAR(50)  NOT NULL,
  start_date      DATE NOT NULL,
  supervisor_name VARCHAR(100),
  FOREIGN KEY (student_id) REFERENCES student(student_id)
) ENGINE=InnoDB;
