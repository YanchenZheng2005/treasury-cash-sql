-- Purpose: Settled inflow and outflow counts per bank.

SELECT b.bank_name AS bank,
       COUNT(*)    AS total,
       CASE WHEN t.amount > 0 THEN 'inflow'
            WHEN t.amount < 0 THEN 'outflow'
       END         AS direction
FROM transactions AS t
INNER JOIN bank_accounts AS b ON t.account_id = b.account_id
WHERE t.status = 'settled'
GROUP BY b.bank_name, direction;
