# Portfolio 1 – Database Design (OCNS)

## Step 3: Tables

### 1. DEPARTMENT

| Column | Key |
|---|---|
| department_id | PK |
| dept_name | |
| hod_name | |
| office_phone | |

### 2. PROGRAMME

| Column | Key |
|---|---|
| programme_id | PK |
| programme_name | |
| duration_years | |
| department_id | FK → DEPARTMENT |

### 3. STUDENT

| Column | Key |
|---|---|
| student_id | PK |
| matric_no | |
| first_name | |
| last_name | |
| level | |
| programme_id | FK → PROGRAMME |

### 4. LECTURER

| Column | Key |
|---|---|
| lecturer_id | PK |
| staff_no | |
| first_name | |
| last_name | |
| email | |
| department_id | FK → DEPARTMENT |

### 5. COURSE

| Column | Key |
|---|---|
| course_id | PK |
| course_code | |
| course_title | |
| credit_units | |
| semester | |
| lecturer_id | FK → LECTURER |

### 6. REGISTRATION (in-between table for STUDENT and COURSE)

| Column | Key |
|---|---|
| registration_id | PK |
| student_id | FK → STUDENT |
| course_id | FK → COURSE |
| session | |
| ca_score | |
| exam_score | |

### 7. PAYMENT

| Column | Key |
|---|---|
| payment_id | PK |
| student_id | FK → STUDENT |
| amount | |
| payment_date | |
| paystack_ref | |
| session | |

### 8. CLINICAL_POSTING

| Column | Key |
|---|---|
| posting_id | PK |
| student_id | FK → STUDENT |
| hospital_name | |
| ward | |
| start_date | |
| supervisor_name | |

## How the tables connect

| Relationship | Type | FK goes in |
|---|---|---|
| One DEPARTMENT has many PROGRAMMES | 1 : M | PROGRAMME.department_id |
| One DEPARTMENT has many LECTURERS | 1 : M | LECTURER.department_id |
| One PROGRAMME has many STUDENTS | 1 : M | STUDENT.programme_id |
| One LECTURER teaches many COURSES | 1 : M | COURSE.lecturer_id |
| Many STUDENTS take many COURSES (resolved by REGISTRATION) | M : N | REGISTRATION.student_id + REGISTRATION.course_id |
| One STUDENT makes many PAYMENTS | 1 : M | PAYMENT.student_id |
| One STUDENT has many CLINICAL_POSTINGS | 1 : M | CLINICAL_POSTING.student_id |
