USE treasury;

-- Unverified-counterparty share of settled outflows (used by queries/04_data_quality/06_view_unverified_exposure.sql)
CREATE OR REPLACE VIEW v_unverified_exposure AS
WITH outflow AS (
    SELECT t.amount, c.verified_date
    FROM transactions AS t
    INNER JOIN counterparties AS c
        ON t.counterparty_id = c.cp_id
    WHERE t.status = 'settled' AND t.amount < 0
)
SELECT SUM(verified_date IS NULL)                                          AS unverified_cnt,
       COUNT(*)                                                            AS total_cnt,
       ROUND(SUM(verified_date IS NULL) / COUNT(*) * 100, 2)               AS cnt_pct,
       ABS(SUM(CASE WHEN verified_date IS NULL THEN amount ELSE 0 END))    AS unverified_amt,
       ABS(SUM(amount))                                                    AS total_amt,
       ROUND(SUM(CASE WHEN verified_date IS NULL THEN amount ELSE 0 END) / SUM(amount) * 100, 2) AS amt_pct
FROM outflow;
