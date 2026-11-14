-- Purpose: Pending transactions grouped by age (0-7, 8-30, 30+ days as of 2026-09-30), with count and absolute amount.

SELECT CASE
           WHEN DATEDIFF('2026-09-30', t.txn_date) <= 7  THEN '0-7 days'
           WHEN DATEDIFF('2026-09-30', t.txn_date) <= 30 THEN '8-30 days'
           ELSE 'more than 30 days'
       END AS pending_date,
       COUNT(*)              AS cnt,
       SUM(ABS(t.amount))    AS total_absolute_value
FROM transactions AS t
WHERE t.status = 'pending'
GROUP BY pending_date;
