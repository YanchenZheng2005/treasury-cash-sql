-- Purpose: Monthly inflow, outflow, net, and month-over-month change in net per portfolio.

SELECT p.name,
       DATE_FORMAT(t.txn_date, '%Y-%m') AS month,
       SUM(CASE WHEN t.amount > 0 THEN t.amount ELSE 0 END) AS inflow,
       SUM(CASE WHEN t.amount < 0 THEN t.amount ELSE 0 END) AS outflow,
       SUM(t.amount) AS net,
       SUM(t.amount) - LAG(SUM(t.amount)) OVER (PARTITION BY p.name ORDER BY (DATE_FORMAT(t.txn_date, '%Y-%m'))) AS diff
FROM portfolios AS p
INNER JOIN bank_accounts AS b
    ON p.portfolio_id = b.portfolio_id
INNER JOIN transactions AS t
    ON b.account_id = t.account_id
WHERE t.status = 'settled'
GROUP BY p.name, month
ORDER BY p.name, month;
