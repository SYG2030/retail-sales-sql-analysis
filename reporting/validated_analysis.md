# Validated Analysis — Retail Sales

## 1. Project Context

This document contains the validated business findings from the Retail Sales SQL Analysis project.

The analysis uses a fictional retail dataset stored in Microsoft SQL Server. It examines completed sales, monthly revenue, product performance, customer spending, order behavior, and selected data-quality issues.

The purpose of this document is to provide a controlled source of information for AI-assisted business reporting.

**Important:** All monetary values use the dataset's unspecified currency. The results do not represent actual business performance.

## 2. Data Model

The `RetailSalesPractice` database contains four tables:

| Table | Description |
|---|---|
| Customers | Customer information, including name and region |
| Products | Product information, including name and category |
| Orders | Order date, customer, and order status |
| OrderItems | Product lines, quantities, and unit prices |

The tables are connected through primary and foreign keys.

## 3. Business Rules and Metric Definitions

### Revenue

Line revenue is calculated as:

`Quantity * UnitPrice`

### Completed Revenue

Only orders with status `Completed` are included.

Cancelled orders are excluded from completed revenue.

### Completed Orders

Each completed order is counted once, regardless of the number of product lines.

### Average Order Value (AOV)

AOV is calculated as:

`Total Completed Revenue / Number of Completed Orders`

Order-level totals are calculated before the average is computed.

### Other Reporting Rules

- Customer spending includes completed orders only.
- Product and category revenue represent revenue, not profit.
- Category-level order counts may overlap because one order can contain products from multiple categories.
- No currency conversion is applied.

## 4. Executive KPI Summary

| KPI | Validated Result |
|---|---:|
| Completed Orders | 8 |
| Completed Revenue | 13,240.00 |
| Average Order Value | 1,655.00 |
| Cancelled Revenue | 3,500.00 |
| Total Revenue Across All Statuses | 16,740.00 |
| Units Sold in Completed Orders | 20 |

## 5. Monthly Revenue Performance

| Month | Completed Orders | Revenue |
|---|---:|---:|
| January 2025 | 2 | 4,710.00 |
| February 2025 | 1 | 730.00 |
| March 2025 | 2 | 760.00 |
| April 2025 | 2 | 3,100.00 |
| May 2025 | 1 | 3,940.00 |
| **Total** | **8** | **13,240.00** |

January recorded the highest monthly revenue among the months shown, followed by May and April.

Revenue varied considerably across the observed months. The dataset is small and fictional, so these results should not be interpreted as evidence of a real or recurring retail trend.

## 6. Top Products by Revenue

| Rank | Product | Revenue |
|---|---|---:|
| 1 | Laptop | 7,000.00 |
| 2 | Monitor | 2,700.00 |
| 3 | Office Chair | 1,950.00 |

The Laptop generated the highest revenue among the products analyzed.

These figures do not indicate product profitability because product costs and profit margins are unavailable.

## 7. Revenue by Product Category

| Category | Revenue | Units Sold | Orders |
|---|---:|---:|---:|
| Electronics | 9,700.00 | 5 | 4 |
| Furniture | 1,950.00 | 3 | 2 |
| Accessories | 1,590.00 | 12 | 6 |
| **Total** | **13,240.00** | **20** | — |

Key observations:

- Electronics generated the highest category revenue.
- Accessories recorded the highest number of units sold.
- Category-level order counts overlap and must not be added to calculate distinct orders across the business.

## 8. Customer Spending

| Customer | Completed Orders | Total Spend |
|---|---:|---:|
| Sara | 3 | 8,330.00 |
| Fahad | 1 | 1,800.00 |
| Ali | 2 | 1,510.00 |
| Omar | 1 | 1,300.00 |
| Lina | 1 | 300.00 |

Sara was the highest-spending customer, with completed-order spending of 8,330.00.

Customer spending is calculated from completed orders only.

## 9. Customer and Product Exceptions

### Customers Without Orders

| Customer ID | Customer |
|---|---|
| 3 | Nora |

Nora has no matching orders in the dataset.

### Products Without Completed Sales

The original analysis returned no products without completed sales.

Every product in the current dataset had at least one sale associated with a completed order.

### Customer Region Data

One customer has a missing region:

| Customer | Issue |
|---|---|
| Lina | Region is missing |

The missing region should not be replaced with an assumed value. It should be investigated before using geographic customer analysis.

## 10. Orders Above Average Order Value

The following completed orders exceeded the AOV of 1,655.00:

