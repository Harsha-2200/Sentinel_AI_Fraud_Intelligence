# SQL Analysis

## Purpose
SQL was used to demonstrate and cross-verify key behavioral patterns 
found in the Python analysis, using joins, aggregations, window 
functions, and views.

## Schema and Import
A schema was built matching the cleaned dataset, generated 
programmatically from the dataframe's actual structure to avoid column 
order mismatches. Data was imported using explicit null handling to 
ensure true missing values were preserved rather than silently converted 
to zero.

## Email Pattern Detection
A query was written identifying transactions where purchaser and 
recipient email domains are both present and different from each other, 
matching the email mismatch feature built in Python.

## Missing Identity as a Signal
A query grouping transactions by whether device type data was present 
confirmed the same pattern found in Python, a fraud rate of 7.88 percent 
when identity data is present, compared to 2.10 percent when missing.

## Velocity Detection
A self-join query was built to detect transactions on the same card 
happening close together in time. The closest pairs found were only 
seconds apart. Grouping these by card and counting close-together pairs 
produced results that matched exactly with an independent calculation 
done in Python, confirming the same top high-volume cards and their 
transaction counts in both tools.

## Behavioral Baseline Using Window Functions
A window function query using LAG calculated the time gap between each 
card's consecutive transactions, based on their actual chronological 
order, demonstrating an alternative technique to the self-join approach 
for capturing the same underlying behavioral pattern.

## KPI View
A reusable database view was created summarizing fraud rate and 
transaction count by ProductCD and DeviceType together, allowing the 
summary to be queried directly without rewriting the underlying 
aggregation each time.

## Cross-Verification
Every major finding tested in SQL was checked against the equivalent 
Python calculation. Results matched exactly in every case, confirming 
the data and logic are consistent across both tools.
