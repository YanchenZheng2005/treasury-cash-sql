# Findings

Transactions cover January–September 2026. Amounts in dollars; M = million.

## Cash flows

- **Banks:** JPMorgan carries the most settled activity (283 transactions). CIBC (−$187.6M) and BMO (−$78.4M) are the only banks with net settled outflows.
- **Portfolios:** Fixed Income (−$62.8M), Infrastructure (−$45.7M) and Canadian Equity (−$40.3M) are net users of cash. Private Equity (+$149.1M) and Money Market (+$113.0M) bring in the most.
- **Largest single outflow:** −$204.1M on 2026-06-08 from Fixed Income through CIBC to Apollo Global (verified). It drives Fixed Income's −$220.7M net in June. Infrastructure's largest transaction, a −$152.7M outflow, came two days later.
- **Top payees:** KKR & Co ($351.9M), Apollo Global ($227.3M), Custodian Fees Co ($207.9M), TPG Capital ($192.8M), Ontario Teachers ($166.3M).

## Counterparty controls

- **Unverified exposure:** 127 of 489 settled payments (26.0%) and $812.9M of $3.44B (23.6%) went to counterparties that have not been verified.
- 7 of 25 counterparties are unverified, and every one of them is still being paid. **TPG Capital** is unverified yet tied for the most settled payments received (28) and is the 4th largest payee by amount.
- Including pending payments, 148 non-failed payments went to unverified counterparties across all 8 portfolios. Fixed Income has the most exposure by amount ($216.5M, 28 payments); Private Equity has the most payments (34, $170.5M).

## Cash forecasting

- **March 2026:** forecasted inflow was $699.6M vs actual settled inflow of $651.3M. Inflow was overestimated in 6 of 8 portfolios, most for Canadian Equity (+20.4%) and Emerging Markets (+20.3%). Real Estate (−13.1%) and Money Market (−2.8%) were underestimated.
- **January–September:** forecasts overstate inflow for 7 of 8 portfolios; the overstatement is largest for Canadian Equity (+52.8%) and Emerging Markets (+33.0%). Private Equity is the only portfolio forecast slightly low (−2.3%).
- **Forecasts with no activity:** Real Estate has forecasts for May–September but no transactions in those months. Its only bank account (106, RBC) is closed, so these forecasts should be retired or moved to an active account.

## Data quality

- **Closed accounts still holding pending items:** accounts 106 (RBC), 109 (TD) and 115 (BMO) are closed and have had no transactions since July 1, yet still carry 14 pending transactions (3, 4 and 7). The cleanup for 109 and 115 marks 11 rows as failed; it was tested inside a transaction and rolled back.
- **Payments with no counterparty:** 139 non-failed outflows have no counterparty. Transfers (86, $217.6M) and fees (12, $1.0M) are expected without one. Redemptions (21, $209.1M) and trade settlements (20, $148.7M) should always name a counterparty, so these 41 payments ($357.8M) need review.
- **Stale pending items (as of 2026-09-30):** 137 transactions are still pending. 96 of them ($729.3M) have been pending for more than 30 days; 17 ($115.3M) for 8–30 days and 24 ($153.3M) for 0–7 days.
- **Weekend settlements:** 53 settled transactions ($420.7M) are dated on a Saturday or Sunday, when payment systems are normally closed. The 5 largest are all subscriptions of $20.9M–$24.8M.
