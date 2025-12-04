-- Example 2: Fraud rate by transaction type
-- Goal: Compare fraud concentration across different transaction channels.

SELECT
  type,
  COUNT(*) AS txn_count,
  SUM(CASE WHEN isFraud = 1 THEN 1 ELSE 0 END) AS fraud_count,
  ROUND(
    100.0 * SUM(CASE WHEN isFraud = 1 THEN 1 ELSE 0 END) / COUNT(*),
    4
  ) AS fraud_rate_pct,
  SUM(CASE WHEN isFlaggedFraud = 1 THEN 1 ELSE 0 END) AS flagged_count
FROM transactions
GROUP BY type
ORDER BY fraud_rate_pct DESC, txn_count DESC;
