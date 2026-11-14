-- Purpose: Each counterparty's country, verification status, and settled payments received.

SELECT c.name, c.country,
       CASE WHEN c.verified_date IS NULL THEN 'UNVERIFIED' ELSE 'verified' END AS cp_status,
       COUNT(t.txn_id) AS n_payments
FROM counterparties AS c
LEFT JOIN transactions AS t
       ON t.counterparty_id = c.cp_id
      AND t.amount < 0
      AND t.status = 'settled'
GROUP BY c.cp_id, c.name, c.country, cp_status
ORDER BY n_payments DESC;