| Order ID | Order Value |
|---|---:|
| 1009 | 3,940.00 |
| 1001 | 3,660.00 |
| 1007 | 1,800.00 |

These orders had values above the average completed order value in this dataset.

## 11. Data Validation Results

Six SQL validation checks were executed against the `RetailSalesPractice` database.

| ID | Validation Check | Result |
|---|---|---|
| V01 | Revenue Reconciliation | PASS |
| V02 | Order-Level Revenue Validation | PASS |
| V03 | Average Order Value Verification | PASS |
| V04 | Cancelled Orders Exclusion | PASS |
| V05 | Referential Integrity Audit | 0 orphan records |
| V06 | Data Quality Checks | 1 missing-region exception |

### V01 — Revenue Reconciliation

Completed revenue was compared with the sum of monthly completed revenue.

| Metric | Result |
|---|---:|
| Total Revenue | 13,240.00 |
| Total Monthly Revenue | 13,240.00 |
| Difference | 0.00 |

Status: PASS.

This confirms that the monthly revenue aggregation reconciles with the completed revenue total.

### V02 — Order-Level Revenue

The validation query returned eight completed orders with a combined revenue of 13,240.00.

Status: PASS.

The query also displays individual order values for review.

### V03 — AOV Verification

| Metric | Result |
|---|---:|
| Completed Orders | 8 |
| Total Revenue | 13,240.00 |
| Calculated AOV | 1,655.00 |

Status: PASS.

### V04 — Cancelled Orders Exclusion

| Metric | Result |
|---|---:|
| All Revenue | 16,740.00 |
| Completed Revenue | 13,240.00 |
| Cancelled Revenue | 3,500.00 |

Status: PASS.

The completed and cancelled revenue amounts are reported separately.

### V05 — Referential Integrity Audit

| Check | Issue Count |
|---|---:|
| Orders without Customers | 0 |
| OrderItems without Orders | 0 |
| OrderItems without Products | 0 |

No orphan records were found in the tested relationships.

This is an audit of existing records. It does not independently test whether foreign-key constraints prevent invalid inserts.

### V06 — Data Quality Checks

| Check | Issue Count |
|---|---:|
| Customers with Missing Region | 1 |
| Orders without Order Items | 0 |
| Products without Completed Sales | 0 |
| Order Items with Missing Values | 0 |

The one missing-region record is a data-quality exception, not a SQL execution failure.

### Validation Scope and Limitations

The validation queries were executed successfully in SQL Server Management Studio.

V01 checks reconciliation between two aggregations of the same underlying data. V02 and V03 compare recalculated results against fixed reference values for this dataset. V04 compares status-level revenue against fixed reference values.

These checks support consistency and regression verification, but they should not be described as fully independent verification of the source data.

V05 audits existing relationships, while V06 identifies selected data-quality exceptions.

## 12. Analytical Limitations

- The dataset is fictional and small.
- The data does not represent actual company performance.
- Revenue is not profit.
- Product costs, operating expenses, and profit margins are unavailable.
- Customer demographic and marketing information is unavailable.
- The observed period is too short to establish reliable seasonality.
- Missing customer-region information limits geographic analysis.
- Findings depend on the documented rule that cancelled orders are excluded from completed revenue.

## 13. Guidance for AI-Assisted Reporting

This document is the approved reference for preparing the management report.

Any AI system using this document must follow these rules:

1. Use only the figures and facts explicitly documented here.
2. Do not invent metrics, customer attributes, product costs, market conditions, or business explanations.
3. Do not describe revenue as profit.
4. Do not interpret this fictional dataset as actual company performance.
5. Do not treat a missing region as a known geographic value.
6. Distinguish confirmed findings from interpretations and recommendations.
7. Label recommendations as suggestions when they are not directly proven by the dataset.
8. Clearly disclose the dataset's limitations.
9. Preserve the distinction between completed and cancelled revenue.
10. If a requested conclusion cannot be supported by the available data, explicitly state that the information is insufficient.

## 14. Source and Reproducibility

The findings originate from SQL queries executed against the `RetailSalesPractice` database using Microsoft SQL Server and SSMS.

Relevant project files:

- `database/01_create_database.sql`
- `queries/01_analysis_queries.sql`
- `validation/01_data_validation.sql`
- `results/validated_findings.md`

The database creation script drops and recreates project tables when rerun. Running it again resets the data in those tables.

Only executed and validated results should be used as business-reporting facts.
