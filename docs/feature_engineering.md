# Feature Engineering

## Approach
Every engineered feature in this project was built based on a tested 
finding from the cleaning and EDA stages, not built speculatively. Each 
one was verified against real fraud rate evidence after being created.

## Presence Flags
Twelve presence flags were built to capture whether specific groups of 
columns had data present or missing, based on the four identity column 
groups, the two D-column groups, the M-column groups, and the combined 
addr1 and addr2 signal identified during cleaning.

A key technical decision was choosing between checking if at least one 
column in a group was present, or requiring all columns in a group to be 
present. Groups where columns were consistently sparse used the 
at-least-one approach. One group, containing a column that was present 
in almost every row, required the all-columns-present approach instead, 
since the simpler method would have made that flag nearly always true 
and meaningless.

## Email Domain Comparison
A three-category feature was built comparing the purchaser and recipient 
email domains, labeled as Match, Mismatch, or Cannot Compare. An initial 
two-category version blended genuinely different situations together and 
produced a misleading result. The corrected three-category version 
revealed a counterintuitive but real finding, a confirmed email match 
shows the highest fraud rate at 9.65 percent, higher than either a 
mismatch at 2.87 percent or missing data at 2.17 percent. This likely 
reflects situations where the real account holder is knowingly involved 
in the transaction, such as first-party fraud, since their own details 
remain fully consistent, unlike account takeover which typically 
introduces mismatches or missing data.

## Time-Based Risk Flag
A high-risk hour flag was built covering hours 4 through 10, based on 
the actual confirmed fraud rate pattern in the data, correcting an 
earlier assumption based on a generic late-night definition that did not 
match the real pattern found.

## Daily Velocity
A feature counting how many transactions each card made on each specific 
day was built. Testing this against fraud rate revealed a non-linear 
pattern, fraud rate rises from 2.14 percent at a single transaction to a 
peak of 4.13 percent at 6 to 20 transactions, then drops to 1.62 percent 
for cards with over 100 transactions in a day, consistent with the 
earlier finding that very high-volume cards are likely shared or default 
codes.

## Amount Compared to Card Average
A feature comparing each transaction's amount to that same card's 
typical average spending was built. Fraud rate is lowest near or below a 
card's normal average, rises for moderate overspending, peaking around 
6.3 percent for transactions 500 to 1000 above the typical amount.

## Log Transform
A log-transformed version of TransactionAmt was created to correct its 
heavy skew, reducing skewness from 14.37 to 0.49.

## Encoding for the Model
High-cardinality text columns, including DeviceInfo and several identity 
columns, were converted using frequency encoding, replacing each value 
with how often it appears in the data, since one-hot encoding would have 
created over a thousand mostly-empty columns. Low-cardinality columns, 
including ProductCD, card4, card6, and DeviceType, were one-hot encoded 
into separate binary columns. Columns already captured through tested 
presence flags, including the identity and M-columns, were not 
re-encoded to avoid redundant signal.

## Final Feature Set
After all engineering and encoding, the final model input contains 446 
columns, combining raw numeric columns left as true missing values 
where meaningful, engineered flags, frequency-encoded columns, and 
one-hot encoded categories.
