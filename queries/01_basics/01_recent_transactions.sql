-- Purpose: All transactions since 2026-09-01 with date, amount, bank, and total row count.

SELECT t.txn_date  AS date,
       t.amount    AS amount,
       b.bank_name AS bank,
       (SELECT COUNT(*)
          FROM transactions AS t
         INNER JOIN bank_accounts AS b ON t.account_id = b.account_id
         WHERE t.txn_date >= '2026-09-01') AS total
FROM transactions AS t
INNER JOIN bank_accounts AS b ON t.account_id = b.account_id
WHERE t.txn_date >= '2026-09-01';
