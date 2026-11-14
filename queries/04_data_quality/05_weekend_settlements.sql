-- Purpose: Settled transactions dated on a weekend: total count and amount, and the 5 largest.

SELECT COUNT(*)          AS cnt,
       SUM(ABS(amount))  AS total_amount
FROM transactions AS t
WHERE DAYOFWEEK(txn_date) IN (1, 7)
  AND status = 'settled';

SELECT *
FROM transactions AS t
WHERE DAYOFWEEK(txn_date) IN (1, 7)
  AND status = 'settled'
ORDER BY ABS(amount) DESC
LIMIT 5;
