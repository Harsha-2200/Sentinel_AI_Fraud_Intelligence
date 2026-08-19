# Dataset Overview, Reliability, and License

## Source
The IEEE-CIS Fraud Detection dataset, published through a Kaggle 
competition by the IEEE Computational Intelligence Society.

## Structure
The dataset contains two tables, train_transaction and train_identity, 
joined on TransactionID. The transaction table has 590,540 rows and 394 
columns. The identity table has 144,233 rows and 41 columns. Only about 
24 percent of transactions have an associated identity record, since 
identity data collection was optional and depended on the transaction 
channel.

## Nature of the Data
The dataset is described as semi-synthetic. The core transaction data is 
real, but sensitive and identifying features have been masked and 
transformed to protect privacy. This means the data is real with 
synthetic disguising applied to certain fields, not fabricated data.

## Class Imbalance
Fraud makes up roughly 3.5 percent of all transactions. This imbalance 
is expected and realistic, since genuine fraud is naturally rare compared 
to legitimate activity.

## License
The dataset is licensed for non-commercial use only, including academic 
research and education, under Kaggle competition rules, Section 7A, Data 
Access and Use. Raw dataset files are not included in this repository, 
since redistribution of the raw competition data is not permitted under 
these terms.

## Undocumented Columns
Several column groups, including card1 through card6, the D-columns, and 
the 339 V-columns, are not individually documented by the dataset 
provider. Their exact real-world meaning is not officially confirmed. 
Where this project draws conclusions about these columns, it is based on 
tested statistical patterns, not assumed meaning.
