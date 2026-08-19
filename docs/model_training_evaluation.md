# Model Training and Evaluation

## Model Choice
XGBoost was chosen for this project because tree-based models handle 
high-dimensional, mixed-type, and heavily missing data well, matching 
this dataset's structure, and because missingness itself was proven to 
be a meaningful signal throughout this project, which XGBoost can use 
natively without requiring imputation.

## Train and Test Split
A time-based split was used instead of a random split. TransactionDT has 
real chronological order, and a random split risks training on data from 
after the test period, which would not reflect how the model would 
actually perform in real deployment, predicting forward in time. The 
data was sorted by time and split 70 percent for training and 30 percent 
for testing, with the split point verified to have no time overlap 
between the two sets.

## Handling Class Imbalance
The training data showed a 27.43 to 1 ratio between genuine and fraud 
cases. Rather than using SMOTE to create synthetic fraud examples, the 
model was trained using scale_pos_weight, which tells XGBoost to treat a 
missed fraud case as roughly 27 times more costly than a false alarm 
during training, directly addressing the imbalance without altering the 
real data.

## Baseline Model
A first model using reasonable default hyperparameters achieved 71.3 
percent recall and 19.5 percent precision on the test set.

## Hyperparameter Tuning
RandomizedSearchCV was used to test different combinations of tree 
depth, learning rate, and number of trees, scored using PR-AUC, since 
plain accuracy is misleading for imbalanced data. The best combination 
found improved the model's overall PR-AUC score to 0.4541, but did not 
clearly outperform the baseline model at the default decision threshold. 
This showed that tuning hyperparameters and tuning the decision threshold 
solve different problems, one improves how well the model ranks 
predictions overall, the other decides where to draw the line for a 
specific decision.

## Threshold Selection
Multiple decision thresholds were tested directly on the tuned model. A 
threshold of 0.4 was chosen as the final cutoff, catching 80.5 percent 
of real fraud while keeping precision at a reasonable level, based on a 
deliberate business tradeoff between catching fraud and avoiding 
excessive false alarms and investigation workload.

## Final Model Performance
At the chosen threshold, the model catches 80.5 percent of all real 
fraud cases in the test set.
