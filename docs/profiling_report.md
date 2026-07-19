# Sentinel AI — Data Profiling Report

## Scope
Structural, data-type, and category-consistency checks on train_transaction.csv 
and train_identity.csv, following the earlier reliability validation.

## Data Type Checks
- **TransactionDT** — loaded as int64, correctly interpreted as a time-delta 
  from a fixed reference point, not a calendar date. The "malformed dates" 
  check does not apply, since this field was never intended to be a real 
  timestamp.
- **TransactionID, isFraud, TransactionDT** — no out-of-range values found. 
  TransactionID and TransactionDT are positive integers throughout, isFraud 
  contains only 0 and 1.

## Category Consistency
- **ProductCD** — 5 unique values (W, H, C, S, R), matches documented product 
  codes exactly. No typos or casing inconsistencies. Clean.
- **DeviceType** — 2 valid categories (mobile, desktop), no inconsistencies. 
  ~2.37% of records are null , this reflects missing device data, not a 
  category error, and is consistent with the identity table's broader 
  missingness pattern.

## Anomaly Flagged for Investigation
- **D1–D15 (time-delta features)** — expected to be non-negative, but 6 of 15 
  columns (D4, D6, D11, D12, D14, D15) show negative minimum values (as low as 
  -193). Not treated as a data error — likely reflects that these are relative 
  time-deltas anchored to different reference points per column, which isn't 
  fully documented by the dataset provider. Flagged for further investigation 
  rather than correction at this stage.

## Structural Integrity (carried over from Day 3)
- Primary key (TransactionID) — unique, zero nulls, in both tables.
- Join validation — all 144,233 identity records match a transaction record; 
  no orphaned rows.
- Missing identity data — 76% of transactions have no identity record. This 
  absence is treated as a potential signal, not just a data gap, since identity 
  collection was optional.

## Summary
Both files pass structural and category-consistency checks. No blocking data 
quality issues identified. One anomaly (D-column negative values) is logged 
for further investigation during feature engineering, rather than treated as 
an error requiring immediate correction.
