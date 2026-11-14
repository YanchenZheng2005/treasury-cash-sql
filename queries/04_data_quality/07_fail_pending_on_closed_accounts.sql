-- Purpose: Mark pending transactions on closed accounts 109 and 115 as failed inside a transaction (expect 11 affected rows), then roll back.

START TRANSACTION;

UPDATE transactions
SET status = 'failed'
WHERE account_id IN (109, 115)
  AND status = 'pending';

ROLLBACK;
