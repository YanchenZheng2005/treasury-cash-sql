-- Purpose: Payments to unverified counterparties by portfolio (excluding failed).

SELECT p.name          AS name,
       COUNT(*)        AS total,
       SUM(t.amount)   AS total_amount
FROM portfolios AS p
INNER JOIN bank_accounts  AS b ON p.portfolio_id = b.portfolio_id
INNER JOIN transactions   AS t ON t.account_id = b.account_id
INNER JOIN counterparties AS c ON t.counterparty_Id = c.cp_id
WHERE c.verified_date IS NULL
  AND t.amount < 0
  AND t.status != 'failed'
GROUP BY p.portfolio_id, p.name;
