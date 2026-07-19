# Sentinel AI — Project Vision

## Problem Statement
Fraud investigators spend the most time and efforts to manually determining fraud 
typology by working through account history, device/IP changes, and behavioral 
signals case-by-case  before they can act. Getting the typology wrong means 
re-investigating from scratch, which slows down response and increases workload 
on already complex cases.

## Why This Matters
Non-fraud cases are straightforward. The real bottleneck is fraud cases — each 
one requires a full 360-degree review: checking prior alerts, verifying account 
age, device/IP changes, recent profile updates, and more, before the correct 
fraud typology (ATO, identity theft, scam, unauthorized transaction) can even 
be identified. Misdiagnosing the typology at this stage cascades into wrong 
actions, wasted re-investigation time, and inconsistent outcomes across analysts.

## What Sentinel AI Does
Two components working together:

1. **Rule-Based Typology Engine** — encodes real investigation logic (email 
   mismatch, new device, missing identity, account age, velocity) into a 
   decision path that identifies likely fraud typology and generates a plain-
   English investigation summary, the same way an experienced investigator 
   reasons through a case.

2. **XGBoost Risk Model** — predicts fraud probability from transaction and 
   identity features, with SHAP explainability, feeding into an alert 
   prioritization system (P1 Hard Block / P2 Step-Up / P3 Auto Approve).

## Connection to Investigation Experience
Built on 4 years of hands-on fraud investigation across PwC (AML/fraud 
360 review), IndusInd Bank (cybercrime, KYC, LEA coordination), and TCS 
(chargeback/dispute resolution). Every feature and rule in this system reflects 
real red flags used in actual case review and not theoretical fraud indicators.

## Success Metrics
- **Typology engine**: output matches investigator judgment on test cases 
  (qualitative validation against real investigation reasoning)
- **XGBoost model**: recall, precision, F1, FPR, FDR — same rigor applied as 
  FinGuard (0.0118% FPR, 8.26% FDR benchmark)
