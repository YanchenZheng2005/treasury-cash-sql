-- Treasury Cash & Payments teaching database (MySQL 8)
DROP DATABASE IF EXISTS treasury;
CREATE DATABASE treasury CHARACTER SET utf8mb4;
USE treasury;

CREATE TABLE portfolios (
  portfolio_id INT PRIMARY KEY,
  name         VARCHAR(50) NOT NULL,
  asset_class  VARCHAR(30) NOT NULL,
  currency     CHAR(3)     NOT NULL
);

CREATE TABLE bank_accounts (
  account_id   INT PRIMARY KEY,
  portfolio_id INT NOT NULL,
  bank_name    VARCHAR(30) NOT NULL,
  currency     CHAR(3)     NOT NULL,
  opened_date  DATE        NOT NULL,
  status       ENUM('active','closed') NOT NULL DEFAULT 'active',
  FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id)
);

CREATE TABLE counterparties (

  cp_id         INT PRIMARY KEY,
  name          VARCHAR(60) NOT NULL,
  country       VARCHAR(30) NOT NULL,
  bank_name     VARCHAR(30) NOT NULL,
  swift_code    CHAR(8)     NOT NULL,
  verified_date DATE        NULL,
  verified_by   VARCHAR(30) NULL
);

CREATE TABLE transactions (
  txn_id          INT PRIMARY KEY,
  account_id      INT  NOT NULL,
  txn_date        DATE NOT NULL,
  txn_type        ENUM('subscription','redemption','trade_settlement','fee','interest','transfer') NOT NULL,
  amount          DECIMAL(16,2) NOT NULL,   -- positive = inflow, negative = outflow
  counterparty_id INT NULL,
  status          ENUM('settled','pending','failed') NOT NULL DEFAULT 'settled',
  FOREIGN KEY (account_id)      REFERENCES bank_accounts(account_id),
  FOREIGN KEY (counterparty_id) REFERENCES counterparties(cp_id)
);

CREATE TABLE cash_forecasts (
  forecast_id        INT PRIMARY KEY,
  portfolio_id       INT  NOT NULL,
  forecast_month     DATE NOT NULL,          -- first day of the month
  forecasted_inflow  DECIMAL(16,2) NOT NULL,
  forecasted_outflow DECIMAL(16,2) NOT NULL,
  created_date       DATE NOT NULL,
  FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id)
);
