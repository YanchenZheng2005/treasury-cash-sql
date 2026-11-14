-- Purpose: Largest transaction (by absolute amount) in each portfolio.

WITH ranked_amount AS (
    SELECT p.name,
           t.txn_id AS id,
           t.txn_date AS date,
           t.amount AS amount,
           ROW_NUMBER() OVER (PARTITION BY p.name ORDER BY ABS(t.amount) DESC) AS rn
    FROM portfolios AS p
    INNER JOIN bank_accounts AS b
        ON p.portfolio_id = b.portfolio_id
    INNER JOIN transactions AS t
        ON b.account_id = t.account_id
)
SELECT name, id, date, amount
FROM ranked_amount
WHERE rn = 1;
