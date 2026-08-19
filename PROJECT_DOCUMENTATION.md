# Sentinel AI: Complete Project Documentation

## 1. Project Overview and Objectives
Sentinel AI is a fraud detection system built on the IEEE-CIS Fraud 
Detection dataset. The project combines rigorous data validation, 
feature engineering grounded in tested evidence, a trained and evaluated 
machine learning model, explainability, an automated alert routing 
system, and an interactive demo application. It was built by a fraud 
investigation professional with 4 years of real-world experience, 
applying that domain background to a technical pipeline.

Objectives: validate the dataset's reliability before use, test whether 
missing data carries meaningful signal rather than assuming a default 
cleaning approach, build a model that reliably identifies fraud risk, 
explain the model's decisions in a way a human investigator could trust, 
and route flagged transactions into actionable tiers rather than a 
single blunt decision.

## 2. Dataset Details
See `docs/dataset_overview.md` for full detail. In summary, the IEEE-CIS 
Fraud Detection dataset from Kaggle, 590,540 transactions, 394 features, 
joined with a separate identity table covering about 24 percent of 
transactions. Licensed for non-commercial, academic use only.

## 3. Project Stages

**Data Cleaning** — Full detail in `docs/data_cleaning_plan.md`. Missing 
values were tested against fraud rate before deciding how to handle each 
column, rather than assuming a default approach. Two real data import 
bugs were found and corrected along the way.

**Exploratory Data Analysis** — Full detail in `docs/eda_insights.md`. 
Covered distribution analysis, outlier detection, segment analysis by 
product and device.

**Feature Engineering** — Full detail in `docs/feature_engineering.md`. 
Twelve tested presence flags, an email domain comparison feature that 
revealed a counterintuitive finding, time and velocity-based features, 
and proper encoding for the model, resulting in a final 446-column 
feature set.

**SQL Analysis** — Full detail in `docs/sql_analysis.md`. Joins, 
aggregations, window functions, and a self-join velocity detection 
query, all cross-verified against independent Python calculations.

**Model Training and Evaluation** — Full detail in 
`docs/model_training_evaluation.md`. A time-based train and test split, 
class imbalance handled through scale_pos_weight, hyperparameter tuning, 
and a threshold chosen through direct testing rather than assumption.

**Explainability** — Full detail in `docs/shap_explainability.md`. SHAP 
was used to identify global feature importance and to explain individual 
transaction predictions.

**Alert Routing** — Full detail in `docs/alert_routing_system.md`. A 
three-tier system converting model probability into an actionable 
decision, with tier boundaries tested rather than assumed, plus a 
rule-based investigation summary engine.

**Streamlit Application** — Full detail in `docs/streamlit_app.md`. An 
interactive demo allowing live predictions, with an honestly documented 
limitation regarding the small subset of features exposed for manual 
input.

**LLM Narrative Integration** — Full detail in 
`docs/llm_narrative_integration.md`. A prompt engineering pipeline 
demonstrating how a language model could generate natural-language 
investigation summaries, with the response simulated due to not having 
an active API key.

## 4. Key Insights and Findings
Full detail in `docs/final_insights_and_recommendations.md`. Fraud rate 
is 3.5 percent overall. Product category, device type, and time of day 
each show statistically confirmed, meaningful differences in fraud risk. 
Missing data across many columns carries real signal rather than being 
random. The final model catches 80.5 percent of real fraud at the chosen 
threshold, and the alert routing system concentrates risk effectively 
into actionable tiers.

## 5. Tools and Technologies
Python, including pandas, numpy, scikit-learn, xgboost, shap, and 
streamlit. SQL, using MySQL. Jupyter Notebook for development.

## 6. Supporting Documents
All documents referenced above are located in the `docs/` folder of this 
repository.
