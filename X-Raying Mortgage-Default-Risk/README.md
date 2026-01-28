# Mortgage Default Risk Analysis: Insights from Fannie Mae Data

## Project Overview
This project performs a deep dive into the drivers of mortgage loan defaults using large-scale performance data from **Fannie Mae**. By applying **Logistic Regression** and exploratory data analysis, the project identifies key risk factors such as credit scores, Debt-to-Income (DTI) ratios, and Loan-to-Value (LTV) ratios to inform data-driven lending decisions.

## Key Objectives
* [cite_start]**Identify Predictors**: Determine which borrower and loan characteristics most significantly influence the probability of default[cite: 1, 2].
* [cite_start]**Statistical Modeling**: Build and interpret a Logistic Regression model to quantify the impact of variables like Interest Rates and Loan Amounts.
* [cite_start]**Risk Management Insights**: Provide actionable recommendations for financial institutions to mitigate credit risk and optimize loan portfolios[cite: 1, 2].

## Technical Implementation
### Data Pipeline & Methodology
* [cite_start]**Data Source**: Fannie Mae Single-Family Loan Performance Data.
* **Variables Analyzed**: 
    * [cite_start]**Borrower Metrics**: Credit Score, DTI (Debt-to-Income).
    * [cite_start]**Loan Metrics**: Original Interest Rate, Loan Amount, LTV (Loan-to-Value).
* [cite_start]**Modeling**: Logistic Regression was utilized to estimate the probability of the binary outcome (Default vs. No Default).

### Key Findings
* [cite_start]**Credit Scores & LTV**: Higher credit scores and lower LTV ratios were strongly correlated with lower default rates, confirming them as primary risk indicators.
* [cite_start]**Loan Amount Paradox**: Interestingly, the analysis revealed that smaller loan amounts often carried substantial risk, challenging conventional assumptions that larger loans are inherently riskier.
* [cite_start]**DTI Impact**: High Debt-to-Income ratios were a significant predictor of financial strain and subsequent default.



## Analysis & Visualizations
The project includes comprehensive visualizations to communicate risk relationships:
* [cite_start]**Histograms**: Distribution of credit scores across defaulting and non-defaulting loans.
* [cite_start]**Scatter Plots**: Relationship between Interest Rates and Loan-to-Value ratios.

## Business Impact
[cite_start]This analysis mirrors the workflow of a **Credit Risk Analyst** in the financial industry. The insights generated support:
1.  [cite_start]**Nuanced Lending Strategies**: Moving beyond simple metrics to a holistic borrower risk profile.
2.  [cite_start]**Portfolio Stability**: Identifying high-risk segments before economic fluctuations trigger widespread defaults.

## Requirements
* `R` / `Python`
* `ggplot2` / `Seaborn` (Visualizations)
* `statsmodels` / `glm` (Statistical Modeling)
