-- Purpose: All payments to unverified counterparties (excluding failed).

SELECT p.name      AS name,
       t.txn_date  AS date,
       t.amount    AS amount,
       c.name      AS counterparty
FROM portfolios AS p
INNER JOIN bank_accounts  AS b ON p.portfolio_id = b.portfolio_id
INNER JOIN transactions   AS t ON t.account_id = b.account_id
INNER JOIN counterparties AS c ON t.counterparty_Id = c.cp_id
WHERE t.amount < 0
  AND t.status != 'failed'
  AND t.counterparty_id IN (SELECT cp_id
                              FROM counterparties
                             WHERE verified_date IS NULL);
