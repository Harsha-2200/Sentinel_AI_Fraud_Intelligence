# LLM Narrative Integration

## Purpose
As an extension to the rule-based investigation summary engine, a prompt 
engineering pipeline was built to demonstrate how a large language model 
could generate more natural, flexible investigation summaries from the 
same underlying data.

## Approach
A structured prompt was built combining the transaction's predicted 
fraud probability, its top SHAP-identified risk factors, and key 
transaction details, along with instructions for the tone, length, and 
audience of the generated summary.

## Demonstration
Since a live API key was not available for this project, the actual 
language model response was simulated to demonstrate the expected 
output format and prompt structure. The prompt construction logic itself 
is fully functional and would work directly with a live Anthropic or 
OpenAI API key without modification.

## Comparison to the Rule-Based Engine
The rule-based investigation summary engine produces fixed, predictable 
output based on explicit programmed logic. The language model approach 
can produce more naturally phrased, flexible summaries, and can better 
handle combinations of signals that were not explicitly anticipated in 
advance, at the cost of requiring an external API and losing some 
control over the exact wording produced.
