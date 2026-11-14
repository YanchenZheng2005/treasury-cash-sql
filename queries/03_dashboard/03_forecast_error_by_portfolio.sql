-- Purpose: Forecast error per portfolio: % by which forecasted inflow over- or underestimated actual inflow.

WITH comparison AS (
    SELECT p.name,
           SUM(t.amount) AS actual_inflow,
           (SELECT SUM(forecasted_inflow) FROM cash_forecasts WHERE portfolio_id = p.portfolio_id) AS forecasted_inflow
    FROM portfolios AS p
    INNER JOIN bank_accounts AS b
        ON p.portfolio_id = b.portfolio_id
    INNER JOIN transactions AS t
        ON b.account_id = t.account_id
    WHERE t.status = 'settled' AND t.amount > 0
    GROUP BY p.portfolio_id, p.name
)
SELECT name,
       ROUND(100 * (forecasted_inflow - actual_inflow) / actual_inflow, 2) AS pct
FROM comparison;
