-- =============================================================
--  OCNS – Portfolio 3: transactions.sql
--  Run setup_fee_account.sql first (creates fee_account).
-- =============================================================

-- ---------- DEMO 1: COMMIT (success) ----------
-- Mercy Eze (student 12) pays the 1st instalment of N281,500 by Paystack.
SELECT student_id, balance FROM fee_account WHERE student_id = 12;      -- before

START TRANSACTION;
  INSERT INTO payment (student_id, amount, payment_date, paystack_ref, session)
  VALUES (12, 281500, '2026-10-10', 'OCNSDEMO-TXN-0001', '2025/2026');
  UPDATE fee_account SET balance = balance - 281500 WHERE student_id = 12;
COMMIT;

SELECT student_id, balance FROM fee_account WHERE student_id = 12;      -- after: reduced
SELECT payment_id, student_id, amount, paystack_ref FROM payment
WHERE paystack_ref = 'OCNSDEMO-TXN-0001';                               -- after: saved

-- ---------- DEMO 2: ROLLBACK (cancelled by the Bursary) ----------
-- Precious Inyang (student 15) starts a N100,000 payment, but the bank
-- reverses it, so the Bursary cancels the whole transaction.
SELECT student_id, balance FROM fee_account WHERE student_id = 15;      -- before

START TRANSACTION;
  INSERT INTO payment (student_id, amount, payment_date, paystack_ref, session)
  VALUES (15, 100000, '2026-10-10', 'OCNSDEMO-TXN-0002', '2025/2026');
  UPDATE fee_account SET balance = balance - 100000 WHERE student_id = 15;
  SELECT student_id, balance FROM fee_account WHERE student_id = 15;    -- inside: looks reduced
ROLLBACK;

SELECT student_id, balance FROM fee_account WHERE student_id = 15;      -- after: unchanged
SELECT COUNT(*) AS rows_kept FROM payment
WHERE paystack_ref = 'OCNSDEMO-TXN-0002';                               -- after: 0

-- ---------- DEMO 3: a REAL error half-way through ----------
-- The balance is reduced first, then the payment insert FAILS because the
-- Paystack reference was already used (UNIQUE constraint). ROLLBACK undoes
-- the balance change, so the student is never charged for a payment that
-- was not recorded.
START TRANSACTION;
  UPDATE fee_account SET balance = balance - 50000 WHERE student_id = 15;
  INSERT INTO payment (student_id, amount, payment_date, paystack_ref, session)
  VALUES (15, 50000, '2026-10-10', 'OCNSDEMO-TXN-0001', '2025/2026');  -- duplicate ref -> ERROR 1062
ROLLBACK;

SELECT student_id, balance FROM fee_account WHERE student_id = 15;      -- still unchanged
