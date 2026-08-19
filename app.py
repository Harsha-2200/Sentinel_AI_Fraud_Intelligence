#!/usr/bin/env python
# coding: utf-8

# In[21]:


import streamlit as st
import joblib
import pandas as pd

# Load the saved, already-trained model - no retraining needed here
model = joblib.load('sentinel_xgboost_model.pkl')

# Load the saved median values (used as defaults for any feature the 
# user doesn't manually enter) and the exact column order the model expects
median_values = joblib.load('feature_medians.pkl')
feature_columns = joblib.load('feature_columns.pkl')

# Page setup
st.set_page_config(page_title="Sentinel AI - Fraud Detection")
st.title("Sentinel AI: Fraud Investigation Intelligence")
st.write("Enter transaction details below to get a real-time fraud risk assessment.")

# Input form - only collecting the most important features, based on 
# SHAP analysis. Everything else uses a saved median/default value.
st.header("Transaction Details")
transaction_amt = st.number_input("Transaction Amount ($)", min_value=0.0, value=100.0)
hour = st.slider("Hour of Day (0-23)", 0, 23, 12)
daily_velocity = st.number_input("Transactions by this card today", min_value=1, value=1)
product_cd = st.selectbox("Product Category", ['C', 'H', 'R', 'S', 'W'])
device_type = st.selectbox("Device Type", ['mobile', 'desktop', 'unknown'])
card_avg_amount_input = st.number_input("This card's typical average amount ($)", min_value=0.0, value=100.0)

# Prediction logic - only runs when the button is clicked
if st.button("Check Fraud Risk"):
    # Build a full-width input row using saved median values as a 
    # starting template, since the model expects hundreds of features 
    # but the form only collects a handful manually
    input_row = median_values.to_frame().T

    # Ensure every column the model expects exists in this row, 
    # filling anything missing with 0 as a final safety net
    for col in feature_columns:
        if col not in input_row.columns:
            input_row[col] = 0
    input_row = input_row[feature_columns]  # correct column order

    # Overwrite the specific fields the user actually entered
    input_row['TransactionAmt'] = transaction_amt
    input_row['hour'] = hour
    input_row['daily_velocity'] = daily_velocity

    # Inside the button block, alongside your other input_row overwrites:
    input_row['card_avg_amount'] = card_avg_amount_input

    # Since amt_difference was engineered as TransactionAmt minus 
    # card_avg_amount, recalculate it here too so it stays consistent 
    # with the two values the user actually entered
    input_row['amt_difference'] = transaction_amt - card_avg_amount_input

    # ProductCD and DeviceType were one-hot encoded during training,
    # so we set the matching dummy column to 1 and all others to 0
    for col in input_row.columns:
        if col.startswith('ProductCD_'):
            input_row[col] = 1 if col == f'ProductCD_{product_cd}' else 0
        if col.startswith('DeviceType_'):
            input_row[col] = 1 if col == f'DeviceType_{device_type}' else 0

    # Temporary debug line - shows what's actually in the input row 
    # before prediction, to confirm our values are being set correctly
    st.write("Debug - daily_velocity value being used:", input_row['daily_velocity'].values[0])
    st.write("Debug - hour value being used:", input_row['hour'].values[0])

    # Run the actual prediction - probability of class 1 (fraud)
    probability = model.predict_proba(input_row)[0][1]

    # Apply the same three-tier alert routing logic built and tested earlier
    if probability >= 0.8:
        tier, color = "P1 - Hard Block", "red"
    elif probability >= 0.4:
        tier, color = "P2 - Step-Up Verification", "orange"
    else:
        tier, color = "P3 - Auto Approve", "green"

    # Display the result
    st.subheader("Result")
    st.write(f"**Fraud Probability:** {probability*100:.2f}%")
    st.markdown(f"**Alert Tier:** :{color}[{tier}]")


# In[22]:


# Note about the demo's limitations, placed at the end of the app
st.markdown("---")
st.caption(
    "Note: This is a simplified demo interface. The underlying model uses "
    "446 total features, including anonymized dataset columns that aren't "
    "practical to expose in a manual form. Fields not shown here default "
    "to typical/median values, so extreme inputs in only the visible "
    "fields may not fully reflect the model's real-world sensitivity."
)


# In[ ]:


# Insight — Streamlit App & Demo Limitations

# Built an interactive Streamlit app that loads the trained model and lets a user enter a small set of 
# the most interpretable transaction details, product category, device type, hour, transaction amount, 
# card velocity, and a card's typical spending average, to get a real-time fraud probability and alert tier.

# Testing the app with deliberately extreme values, a very large transaction amount, a high-risk hour, 
# high card velocity, and a large gap from the card's typical spending, still consistently returned a low fraud probability 
# and the lowest alert tier. Investigating this confirmed it was not a bug. The model uses 446 total features, 
# and the demo form only allows manual control of 6 to 7 of them. The remaining features, including several of 
# the model's strongest SHAP-identified signals like anonymized V-columns, stay fixed at typical median values, 
# which is enough to keep the overall prediction low even when the visible inputs look extreme.

# This is an honest, realistic limitation of building a simplified interface on top of a complex, many-feature model, 
# and it was documented directly in the app rather than hidden, showing that the demo represents a subset of the model's 
# real decision-making process, not the full picture.

