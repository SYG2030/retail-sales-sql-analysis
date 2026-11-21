# Retail Sales Analytics | SQL Server & AI-Assisted Business Reporting

## Project Overview

This project demonstrates an end-to-end analytical workflow using Microsoft SQL Server, T-SQL, and AI-assisted business reporting.

A fictional retail dataset is analyzed to extract business insights related to sales revenue, products, customers, and order behavior. The validated SQL findings are then transformed into a structured management report using Claude, followed by human review to ensure accuracy and avoid unsupported conclusions.

The project combines relational database analysis, data-quality validation, business interpretation, and professional reporting.

**Important:** The dataset is fictional and small. It does not represent actual company performance. All monetary values are in an unspecified currency.

## Project Objectives

- Calculate completed sales revenue and order counts.
- Analyze revenue by month and product category.
- Identify top-performing products and highest-spending customers.
- Find customers without orders and products without completed sales.
- Calculate Average Order Value (AOV).
- Identify completed orders with values above the average.
- Perform data-quality and validation checks.
- Use AI to transform validated findings into a management-ready report.
- Review AI-generated content for numerical accuracy and unsupported assumptions.

## Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| Microsoft SQL Server | Relational database management |
| SQL Server Management Studio (SSMS) | SQL development and execution |
| T-SQL | Data analysis and validation queries |
| Claude | AI-assisted business reporting |
| Git & GitHub | Version control and project documentation |
| Markdown & PDF | Reporting and presentation |

## Data Model

The `RetailSalesPractice` database contains four tables:

| Table | Description |
|---|---|
| Customers | Customer details, including name and region. |
| Products | Product names, categories, and unit prices. |
| Orders | Order details, including customer, date, and status. |
| OrderItems | Product lines within orders, including quantity and unit price. |

The tables are connected through primary and foreign keys.

## Business Rules & Metric Definitions

- **Revenue:** Calculated at the order-item level as `Quantity × UnitPrice`.
- **Completed Revenue:** Includes only orders with a `Completed` status. Cancelled orders are excluded.
- **Completed Orders:** Each completed order is counted once, regardless of how many product lines it contains.
- **Average Order Value (AOV):** Total completed revenue divided by the number of completed orders. Order-level totals are calculated before averaging.
- **Category Order Counts:** An order can contain products from multiple categories, so category-level order counts may overlap and should not be summed to calculate total distinct orders.

## Key Findings

The following results were obtained by executing the analysis queries against the current dataset. Monetary values are reported in the dataset's unspecified currency.

### Sales Overview

| Metric | Result |
|---|---:|
| Completed Orders | 8 |
| Completed Revenue | 13,240.00 |
| Average Order Value | 1,655.00 |
| Cancelled Orders | 1 |
| Cancelled Order Value | 3,500.00 |

Cancelled order value is reported separately and excluded from completed revenue.

### Monthly Revenue

| Month | Completed Orders | Revenue |
|---|---:|---:|
| January 2025 | 2 | 4,710.00 |
| February 2025 | 1 | 730.00 |
| March 2025 | 2 | 760.00 |
| April 2025 | 2 | 3,100.00 |
| May 2025 | 1 | 3,940.00 |

January recorded the highest monthly revenue in the dataset.

### Top Three Products by Revenue

| Product | Revenue |
|---|---:|
| Laptop | 7,000.00 |
| Monitor | 2,700.00 |
| Office Chair | 1,950.00 |

The Laptop generated the highest revenue among the products analyzed. These figures represent revenue, not profit.

### Revenue by Category

| Category | Revenue | Units Sold |
|---|---:|---:|
| Electronics | 9,700.00 | 5 |
| Furniture | 1,950.00 | 3 |
| Accessories | 1,590.00 | 12 |
| **Total** | **13,240.00** | **20** |

Electronics generated the highest revenue, while Accessories recorded the highest number of units sold.

### Customer Spending

| Customer | Completed Orders | Total Spend |
|---|---:|---:|
| Sara | 3 | 8,330.00 |
| Fahad | 1 | 1,800.00 |
| Ali | 2 | 1,510.00 |
| Omar | 1 | 1,300.00 |
| Lina | 1 | 300.00 |

Sara was the highest-spending customer in the dataset.

### Orders Above Average Order Value

Three completed orders exceeded the AOV of 1,655.00:

| Order ID | Order Value |
|---|---:|
| 1009 | 3,940.00 |
| 1001 | 3,660.00 |
| 1007 | 1,800.00 |

## Data Quality & Validation

The project includes data-quality checks and six SQL validation checks.

### Data-Quality Findings

- **Customers without orders:** Nora was identified as having no orders.
- **Missing customer region:** Lina's region is missing.
- **Duplicate order-item IDs:** No duplicate IDs were returned by the query.
- **Orders without order items:** No orders without matching order-item records were found.
- **Products without completed sales:** No products met this condition in the current dataset.

