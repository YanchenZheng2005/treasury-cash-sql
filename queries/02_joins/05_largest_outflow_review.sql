-- Purpose: Largest single outflow with bank, portfolio, and counterparty details.

SELECT t.txn_date, t.amount, b.bank_name,
       p.name AS portfolio,
       c.name AS counterparty,
       CASE WHEN c.verified_date IS NULL THEN 'UNVERIFIED' ELSE 'verified' END AS cp_status
FROM transactions AS t
JOIN bank_accounts AS b ON t.account_id = b.account_id
JOIN portfolios    AS p ON b.portfolio_id = p.portfolio_id
LEFT JOIN counterparties AS c ON t.counterparty_id = c.cp_id
WHERE t.amount < 0
ORDER BY t.amount
LIMIT 1;
