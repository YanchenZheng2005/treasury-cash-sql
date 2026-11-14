-- Purpose: Settled transaction count and net amount per bank.

SELECT b.bank_name   AS bank,
       COUNT(*)      AS total,
       SUM(amount)   AS net_amount
FROM transactions AS t
INNER JOIN bank_accounts AS b ON t.account_id = b.account_id
WHERE t.status = 'settled'
GROUP BY b.bank_name
ORDER BY total DESC;
