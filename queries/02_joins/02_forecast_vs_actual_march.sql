-- Purpose: Forecasted vs actual inflow per portfolio, March 2026.

SELECT p.name               AS name,
       cf.forecasted_inflow AS forecasted_inflow,
       (SELECT SUM(t.amount)
          FROM bank_accounts AS b
         INNER JOIN transactions AS t ON t.account_id = b.account_id
         WHERE b.portfolio_id = p.portfolio_id
           AND t.txn_date BETWEEN '2026-03-01' AND '2026-03-31'
           AND t.amount > 0
           AND t.status = 'settled') AS actual_inflow
FROM portfolios AS p
INNER JOIN cash_forecasts AS cf ON p.portfolio_id = cf.portfolio_id
WHERE cf.forecast_month BETWEEN '2026-03-01' AND '2026-03-31';
