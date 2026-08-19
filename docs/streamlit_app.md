# Streamlit Demo Application

## Purpose
An interactive web application was built to demonstrate the trained 
model in a usable, live format, allowing a user to enter transaction 
details and receive a real-time fraud probability and alert tier.

## How It Works
The application loads the pre-trained model, along with saved reference 
data representing typical median values for all 446 features, using 
joblib, since a Streamlit application runs as a separate script from the 
notebook where the model was trained.

The form collects a small set of the most interpretable features, 
transaction amount, hour of day, transactions by this card today, 
product category, device type, and the card's typical average amount. 
Every other feature defaults to its saved median value. When the button 
is clicked, these values are combined into a full input row matching the 
model's expected structure, a prediction is generated, and the result is 
displayed alongside the alert tier from the routing system.

## A Real, Documented Limitation
Testing the application with deliberately extreme input values still 
consistently returned a low fraud probability. This was investigated and 
confirmed not to be a bug. The model uses 446 total features, and the 
demo form only allows manual control of 6 to 7 of them. The remaining 
features, including several of the model's strongest SHAP-identified 
signals, stay fixed at typical values, which is enough to keep the 
overall prediction low even when the visible inputs look extreme. This 
limitation is documented directly within the application itself.
