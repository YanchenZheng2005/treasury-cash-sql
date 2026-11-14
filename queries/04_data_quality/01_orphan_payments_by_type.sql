-- Purpose: Payments with no counterparty (outflows, not failed), counted and summed by transaction type.

SELECT t.txn_type,
       COUNT(*)      AS number,
       SUM(t.amount) AS total,
       AVG(t.amount) AS average
FROM transactions AS t
LEFT JOIN counterparties AS c
    ON t.counterparty_id = c.cp_id
WHERE (t.status != 'failed' OR t.status IS NULL)
  AND t.amount < 0
  AND c.cp_id IS NULL
GROUP BY t.txn_type;
