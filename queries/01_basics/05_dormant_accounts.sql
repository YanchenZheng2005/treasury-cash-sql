-- Purpose: Bank accounts with no transactions since 2026-07-01.

SELECT b.account_id          AS id,
       COUNT(t.account_id)   AS total
FROM bank_accounts AS b
LEFT JOIN transactions AS t
       ON t.account_id = b.account_id
      AND t.txn_date >= '2026-07-01'
GROUP BY id
HAVING total = 0;
