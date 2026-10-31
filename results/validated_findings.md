\# Retail Sales SQL Analysis — Validated Findings



\## 1. Project Overview



This project uses Microsoft SQL Server and T-SQL to analyze a fictional retail dataset and answer business questions about sales revenue, products, customers, and order behavior.



The analysis focuses on identifying revenue trends, top-performing products, valuable customers, and potential data-quality issues.



\## 2. Tools and Technologies



\- Microsoft SQL Server

\- SQL Server Management Studio (SSMS)

\- T-SQL

\- Git and GitHub (planned for project publishing)



\## 3. Data Model



The database contains four tables:



\- \*\*Customers:\*\* One row per customer, including customer name and region.

\- \*\*Products:\*\* One row per product, including product name and category.

\- \*\*Orders:\*\* One row per order, including customer, order date, and order status.

\- \*\*OrderItems:\*\* One row per product line within an order, including quantity and unit price.



The tables are connected through primary and foreign keys to support relational analysis.



\## 4. Metric Definitions and Business Rules



\### Revenue



Line revenue is calculated as:



`Quantity \* UnitPrice`



\### Completed Revenue



Only orders with a status of `Completed` are included in completed revenue. Cancelled orders are excluded.



\### Completed Orders



A completed order is counted once, even if it contains multiple product lines.



\### Average Order Value (AOV)



Average Order Value is calculated by dividing total completed-order revenue by the number of completed orders.



Each order's total value is calculated before the average is computed to avoid counting individual product lines as separate orders.



\### Revenue Aggregation



Revenue is calculated from order-item records and joined to the relevant order, product, or customer tables as required. Order status is checked consistently when reporting completed sales.



\## 5. Validated Findings



\### 5.1 Completed Sales Overview



The executed SQL query returned the following results:



| Metric | Result |

|---|---:|

| Completed orders | 8 |

| Total completed revenue | 13,240.00 |

| Average order value | 1,655.00 |



These figures represent completed orders only. Cancelled orders are excluded.



\### 5.2 Monthly Revenue



| Month | Completed Orders | Revenue |

|---|---:|---:|

| January 2025 | 2 | 4,710.00 |

| February 2025 | 1 | 730.00 |

| March 2025 | 2 | 760.00 |

| April 2025 | 2 | 3,100.00 |

| May 2025 | 1 | 3,940.00 |

| \*\*Total\*\* | \*\*8\*\* | \*\*13,240.00\*\* |



January had the highest monthly revenue among the months shown, followed by May and April.



Revenue varied considerably between months. Since this is a small fictional dataset, the results should not be treated as evidence of a real retail trend.



\### 5.3 Top Products by Revenue



The executed query returned the following top three products by completed revenue:



| Rank | Product | Revenue |

|---|---|---:|

| 1 | Laptop | 7,000.00 |

| 2 | Monitor | 2,700.00 |

| 3 | Office Chair | 1,950.00 |



The Laptop generated the highest revenue among the products shown.



These results describe revenue, not profit. Product costs and profit margins are not included in the dataset.



\### 5.4 Revenue by Product Category



| Category | Revenue | Units Sold | Orders |

|---|---:|---:|---:|

| Electronics | 9,700.00 | 5 | 4 |

| Furniture | 1,950.00 | 3 | 2 |

| Accessories | 1,590.00 | 12 | 6 |

| \*\*Total\*\* | \*\*13,240.00\*\* | \*\*20\*\* | — |



Electronics generated the highest revenue, while Accessories recorded the highest number of units sold.



The order counts are category-level counts. A single order may contain products from multiple categories, so category order counts should not be added together to estimate the number of distinct orders overall.



\### 5.5 Highest-Spending Customers



The executed query returned the following results:



| Customer | Completed Orders | Total Spend |

|---|---:|---:|

| Sara | 3 | 8,330.00 |

| Fahad | 1 | 1,800.00 |

| Ali | 2 | 1,510.00 |

| Omar | 1 | 1,300.00 |

| Lina | 1 | 300.00 |



