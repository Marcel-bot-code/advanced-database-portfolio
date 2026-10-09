-- =============================================================
--  OCNS – Portfolio 3: concurrency.sql
--  Two Bursary officers record a payment for the SAME student at
--  the same time. Run in TWO separate terminals (two connections).
--  Student 12 (Mercy Eze) has a balance of N281,500 before this demo.
-- =============================================================

-- ===== TERMINAL 1 (Bursary officer A) =====
START TRANSACTION;
SELECT student_id, balance FROM fee_account
WHERE student_id = 12 FOR UPDATE;                 -- locks Mercy's row

-- ===== TERMINAL 2 (Bursary officer B) =====
START TRANSACTION;
UPDATE fee_account SET balance = balance - 140750
WHERE student_id = 12;                            -- WAITS: row is locked by Terminal 1

-- ===== TERMINAL 1 =====
UPDATE fee_account SET balance = balance - 140750
WHERE student_id = 12;                            -- 2nd instalment
COMMIT;                                           -- releases the lock

-- ===== TERMINAL 2 =====
-- (its UPDATE now runs, using the NEW balance)
COMMIT;

-- ===== EITHER TERMINAL =====
SELECT student_id, balance FROM fee_account WHERE student_id = 12;
-- 281,500 - 140,750 - 140,750 = 0.00  -> both payments counted, nothing lost

-- While Terminal 2 is waiting, a 3rd connection can show the lock wait:
SELECT trx_id, trx_state, trx_started, trx_query
FROM information_schema.INNODB_TRX;

-- ---------- Isolation level ----------
SELECT @@transaction_isolation;   -- MySQL 8
SELECT @@tx_isolation;            -- MariaDB (same setting, older name)
