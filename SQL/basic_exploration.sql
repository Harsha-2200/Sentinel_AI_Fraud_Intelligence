use sentinel_ai;

-- Count and percentage of Fraud vs Genuine Transactions
select case when isFraud = 0 then 'Genuine' else 'Fraud' end as type_of_txn,
count(*) as total_count,
round(count(*)*100/sum(count(*)) over(),2) as percentage
from sentinel_sample
group by isFraud;

-- Top 5 highest transcations.
select TransactionID,TransactionAmt as txn_amount,
ProductCD,case when isFraud = 0 then 'genuine' else 'fraud' end as txn_type
from sentinel_sample
order by TransactionAmt desc
limit 5;

-- Each product type maximum amount.
select ProductCD, max(TransactionAmt) as max_amount,
round(avg(TransactionAmt),2) as avg_amt, round((max(TransactionAmt) / avg(TransactionAmt) * 100),2) as max_as_pct
from sentinel_sample
group by ProductCD
order by max_amount;

-- Repeatation of Crad1
SELECT 
    COUNT(DISTINCT card1) AS distinct_card1,
    COUNT(*) AS total_count
FROM sentinel_sample;