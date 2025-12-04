-- Example 3: Short-window outflow spike
-- Goal: Detect accounts with back-to-back high-value outflows over a short time interval.

WITH ordered AS (
    SELECT
        transaction_id,
        nameOrig,
        step,
        type,
        amount,
        SUM(amount) OVER (
            PARTITION BY nameOrig
            ORDER BY step
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        ) AS rolling_amount,
        COUNT(*) OVER (
            PARTITION BY nameOrig
            ORDER BY step
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        ) AS rolling_count
    FROM transactions
    WHERE type IN ('TRANSFER', 'CASH_OUT')
),

flagged AS (
    SELECT
        nameOrig,
        step,
        rolling_amount,
        rolling_count
    FROM ordered
    WHERE rolling_count = 2      -- 2-transaction rolling window
      AND rolling_amount >= 20000 -- threashold for combined outflow account
)

SELECT
    nameOrig,
    MIN(step) AS first_alert_step,
    MAX(step) AS last_alert_step,
    COUNT(*) AS alert_windows,
    MAX(rolling_amount) AS max_window_amount
FROM flagged
GROUP BY nameOrig
ORDER BY max_window_amount DESC
LIMIT 20;
