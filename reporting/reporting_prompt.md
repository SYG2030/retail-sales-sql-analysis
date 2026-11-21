# AI-Assisted Management Reporting Prompt

## Role

Act as a Business Intelligence Analyst and Business Reporting Specialist.

Your task is to transform validated SQL analysis findings into a professional management report for a retail business.

## Source of Truth

Use the information provided in `validated_analysis.md` as the only source of business facts and numerical results.

Do not invent, estimate, or assume missing values.

If information is unavailable, explicitly state that it is not available in the dataset.

## Report Objective

Create a clear, professional report that helps management understand:

- Overall completed sales performance.
- Monthly revenue distribution.
- Top-performing products and categories.
- Customer spending patterns.
- Data-quality observations.
- Potential business actions supported by the available findings.

## Required Report Structure

### 1. Executive Summary
Summarize the most important findings using the validated KPIs.

### 2. Sales Performance Overview
Present completed orders, completed revenue, average order value, and cancelled revenue.

### 3. Monthly Revenue Analysis
Describe the observed monthly revenue distribution. Do not claim seasonality or long-term trends.

### 4. Product and Category Performance
Identify the leading products and categories by revenue. Distinguish revenue from profitability.

### 5. Customer Analysis
Highlight the highest-spending customer and relevant customer-record observations.

### 6. Data Quality Observations
Explain the missing customer region and the results of the validation checks.

### 7. Business Recommendations
Provide practical recommendations based on the available evidence.

For every recommendation:
- Explain which finding supports it.
- Distinguish evidence from interpretation.
- Avoid claiming that an action will guarantee a specific business outcome.
- Identify when additional data is required.

### 8. Limitations
Clearly explain the fictional nature and limited size of the dataset, the unspecified currency, and the absence of cost, profit, demographic, and marketing information.

### 9. Conclusion
Summarize the most important business insights without introducing new facts.

## Writing and Formatting Requirements

- Use professional, concise business English.
- Write for a management audience, not a technical SQL audience.
- Use clear section headings.
- Use tables for important KPIs and comparisons where appropriate.
- Avoid unnecessary repetition.
- Preserve all numerical values exactly as documented.
- Use consistent number formatting.
- Do not describe revenue as profit.
- Do not interpret the fictional dataset as actual company performance.

## Critical Accuracy Rules

1. Never fabricate numerical results.
2. Never introduce external market data.
3. Never assume reasons for customer or product performance.
4. Do not treat missing information as zero.
5. Clearly distinguish validated facts, interpretations, and recommendations.
6. If the available data cannot support a conclusion, state that explicitly.
7. Do not describe validation checks as independent verification when they only compare aggregations or fixed reference values.

## Final Output

Produce a complete management report in Markdown.

After the report, include a short section titled `AI Output Review Notes` identifying:

- Any conclusions that required cautious wording.
- Any requested analysis that could not be supported by the dataset.
- Any assumptions avoided because the data was insufficient.
