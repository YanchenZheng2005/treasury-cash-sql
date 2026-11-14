-- Purpose: Unverified-counterparty share of settled outflows, read from the view v_unverified_exposure (defined in schema/03_views.sql).

SELECT *
FROM v_unverified_exposure;
