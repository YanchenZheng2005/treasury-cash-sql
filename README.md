# treasury-cash-sql

SQL analysis of a treasury cash database in MySQL 8: cash activity by bank and portfolio, counterparty payment controls, cash forecast accuracy, and data quality checks.

## Database

| Table | Contents |
|---|---|
| `portfolios` | 8 investment portfolios (Fixed Income, Private Equity, Money Market, ...) |
| `bank_accounts` | Bank accounts held by each portfolio, with bank name and open/closed status |
| `counterparties` | External parties paid or received from, with country and verification date (`NULL` = unverified) |
| `transactions` | 1,413 transactions, January–September 2026; `amount > 0` = inflow, `amount < 0` = outflow; status `settled` / `pending` / `failed` |
| `cash_forecasts` | Monthly forecasted inflow per portfolio |

Relationships: `transactions.account_id → bank_accounts`, `bank_accounts.portfolio_id → portfolios`, `transactions.counterparty_id → counterparties`, `cash_forecasts.portfolio_id → portfolios`.

## How to run

In the MySQL command-line client, from the repository folder:

```sql
SOURCE schema/01_schema.sql;   -- creates the treasury database and tables
SOURCE schema/02_seed.sql;     -- loads the data
SOURCE schema/03_views.sql;    -- creates the views
```

Then run any file under `queries/`. Note: `01_schema.sql` drops and recreates the `treasury` database.

## Repository structure

```
schema/
  01_schema.sql          tables and keys
  02_seed.sql            data
  03_views.sql           views used by the queries
queries/
  01_basics/             filtering, grouping, sorting across joined tables
  02_joins/              subqueries, CASE, LEFT JOIN with zero counts, multi-table joins
  03_dashboard/          window functions and CTEs: running balances, month-over-month change,
                         forecast error, top transaction per portfolio, share of total
  04_data_quality/       orphan payments, pending aging, unverified exposure, forecast/activity
                         mismatches, weekend settlements, a view, and a rolled-back cleanup transaction
findings.md              summary of results
```

Each query file starts with a one-line `Purpose` comment.

## SQL used

JOIN / LEFT JOIN, GROUP BY / HAVING, CASE, subqueries (scalar, `IN`, correlated), CTEs, window functions (`SUM() OVER`, `LAG`, `ROW_NUMBER`), views, and transactions (`START TRANSACTION` / `ROLLBACK`).
