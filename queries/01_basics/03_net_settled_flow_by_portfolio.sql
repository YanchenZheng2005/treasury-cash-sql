-- Purpose: Settled net cash flow per portfolio.

SELECT p.name          AS name,
       COUNT(*)        AS total,
       SUM(t.amount)   AS net_amount
FROM portfolios AS p
INNER JOIN bank_accounts AS b ON p.portfolio_id = b.portfolio_id
INNER JOIN transactions  AS t ON t.account_id = b.account_id
WHERE t.status = 'settled'
GROUP BY name
ORDER BY net_amount ASC;
