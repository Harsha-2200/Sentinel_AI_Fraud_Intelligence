# Exploratory Data Analysis, Key Findings

## Baseline
Overall fraud rate across the full 590,540-row dataset is 3.499 percent.

## Transaction Amount Distribution
TransactionAmt is heavily right-skewed, with a skewness value of 14.37. 
Most transactions are small, with the 25th percentile at 43.32 and the 
median at 68.77, while the maximum reaches 31,937.39. A log transform 
was applied, reducing skewness to 0.49, a dramatic improvement that 
makes the column far more suitable for modeling.

## Outlier Analysis
Using the IQR method, 66,482 transactions, about 11.3 percent of the 
dataset, fall above the statistical upper limit for TransactionAmt. 
These are not necessarily fraud, but represent unusually large purchases 
worth flagging for closer inspection.

## Product Category Risk
Fraud rate varies significantly by ProductCD. Category C shows the 
highest fraud rate at approximately 11.7 percent. Category W, the most 
common category by volume, shows the lowest fraud rate at approximately 
2.0 percent, a more than five times difference.

## Device Type Risk
Mobile transactions show a fraud rate of approximately 10.2 percent, 
nearly double the desktop rate of approximately 6.5 percent.

## Time of Day Pattern
Fraud rate spikes sharply during early morning hours, peaking at 10.61 
percent during hour 7, more than three times the overall baseline. 
Transaction volume during this window is lower than average, suggesting 
fraud activity concentrates during periods of reduced monitoring.

## Card1 Behavior
Investigating the assumption that card1 represents individual cards 
revealed a more complex picture. Most cards behave normally, with 70 
percent showing 10 or fewer transactions across the dataset. However, a 
small group, about 1.5 percent of all cards, show transaction counts in 
the hundreds or thousands, far beyond what one individual could 
realistically generate. These high-volume cards showed lower fraud rates 
than normal, not higher, suggesting they represent shared or default 
codes rather than genuine individual cards.

## Correlation
Direct correlation between isFraud and raw numeric columns, including 
TransactionAmt, TransactionDT, hour, and card1, was found to be very 
weak, all values under 0.02. This does not mean these factors are 
unimportant. It confirms that fraud risk in this dataset is driven by 
non-linear, categorical patterns rather than simple straight-line 
relationships, which is exactly why segment analysis and statistical 
testing revealed strong patterns that raw correlation missed entirely.

## Sampling Note
Full-dataset profiling and missing value investigation were performed on 
the complete 590,540-row dataset in Python. This ensured findings about 
missingness patterns were based on the full data, not a subset.
