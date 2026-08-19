# Alert Routing System

## Purpose
Rather than treating every flagged transaction the same way, a 
three-tier system was built to convert the model's probability score 
into an actionable decision, matching how a real fraud team would 
realistically respond to different confidence levels.

## The Three Tiers
Transactions scoring 0.8 or higher are routed to P1, Hard Block, and are 
stopped immediately. Transactions scoring between 0.4 and 0.8 are routed 
to P2, Step-Up Verification, requiring extra confirmation such as an OTP 
before proceeding. Transactions scoring below 0.4 are routed to P3, 
Auto-Approve, and pass through without added friction.

## Results
P1 transactions show a 45.8 percent real fraud rate, over 13 times the 
overall baseline. P3 transactions show just 0.86 percent, confirming the 
system correctly separates genuinely risky transactions from safe ones. 
Combined, P1 and P2 catch 80.49 percent of all real fraud in the test 
set.

## Testing the Tier Boundaries
The boundary between P2 and P3 was not assumed. Several possible values 
were tested directly. Lowering the boundary to 0.1 would catch 98.55 
percent of fraud, but would require step-up verification on nearly 132,000 
transactions, about three quarters of the entire test set, which is not 
operationally realistic. The chosen boundary of 0.4 represents a genuine, 
tested tradeoff between fraud coverage and workload, catching 80.5 
percent of fraud while limiting extra verification to about 18 percent 
of transactions.

## Investigation Summary Engine
Built on top of the alert routing system, a rule-based engine converts 
each flagged transaction's top SHAP contributors into a plain-language 
summary, similar to how investigation summaries are written manually in 
real fraud work. Engineered features with known business meaning, such 
as high-risk timing or unusual spending patterns, are explained in clear 
language. Anonymized dataset columns without documented meaning are 
honestly labeled as anonymized signals rather than given a fabricated 
explanation.
