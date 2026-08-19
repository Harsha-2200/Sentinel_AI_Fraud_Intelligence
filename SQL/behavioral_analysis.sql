use sentinel_ai;


-- cheking email mismatch
SELECT TransactionID, P_emaildomain, R_emaildomain
FROM sentinel_sample
WHERE P_emaildomain NOT IN ('unknown') 
  AND R_emaildomain NOT IN ('unknown')
  AND P_emaildomain != R_emaildomain;
  
  
  -- checking count of rows with identity data.
  select case when DeviceType = 'unknown' then 'No Identity Data' else 'Has Identity Data' end as identity_status,
  count(*) as total_count,
  sum(isFraud) AS fraud_count,
    round(sum(isFraud) * 100.0 / count(*), 2) AS fraud_rate_pct
  from sentinel_sample
  group by identity_status;
  
  
  CREATE INDEX idx_card1_sample ON sentinel_sample(card1);
  
  -- Velocity check 
  select a.card1,a.TransactionID as txn1,
  b.TransactionID as txn2, a.TransactionDT as time1_hours,
  b.TransactionDT as time2_hours, (b.TransactionDT - a.TransactionDT) as time_diff_seconds
  from sentinel_sample a join sentinel_sample b 
  on a.card1 = b.card1 and a.TransactionID < b.TransactionID and
  (b.TransactionDT - a.TransactionDT) <= 3600
  order by time_diff_seconds
  limit 20;
  
  -- Grouping card1 to check velocity
  with velocitycheck as (select a.card1,a.TransactionID as txn1,
  b.TransactionID as txn2, a.TransactionDT as time1_hours,
  b.TransactionDT as time2_hours, (b.TransactionDT - a.TransactionDT) as time_diff_seconds
  from sentinel_sample a join sentinel_sample b 
  on a.card1 = b.card1 and a.TransactionID < b.TransactionID and
  (b.TransactionDT - a.TransactionDT) <= 3600)
  select card1,count(*) as pair_count
  from velocitycheck 
  group by card1
  having pair_count >= 3
  order by pair_count desc;
  
  
  -- Checking count of transactions for card1
  select card1,count(*) as total_count
  from sentinel_sample
  group by card1
  order by total_count desc
  limit 10;
  
-- Insight — SQL Velocity Detection & Cross-Verification

-- Built a self-join query in SQL to detect transactions happening close together in time on the same card, 
-- a common signal for card-testing fraud. The closest pairs found were only seconds apart, for example one card had two transactions just 7 seconds apart.

-- Grouped these pairs by card to count how many close-together transactions each card had.
-- The results matched exactly with an independent check done in Python, confirming the same top cards 
-- (like the one with 522 total transactions and 239 close-timed pairs) appeared in both tools with identical numbers.

-- This cross-verification between SQL and Python is an important confirmation that the data and logic are consistent, 
-- not just correct in one tool by chance. It also reinforced an earlier finding, that cards with extremely high 
-- transaction volume are more likely shared or default codes rather than genuine individual fraud activity, since 
-- checking their actual fraud rate showed it was lower, not higher, than normal.



SELECT 
    card1,
    TransactionID,
    TransactionDT,
    LAG(TransactionDT) OVER (PARTITION BY card1 ORDER BY TransactionDT) AS prev_txn_time,
    TransactionDT - LAG(TransactionDT) OVER (PARTITION BY card1 ORDER BY TransactionDT) AS seconds_since_last_txn
FROM sentinel_sample
ORDER BY card1, TransactionDT
LIMIT 30;

-- Insight — Behavioral Baseline (LAG Analysis)

-- Used a window function to calculate the time gap between each card's consecutive transactions, 
-- based on their actual order in time rather than just checking pairs within a fixed one-hour window. 
-- This shows each card's typical rhythm of activity, and a sudden drop from a card's normal gap to just seconds or minutes could signal unusual behavior. 
-- This approach captures a similar pattern to the daily velocity feature already built in Python, 
-- using a different SQL technique, window functions with LAG, to demonstrate the same behavioral concept.

-- KPI View: Fraud rate and transaction count by ProductCD and DeviceType
-- Reusable summary object - can be queried directly without rewriting 
-- the underlying aggregation each time
CREATE VIEW fraud_kpi_summary AS
SELECT 
    ProductCD,
    DeviceType,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS total_fraud_cases,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM sentinel_sample
GROUP BY ProductCD, DeviceType
ORDER BY fraud_rate_pct DESC;

-- Query the view
SELECT * FROM fraud_kpi_summary;