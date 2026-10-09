-- Portfolio 3 extension: each student's running fee balance for the session.
-- A fee payment must change TWO places: add a PAYMENT row AND reduce the balance.
CREATE TABLE IF NOT EXISTS fee_account (
  student_id  INT PRIMARY KEY,
  session     VARCHAR(9)    NOT NULL,
  total_fee   DECIMAL(12,2) NOT NULL,
  balance     DECIMAL(12,2) NOT NULL CHECK (balance >= 0),   -- can never go negative
  FOREIGN KEY (student_id) REFERENCES student(student_id)
) ENGINE=InnoDB;

-- Opening balances = fee for the session minus what each student has already paid
INSERT INTO fee_account (student_id, session, total_fee, balance)
SELECT s.student_id, '2025/2026', 563000,
       563000 - COALESCE((SELECT SUM(amount) FROM payment p
                          WHERE p.student_id = s.student_id AND p.session = '2025/2026'), 0)
FROM student s;
