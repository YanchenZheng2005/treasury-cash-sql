-- Purpose: Month-end running balance for each account.

SELECT b.account_id,
       DATE_FORMAT(txn_date, '%Y-%m') AS month,
       SUM(t.amount) AS total,
       SUM(SUM(t.amount)) OVER (PARTITION BY t.account_id ORDER BY (DATE_FORMAT(txn_date, '%Y-%m')) ASC) AS running_balance
FROM bank_accounts AS b
INNER JOIN transactions AS t
    ON b.account_id = t.account_id
WHERE t.status = 'settled'
GROUP BY t.account_id, month;
