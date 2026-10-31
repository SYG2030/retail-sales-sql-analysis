# Retail Sales SQL Analysis — Validated Findings

## 1. Project Overview

This project uses Microsoft SQL Server and T-SQL to analyze a fictional retail dataset and answer business questions about sales revenue, products, customers, and order behavior.

The analysis focuses on identifying revenue trends, top-performing products, valuable customers, and potential data-quality issues.

## 2. Tools and Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Git and GitHub for version control and project publishing

## 3. Data Model

The `RetailSalesPractice` database contains four tables:

- **Customers:** One row per customer, including customer name and region.
- **Products:** One row per product, including product name and category.
- **Orders:** One row per order, including customer, order date, and order status.
- **OrderItems:** One row per product line within an order, including quantity and unit price.

The tables are connected through primary and foreign keys to support relational analysis.

## 4. Metric Definitions and Business Rules

### Revenue

Line revenue is calculated as:

`Quantity * UnitPrice`

### Completed Revenue

Only orders with a status of `Completed` are included in completed revenue. Cancelled orders are excluded.

### Completed Orders

A completed order is counted once, even if it contains multiple product lines.

### Average Order Value (AOV)

Average Order Value is calculated by dividing total completed-order revenue by the number of completed orders.

Each order's total value is calculated before the average is computed to avoid counting individual product lines as separate orders.

### Revenue Aggregation

Revenue is calculated from order-item records and joined to the relevant order, product, or customer tables as required. Order status is checked consistently when reporting completed sales.

**Currency note:** Monetary values are reported in the dataset's unspecified currency.

## 5. Validated Findings

### 5.1 Completed Sales Overview

The executed SQL query returned the following results:

| Metric | Result |
|---|---:|
| Completed orders | 8 |
| Total completed revenue | 13,240.00 |
| Average order value | 1,655.00 |

These figures represent completed orders only. Cancelled orders are excluded.

### 5.2 Monthly Revenue

| Month | Completed Orders | Revenue |
|---|---:|---:|
| January 2025 | 2 | 4,710.00 |
| February 2025 | 1 | 730.00 |
| March 2025 | 2 | 760.00 |
| April 2025 | 2 | 3,100.00 |
| May 2025 | 1 | 3,940.00 |
| **Total** | **8** | **13,240.00** |

January had the highest monthly revenue among the months shown, followed by May and April.

Revenue varied considerably between months. Since this is a small fictional dataset, the results should not be treated as evidence of a real retail trend.

### 5.3 Top Products by Revenue

The executed query returned the following top three products by completed revenue:

| Rank | Product | Revenue |
|---|---|---:|
| 1 | Laptop | 7,000.00 |
| 2 | Monitor | 2,700.00 |
| 3 | Office Chair | 1,950.00 |

The Laptop generated the highest revenue among the products shown.

These results describe revenue, not profit. Product costs and profit margins are not included in the dataset.

### 5.4 Revenue by Product Category

| Category | Revenue | Units Sold | Orders |
|---|---:|---:|---:|
| Electronics | 9,700.00 | 5 | 4 |
| Furniture | 1,950.00 | 3 | 2 |
| Accessories | 1,590.00 | 12 | 6 |
| **Total** | **13,240.00** | **20** | — |

Electronics generated the highest revenue, while Accessories recorded the highest number of units sold.

The order counts are category-level counts. A single order may contain products from multiple categories, so category order counts should not be added together to estimate the number of distinct orders overall.

### 5.5 Highest-Spending Customers

The executed query returned the following results:

| Customer | Completed Orders | Total Spend |
|---|---:|---:|
| Sara | 3 | 8,330.00 |
| Fahad | 1 | 1,800.00 |
| Ali | 2 | 1,510.00 |
| Omar | 1 | 1,300.00 |
| Lina | 1 | 300.00 |

Sara was the highest-spending customer in the dataset, contributing 8,330.00 in completed revenue
