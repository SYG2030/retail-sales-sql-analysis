# Retail Sales SQL Analysis

## Project Overview

This project uses Microsoft SQL Server and T-SQL to analyze a fictional retail dataset and answer business questions about sales revenue, products, customers, and order behavior.

The analysis covers monthly revenue, product and category performance, customer spending, average order value (AOV), and data-quality checks.

## Objectives

- Calculate completed sales revenue and order counts.
- Analyze revenue by month and product category.
- Identify top-performing products and highest-spending customers.
- Find customers without orders and products without completed sales.
- Calculate average order value (AOV).
- Identify completed orders with values above the average.
- Check for missing customer information, duplicate order-item IDs, and orders without order items.

## Tools and Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Git and GitHub

## Data Model

The `RetailSalesPractice` database contains four tables:

| Table | Description |
|---|---|
| `Customers` | Customer details, including name and region. |
| `Products` | Product names, categories, and unit prices. |
| `Orders` | Order details, including customer, date, and status. |
| `OrderItems` | Product lines within orders, including quantity and unit price. |

The tables are connected through primary and foreign keys.

## Business Rules and Metric Definitions

- **Revenue:** Calculated at the order-item level as `Quantity * UnitPrice`.
- **Completed Revenue:** Includes only orders with a `Completed` status. Cancelled orders are excluded.
- **Completed Orders:** Each completed order is counted once, regardless of how many product lines it contains.
- **Average Order Value (AOV):** Total completed revenue divided by the number of completed orders. Order-level totals are calculated before averaging.
- **Category Order Counts:** An order can contain products from multiple categories, so category-level order counts may overlap and should not be summed to calculate total distinct orders.

## Key Findings

The following results were obtained by executing the analysis queries against the current dataset. Monetary values are reported in the dataset's unspecified currency.

### Sales Overview

| Metric | Result |
|---|---:|
| Completed orders | 8 |
| Completed revenue | 13,240.00 |
| Average order value | 1,655.00 |
| Cancelled orders | 1 |
| Cancelled order value | 3,500.00 |

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

### Data-Quality Checks

- **Customers without orders:** Nora was identified as having no orders.
- **Missing customer region:** Lina's region is missing.
- **Duplicate order-item IDs:** No duplicate IDs were returned by the query.
- **Orders without order items:** No orders without matching order-item records were found.
- **Products without completed sales:** No products met this condition in the current dataset.
- **Revenue validation:** Completed revenue matched the sum of revenue across product categories, with a difference of 0.00.

## SQL Concepts Demonstrated

- Filtering and aggregation with `WHERE`, `GROUP BY`, and aggregate functions.
- Joining related tables using primary and foreign keys.
- Date-based aggregation using `YEAR`, `MONTH`, and `DATEFROMPARTS`.
- Common Table Expressions (CTEs) for order-level calculations.
- Subqueries and `NOT EXISTS` for identifying missing relationships.
- Conditional analysis of order statuses.
- Data-quality checks and validation queries.

## Limitations

- The dataset is fictional and small; it does not represent actual company performance.
- The analysis measures revenue, not profit. Product costs and operating expenses are unavailable.
- Customer demographics and marketing data are not included.
- The dataset covers only five months, which is insufficient for reliable seasonality analysis.
- Missing customer-region information may limit geographic analysis.
- Findings depend on the documented rule that cancelled orders are excluded from completed revenue.

## Project Structure

```text
retail-sales-sql-analysis/
├── database/
│   └── 01_create_database.sql
├── queries/
│   └── 01_analysis_queries.sql
├── results/
│   └── validated_findings.md
└── README.md
```

## How to Run the Project

1. Open `database/01_create_database.sql` in SQL Server Management Studio.
2. Execute the script to create and populate the `RetailSalesPractice` database.
3. Open `queries/01_analysis_queries.sql`.
4. Execute the analysis queries against the `RetailSalesPractice` database.
5. Compare the query outputs with the findings in this README and [`results/validated_findings.md`](results/validated_findings.md).

**Note:** The database creation script drops and recreates the project tables when rerun. Running it again will reset the data in those tables.

Recheck the findings whenever the underlying data or business rules change.

## Detailed Results

For the metric definitions, validation details, and full findings, see [`results/validated_findings.md`](results/validated_findings.md).

## Conclusion

This project demonstrates how SQL can transform relational retail data into structured business insights. It covers revenue analysis, customer and product performance, order-level calculations, and data-quality validation.

The results provide a foundation for further analysis using tools such as Excel and Power BI. Any business conclusions should account for the dataset's fictional nature and limitations.
