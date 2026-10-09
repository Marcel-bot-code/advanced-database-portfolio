# Advanced Database Systems Portfolio – MIT 8103

## Case Study: Oasis College of Nursing Sciences

Oasis College of Nursing Sciences (OCNS) is a private nursing college that trains students in its Basic Nursing and ND Nursing programmes and prepares them for clinical practice and professional licensing. The system is the college's Student Records and Academic Management System (OasisSRMS), a central database that supports admissions, course registration, examinations, results, fees and clinical postings; the college needs a database because hundreds of linked student, course and payment records must be stored once, kept accurate, shared by several offices at the same time and protected from loss or unauthorised changes. Its users are students, lecturers, clinical supervisors, Registry/admissions officers, the Bursary, Heads of Department, the Provost and the IT administrator who manages accounts and backups. It stores records of students, programmes, departments, courses, lecturers, sessions and semesters, course registrations, CBT exams and scores, fee invoices and payments, hostel allocations and clinical posting log entries. With this data, students register for their courses each semester, lecturers enter continuous assessment and exam scores, the Registry computes GPAs and publishes results and transcripts, the Bursary records fee payments and tracks outstanding balances, and staff schedule CBT and resit exams and review each student's clinical posting log.

## What is in each folder

| Folder | Portfolio | Contents |
|---|---|---|
| [portfolio-1-database-design](portfolio-1-database-design) | 1 – Database Design | `notes.md` (tables, relationships, 1NF–3NF), `ocns-erd.png` + `ocns.dbml` (ER diagram), `create_tables.sql`, `insert_data.sql`, `test_constraints.sql` |
| [portfolio-2-query-optimisation](portfolio-2-query-optimisation) | 2 – Query Optimisation | `queries.sql` (8 queries: filter, JOIN, GROUP BY, subquery, VIEW, HAVING, LEFT JOIN), `optimisation.sql` (EXPLAIN + index), 10 screenshots, `notes.md` (analysis) |
| [portfolio-3-transactions-concurrency](portfolio-3-transactions-concurrency) | 3 – Transactions & Concurrency | `setup_fee_account.sql`, `transactions.sql` (COMMIT / ROLLBACK), `concurrency.sql` (row locking), 7 screenshots, `notes.md` (ACID, lost update, isolation levels) |
| [portfolio-4-nosql](portfolio-4-nosql) | 4 – NoSQL (MongoDB) | `mongo_commands.js` (insert, find, aggregate, $lookup, index), Atlas screenshots, `notes.md` (embed vs reference, SQL vs MongoDB, NoSQL types) |
| [portfolio-5-distributed-cloud](portfolio-5-distributed-cloud) | 5 – Distributed & Cloud | `replication_commands.js`, Atlas replica-set screenshots, `notes.md` (replication, sharding, CAP, cloud vs on-premise) |

All people in the sample data are fictional.

## How to run
1. Portfolio 1: run `create_tables.sql`, then `insert_data.sql` in MySQL 8 / MariaDB (phpMyAdmin SQL tab).
2. Portfolio 2: run `queries.sql`, then `optimisation.sql`.
3. Portfolio 3: run `setup_fee_account.sql`, then `transactions.sql`; `concurrency.sql` needs two terminal connections.
4. Portfolios 4–5: paste the `.js` files into mongosh connected to MongoDB Atlas.
