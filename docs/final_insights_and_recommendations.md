# Final Insights and Recommendations

## Summary
This project analyzed the IEEE-CIS Fraud Detection dataset using a 
rigorous, evidence-based approach, testing assumptions with real data 
before acting on them, rather than applying default techniques without 
verification.

## Key Findings
Fraud rate overall is 3.5 percent. Product category C carries 
significantly higher risk than other categories, confirmed statistically 
significant. Mobile transactions carry meaningfully higher risk than 
desktop. Fraud concentrates sharply during early morning hours. Missing 
data across several column groups is not random, and in most cases 
correlates meaningfully with fraud risk, which directly shaped the 
cleaning approach used throughout this project.

## Model Performance
The trained model catches 80.5 percent of real fraud at the chosen 
decision threshold. The alert routing system built on top of this model 
concentrates risk effectively, with the highest tier showing a fraud 
rate over 13 times the baseline.

## Recommendations
Apply stronger verification specifically for transactions combining 
multiple risk factors together, such as product category C purchases 
made on mobile devices during early morning hours, rather than applying 
the same level of scrutiny to every transaction equally. Use the 
three-tier routing system to route the highest-confidence cases to 
immediate action, moderate-confidence cases to step-up verification, and 
low-risk cases through with minimal friction, protecting genuine 
customers from unnecessary delay while concentrating investigation 
effort where it matters most.

## Limitations
Several dataset columns, including card1 through card6, the D-columns, 
and the V-columns, are not officially documented, so while their 
statistical patterns were tested and confirmed meaningful, their exact 
real-world meaning cannot be confirmed with certainty. The Streamlit 
demo application only exposes a subset of the model's 446 features for 
manual input, which limits how strongly a small number of extreme inputs 
alone can shift the displayed prediction. The LLM narrative integration 
was demonstrated using a simulated response, since a live API key was 
not available during development.

## Future Scope
Integrating a live LLM API for production-ready narrative generation, 
expanding the Streamlit demo to expose additional high-importance 
features, and building a feedback loop where investigator decisions are 
used to periodically retrain and improve the model.
