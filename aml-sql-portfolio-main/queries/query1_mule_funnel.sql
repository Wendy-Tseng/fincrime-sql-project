-- Example 1: Detect potential mule / funnel accounts
-- Goal: identify destination accounts receiving many incoming transfers or cash-outs

SELECT
  nameDest,
  COUNT(*) AS txn_count,
  ROUND(SUM(amount), 2) AS total_received,
  ROUND(AVG(amount), 2) AS avg_amount
FROM transactions
WHERE type IN ('TRANSFER', 'CASH_OUT')
GROUP BY nameDest
HAVING txn_count >= 2    -- threshold for suspicious inbound activity
ORDER BY txn_count DESC, total_received DESC
LIMIT 20;
