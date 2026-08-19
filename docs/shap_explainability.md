# Model Explainability with SHAP

## Purpose
SHAP was used to understand which features drive the model's predictions 
and to explain why individual transactions are flagged, turning the 
model from a black box into something that can be shown and defended.

## Global Feature Importance
Averaging the absolute SHAP value for each feature across all 
predictions showed the strongest overall contributors are several 
count-based columns, the engineered card_avg_amount feature, 
TransactionAmt, and several anonymized V-columns. The engineered 
card_avg_amount feature ranked higher than the raw transaction amount 
itself, confirming that feature engineering added real value beyond the 
raw data.

## A Misleading Approach, Corrected
An initial attempt to average the signed SHAP value for each feature 
across the entire test set was misleading. Since the dataset is 96.5 
percent genuine, averaging across all rows made almost every feature 
appear to push toward genuine by default, simply reflecting the class 
imbalance rather than each feature's true behavior. The more reliable 
approach was examining individual transactions directly rather than 
averaging across the whole imbalanced dataset.

## Individual Transaction Explanation
For a specific transaction with a 99.97 percent predicted fraud 
probability, SHAP identified the top contributing features as C14, 
several V-columns, TransactionAmt, and the engineered high-risk-hour 
feature, confirming the engineered features are being used meaningfully 
by the model alongside the raw dataset columns.

## Feeding the Investigation Summary
This transaction-level explanation directly supports the investigation 
summary engine, which translates the top SHAP contributors for each 
transaction into a plain-language explanation.
