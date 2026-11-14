-- Purpose: Portfolios ranked by settled net flow, with each portfolio's share of total inflow.

SELECT p.name,
       SUM(t.amount) AS net,
       ROUND(100 * SUM(t.amount) / SUM(SUM(CASE WHEN t.amount > 0 THEN t.amount ELSE 0 END)) OVER (), 2) AS pct
FROM portfolios AS p
INNER JOIN bank_accounts AS b
    ON p.portfolio_id = b.portfolio_id
INNER JOIN transactions AS t
    ON b.account_id = t.account_id
WHERE t.status = 'settled'
GROUP BY p.name
ORDER BY net DESC;
