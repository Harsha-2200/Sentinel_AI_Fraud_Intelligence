# Data Cleaning Plan

## Approach
Rather than applying a default cleaning rule to every column, each 
column's missing values were tested against actual fraud rate before 
deciding how to handle them. This approach was chosen after an early 
finding that missing identity data correlated strongly with fraud risk, 
suggesting the same might be true elsewhere in the dataset.

## Categorical Columns
Columns confirmed as text-based, by checking their actual data type 
rather than assuming, were filled with the label Unknown wherever a 
value was missing. This includes card4, card6, DeviceType, 
P_emaildomain, R_emaildomain, M1 through M9, and the identity columns 
confirmed to be text-based. Unknown was used instead of guessing a real 
value, since guessing would mean fabricating data that was never 
actually collected.

## Numeric Columns
Numeric columns where missing values were tested and found to 
meaningfully correlate with fraud rate were left as true missing values, 
not filled in. This includes card2, card3, card5, addr1, addr2, dist1, 
dist2, the D-columns, the V-columns, and the numeric identity columns. 
Filling these with an average or common value would have erased the real 
difference in fraud rate between rows where the value is present versus 
missing.

## Evidence Behind This Decision
Real fraud rate testing was performed across every major column group 
before finalizing this approach.

addr1 and addr2 showed an 11.18 percent fraud rate when missing, 
compared to 2.51 percent when present, the strongest single signal 
found in the dataset.

Identity columns split into four distinct groups by testing correlation 
in their missing and present patterns. One group showed a 10.44 percent 
fraud rate when present versus 2.49 percent when missing, the strongest 
identity signal found. The remaining three groups showed varying but 
consistently meaningful gaps.

D-columns split into two groups with opposite behavior. One group showed 
higher fraud rate when present, reaching as high as 14.88 percent for 
one column versus 2.70 percent when missing. The other group showed the 
opposite pattern, higher fraud rate when missing.

M-columns were tested individually. M1, M2, and M3 were confirmed to 
always be present or missing together. M7, M8, and M9 were confirmed 
near-identical, with 13 exceptions out of 590,540 rows. M6 showed the 
strongest individual signal, with fraud rate rising from 2.06 percent 
present to 7.07 percent missing. M4 showed the opposite direction from 
most other columns.

## A Correction Made During This Process
An early assumption was made that all identity columns from id_12 to 
id_38 were categorical, based on a general pattern in the column naming. 
Checking each column's actual data type directly showed this was not 
fully accurate. Twelve of these columns are genuinely numeric, not 
categorical. This was corrected before finalizing which columns received 
the Unknown label versus which were left as true missing values.

## Type Fix
TransactionDT is a time-delta value, the number of seconds elapsed from 
a fixed reference point, not a real calendar date. An hour column and a 
day column were derived from it to check patterns across the day and 
across the dataset's timeframe, since no real calendar date or weekday 
could be extracted from this field.

## Structural Checks
No duplicate rows were found anywhere in the dataset. TransactionID was 
confirmed as a valid primary key, with no duplicates and no missing 
values, in both the transaction and identity tables.

## Two Real Import Bugs Found and Fixed
While loading data into SQL, two separate bugs were found and corrected. 
The first was a column order mismatch, where a table schema did not 
exactly match the CSV file's column order, causing text values to load 
silently into the wrong numeric column. The second was a null handling 
issue, where empty numeric values were being silently converted to zero 
during import instead of true missing values. Both were fixed by 
explicitly generating the schema and load statements to match the 
source file exactly, and by using NULLIF during import to force true 
missing values.