Sara was the highest-spending customer in the dataset, contributing 8,330.00 in completed revenue.



Customer spending is calculated from completed orders only.



\### 5.6 Customers Without Orders



The query identified the following customer without any orders:



| Customer ID | Customer Name |

|---|---|

| 3 | Nora |



The `NOT EXISTS` subquery was used to identify customers without matching orders.



\### 5.7 Average Order Value



| Metric | Result |

|---|---:|

| Completed orders | 8 |

| Total completed revenue | 13,240.00 |

| Average order value | 1,655.00 |



The average was calculated from order-level totals rather than individual order-item rows.



\### 5.8 Products Without Completed Sales



The query returned no rows when searching for products without sales from completed orders.



This means every product in the current dataset had at least one sale associated with a completed order. Products appearing only in cancelled orders would still be identified by this check if they had no completed sales.



\### 5.9 Orders Above Average Order Value



The query identified these completed orders with a value above the average order value of 1,655.00:



| Order ID | Order Value |

|---|---:|

| 1009 | 3,940.00 |

| 1001 | 3,660.00 |

| 1007 | 1,800.00 |



These orders contributed more revenue per order than the dataset's average completed order.



\### 5.10 Data-Quality Checks



The following checks were executed:



| Check | Result | Interpretation |

|---|---|---|

| Customers with missing region | 1 customer: Lina | Region information is incomplete for one record. |

| Duplicate order-item IDs | No rows returned | No duplicate IDs were found by this query. |

| Orders without order items | No rows returned | Every order currently has at least one matching order-item record. |

| Revenue by order status | Completed: 8 orders, 13,240.00; Cancelled: 1 order, 3,500.00 | Cancelled revenue is kept separate from completed revenue. |



The duplicate-ID query returned no matches. Since `OrderItemID` is expected to be a primary key, the database constraint should also prevent duplicate values.



The missing region should be investigated before using customer-region analysis for business decisions. A missing value should not automatically be replaced with an assumed region.



\## 6. SQL Concepts Demonstrated



This project demonstrates practical use of:



\- `SELECT` and column aliases

\- `WHERE` filtering

\- Aggregate functions such as `SUM`, `COUNT`, and `AVG`

\- `GROUP BY` and `ORDER BY`

\- `INNER JOIN` and `LEFT JOIN`

\- `HAVING`

\- Common table expressions (CTEs)

\- Subqueries

\- `DATEFROMPARTS`, `YEAR`, and `MONTH`

\- `TOP`

\- `IS NULL`

\- Data-quality checks

\- Revenue calculations and order-level aggregation



\## 7. Limitations



\- The dataset is fictional and small; it does not represent actual company performance.

\- The analysis measures revenue, not profit, because product costs and operating expenses are unavailable.

\- No customer demographics or marketing data are available to explain customer behavior.

\- The dataset covers only a short period, so it is insufficient for reliable seasonality analysis.

\- A missing customer region may limit geographic comparisons.

\- Revenue findings depend on the documented rule that cancelled orders are excluded from completed revenue.



\## 8. Conclusion



The SQL analysis identified the main revenue contributors, summarized monthly performance, ranked products and customers, and checked for selected data-quality issues.



The most notable findings were that Electronics generated the highest category revenue, the Laptop was the top product by revenue, and Sara was the highest-spending customer. The analysis also identified one customer with a missing region and one customer without orders.



These results demonstrate how SQL can transform relational data into structured business information. Any recommendations based on this analysis should account for the dataset's fictional nature and limitations.



\## 9. Reproducibility



The results were obtained by executing queries against the `RetailSalesPractice` database in SQL Server Management Studio (SSMS).



To reproduce the analysis:



1\. Run `database/01\_create\_database.sql` to create and populate the practice database.

2\. Open `queries/01\_analysis\_queries.sql` in SSMS.

3\. Select the `RetailSalesPractice` database and execute the queries.

4\. Compare the returned results with the findings documented above.

5\. Revalidate the results if the dataset or business rules change.



Only results that have been executed and validated should be presented as findings.

