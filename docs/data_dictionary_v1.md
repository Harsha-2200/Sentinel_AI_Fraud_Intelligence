# Sentinel AI — Data Dictionary v1

## train_transaction.csv (590,540 rows × 394 columns)

| Column Group | Business Meaning |
|---|---|
| TransactionID | Unique transaction identifier — primary key, zero nulls, zero duplicates |
| isFraud | Target label — 0 = genuine, 1 = fraud |
| TransactionDT | Time-delta from a fixed reference point (not a real date) — used as the dataset's timeline anchor to derive hour-of-day and transaction sequence |
| TransactionAmt | Transaction amount |
| ProductCD | Product category code |
| card1–card6 | Card details — network, type, issuing bank info |
| addr1, addr2 | Address-related fields (billing/region info) |
| dist1, dist2 | Distance between delivery address and merchant/billing address |
| C1–C14 | Count features — how many times something occurred (e.g. addresses linked to a card) |
| D1–D15 | Time-delta features between specific events (e.g. days since previous transaction) — distinct from TransactionDT, which is the dataset-level timeline anchor. Note: some D-columns show negative minimum values — flagged for further investigation, not treated as an error |
| M1–M9 | Match features — whether two attributes matched (e.g. name on card vs. name on address), typically True/False/Unknown |
| V1–V339 | Vesta-engineered, anonymized numerical features — exact business meaning not officially disclosed, but carry predictive signal |

## train_identity.csv (144,233 rows × 41 columns)

| Column Group | Business Meaning |
|---|---|
| TransactionID | Same key as transaction table — foreign key, links identity record to a specific transaction. Only ~24% of transactions have a matching identity record |
| id_01–id_38 | Mix of identity and device fingerprinting signals (numeric and categorical) — exact meaning of individual columns not officially disclosed |
| DeviceType | Type of device used (e.g. mobile, desktop) |
| DeviceInfo | Device information/model string |

## Notes
- Dataset license: non-commercial use only, per Kaggle Section 7A. Raw CSV files are not committed to this repository.
- Full validation checks (primary key integrity, join validation, null profiling) documented separately in `docs/profiling_report.md`.
