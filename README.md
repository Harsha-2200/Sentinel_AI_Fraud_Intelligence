# Sentinel AI: Fraud Investigation Intelligence System

## Overview
Sentinel AI is a fraud detection system built on the IEEE-CIS Fraud 
Detection dataset, combining data validation, feature engineering, 
machine learning, explainability, and an interactive demo application. 
The project was built by a fraud investigation professional with 4 years 
of real-world experience, applying that domain knowledge to a technical 
pipeline rather than treating it as a purely academic exercise.

## What This Project Does
Given real transaction data, the system identifies which transactions are 
likely fraudulent, explains why each prediction was made, and routes each 
transaction into one of three action tiers, ranging from automatic 
approval to an outright block, based on the model's confidence level.

## Key Results
- Trained an XGBoost model achieving 80 percent recall at a tuned 
  decision threshold, meaning it catches 8 out of 10 real fraud cases
- Built a three-tier alert routing system that concentrates 45.8 percent 
  fraud rate into the highest-risk tier, over 13 times the baseline rate
- Used SHAP to explain individual predictions in plain language
- Built an interactive Streamlit demo application for live predictions

## Folder Structure
├── notebooks/ Data cleaning, EDA, feature engineering,
│ model training, LLM narrative testing
├── sql/ Schema, exploration, and behavioral analysis
│ queries
├── docs/ Full project documentation
├── app.py Streamlit demo application
└── sentinel_xgboost_model.pkl Saved, trained model


## Tools Used
Python (pandas, numpy, scikit-learn, xgboost, shap, streamlit), SQL 
(MySQL), Jupyter Notebook

## Dataset
IEEE-CIS Fraud Detection dataset, sourced from Kaggle, published by the 
IEEE Computational Intelligence Society. Licensed for non-commercial, 
academic and learning use only. Raw dataset files are not included in 
this repository, in line with the license terms.

## Documentation
See the `docs/` folder for detailed documentation covering the dataset, 
cleaning approach, exploratory analysis, feature engineering, SQL work, 
model training and evaluation, explainability, alert routing, the 
Streamlit application, and final business insights.
