-- schema.sql
-- Defines the transaction table for AML simulation
-- Dataset: Synthetic Financial Transactions (Kaggle)

CREATE TABLE transactions (
  transaction_id   INTEGER PRIMARY KEY,  -- unique transaction identifier
  step             INTEGER,              -- simulated time step (each = 1 hour)
  type             TEXT,                 -- CASH-IN, CASH-OUT, TRANSFER, PAYMENT, etc.
  amount           DECIMAL(15,2),        -- transaction amount
  nameOrig         TEXT,                 -- sender account ID
  oldbalanceOrg    DECIMAL(15,2),        -- sender's balance before
  newbalanceOrig   DECIMAL(15,2),        -- sender's balance after
  nameDest         TEXT,                 -- receiver account ID
  oldbalanceDest   DECIMAL(15,2),        -- receiver's balance before
  newbalanceDest   DECIMAL(15,2),        -- receiver's balance after
  isFraud          BOOLEAN,              -- 1 = confirmed fraud, 0 = normal
  isFlaggedFraud   BOOLEAN               -- 1 = system-flagged suspicious
);



