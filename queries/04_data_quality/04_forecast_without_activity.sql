-- Purpose: Portfolio-months that have a cash forecast but no transactions.

WITH fc AS (
    SELECT DATE_FORMAT(cf.forecast_month, '%Y-%m') AS month,
           p.portfolio_id,
           forecast_id
    FROM portfolios AS p
    INNER JOIN cash_forecasts AS cf
        ON p.portfolio_id = cf.portfolio_id
),
txn AS (
    SELECT DATE_FORMAT(t.txn_date, '%Y-%m') AS month,
           p.portfolio_id,
           COUNT(*) AS cnt
    FROM portfolios AS p
    INNER JOIN bank_accounts AS b
        ON p.portfolio_id = b.portfolio_id
    INNER JOIN transactions AS t
        ON b.account_id = t.account_id
    GROUP BY month, p.portfolio_id
)
SELECT fc.month, fc.portfolio_id
FROM fc
LEFT JOIN txn
    ON fc.month = txn.month AND fc.portfolio_id = txn.portfolio_id
WHERE cnt IS NULL;
