-- Purpose: Top 5 counterparties by settled payments received.

SELECT c.name          AS name,
       SUM(t.amount)   AS total
FROM transactions AS t
INNER JOIN counterparties AS c ON t.counterparty_id = c.cp_id
WHERE t.status = 'settled'
  AND t.amount < 0
GROUP BY name
ORDER BY total ASC
LIMIT 5;
