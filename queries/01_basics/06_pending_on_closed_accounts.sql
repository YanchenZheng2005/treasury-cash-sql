-- Purpose: Pending transactions on closed accounts.

SELECT b.account_id      AS id,
       COUNT(t.txn_id)   AS total
FROM bank_accounts AS b
INNER JOIN transactions AS t ON t.account_id = b.account_id
WHERE b.status = 'closed'
  AND t.status = 'pending'
GROUP BY id;