### SQL Validation Summary

| ID | Validation Check | Result |
|---|---|---|
| V01 | Revenue Reconciliation | PASS — difference of 0.00 |
| V02 | Order-Level Revenue Validation | PASS — 8 orders, 13,240.00 |
| V03 | Average Order Value Verification | PASS — 1,655.00 |
| V04 | Cancelled Orders Exclusion | PASS — completed and cancelled revenue reported separately |
| V05 | Referential Integrity Audit | 0 orphan records |
| V06 | Data Quality Checks | 1 missing-region exception |

**Validation note:** V01 compares two aggregations of the same underlying data. V02, V03, and V04 compare recalculated results against fixed reference values. These checks support consistency and regression verification, but are not fully independent verification of the source data. V05 audits existing records and does not test foreign-key enforcement for future inserts.

The missing customer region is a data-quality exception, not a SQL execution failure.

## AI-Assisted Business Reporting

After completing and validating the SQL analysis, Claude was used to transform the documented findings into a structured management report.

The reporting workflow included:

1. Preparing a consolidated source file containing validated metrics, business definitions, findings, and limitations.
2. Designing a structured reporting prompt with accuracy and content-integrity requirements.
3. Using Claude to generate the initial management report.
4. Reviewing and refining the AI-generated content to remove unsupported interpretations and preserve analytical accuracy.
5. Producing a professionally formatted PDF report with KPI cards, charts, validation results, and business recommendations.

### Final Management Report

**[View the Retail Sales Management Report (PDF)](reporting/Retail_Sales_Management_Report.pdf)**

The report includes:

- Executive Summary and KPI overview.
- Sales performance and monthly revenue analysis.
- Product, category, and customer analysis.
- SQL validation results and data-quality observations.
- Evidence-based business recommendations.
- Dataset limitations and AI output review notes.

The AI-assisted report is based on validated project findings and underwent human review before publication.

## SQL Concepts Demonstrated

- Filtering and aggregation with `WHERE`, `GROUP BY`, and aggregate functions.
- Joining related tables using primary and foreign keys.
- Date-based aggregation using `YEAR`, `MONTH`, and `DATEFROMPARTS`.
- Common Table Expressions (CTEs) for order-level calculations.
- Subqueries and `NOT EXISTS` for identifying missing relationships.
- Conditional analysis of order statuses.
- Data-quality checks and validation queries.

## Project Structure

```text

retail-sales-sql-analysis/
│
├── database/
│   └── 01_create_database.sql
│
├── queries/
│   └── 01_analysis_queries.sql
│
├── results/
│   └── validated_findings.md
│
├── validation/
│   ├── 01_data_validation.sql
│   └── README.md
│
├── reporting/
│   ├── README.md
│   ├── validated_analysis.md
│   ├── reporting_prompt.md
│   ├── management_report_draft.md
│   └── Retail_Sales_Management_Report.pdf
│
├── docs/
│   └── README.md
│
└── README.md

```

## How to Run the Project

1. Open `database/01_create_database.sql` in SQL Server Management Studio.
2. Execute the script to create and populate the `RetailSalesPractice` database.
3. Open `queries/01_analysis_queries.sql`.
4. Execute the analysis queries against the `RetailSalesPractice` database.
5. Compare the query outputs with the findings in this README and `results/validated_findings.md`.

**Note:** The database creation script drops and recreates the project tables when rerun. Running it again will reset the data in those tables.

Recheck the findings whenever the underlying data or business rules change.

## Detailed Documentation

For additional project details, refer to:

- [`results/validated_findings.md`](results/validated_findings.md) — Original analysis findings.
- [`validation/README.md`](validation/README.md) — SQL validation documentation.
- [`reporting/README.md`](reporting/README.md) — AI-assisted reporting workflow and deliverables.
- [`reporting/validated_analysis.md`](reporting/validated_analysis.md) — Consolidated source of truth for reporting.
- [`reporting/reporting_prompt.md`](reporting/reporting_prompt.md) — Prompt used for AI-assisted report generation.

## Limitations

- The dataset is fictional and small; it does not represent actual company performance.
- The analysis measures revenue, not profit. Product costs and operating expenses are unavailable.
- Customer demographics and marketing data are not included.
- The dataset covers only five months, which is insufficient for reliable seasonality analysis.
- Missing customer-region information may limit geographic analysis.
- Findings depend on the documented rule that cancelled orders are excluded from completed revenue.
- Validation checks support consistency but are not fully independent verification of the source data.

## Conclusion

This project demonstrates an end-to-end workflow for transforming relational retail data into structured business insights.

It combines SQL-based analysis, data-quality validation, AI-assisted reporting, and human review to produce a professional management report.

The project highlights practical skills in SQL Server, analytical thinking, business reporting, AI-assisted workflows, and technical documentation. The findings should always be interpreted within the limitations of the fictional dataset.
