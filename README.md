\# Retail Sales SQL Analysis



\## Project Overview



This project uses Microsoft SQL Server and T-SQL to analyze a fictional retail dataset and answer business questions about sales revenue, products, customers, and order behavior.



The analysis covers monthly revenue, product and category performance, customer spending, average order value, and selected data-quality checks.



\## Objectives



\- Calculate completed sales revenue and order counts.

\- Analyze revenue by month and product category.

\- Identify top-performing products and highest-spending customers.

\- Find customers without orders and products without completed sales.

\- Calculate average order value (AOV).

\- Identify completed orders with values above the average.

\- Check for missing customer information, duplicate order-item IDs, and orders without order items.



\## Tools and Technologies



\- Microsoft SQL Server

\- SQL Server Management Studio (SSMS)

\- T-SQL



\## Data Model



The database, `RetailSalesPractice`, contains four tables:



| Table | Description |

|---|---|

| `Customers` | One row per customer, including name and region. |

| `Products` | One row per product, including name and category. |

| `Orders` | One row per order, including customer, date, and status. |

| `OrderItems` | One row per product line within an order, including quantity and unit price. |



The tables are related through primary and foreign keys.



\## Business Rules and Metric Definitions



\### Revenue



Line revenue is calculated as:



`Quantity \* UnitPrice`



\### Completed Revenue



Only orders with a status of `Completed` are included in completed revenue. Cancelled orders are excluded.



\### Completed Orders



Each completed order is counted once, regardless of how many product lines it contains.



\### Average Order Value (AOV)



AOV is calculated by dividing total completed revenue by the number of completed orders. Order-level totals are calculated before taking the average to avoid counting individual product lines as separate orders.



\### Category Order Counts



An order may contain products from more than one category. Therefore, category-level order counts are not additive and should not be summed to calculate the overall number of distinct orders.



\## Key Findings



The following results were obtained by executing the analysis queries against the current dataset.



\### Sales Overview



| Metric | Result |

|---|---:|

| Completed orders | 8 |

| Completed revenue | 13,240.00 |

| Average order value | 1,655.00 |

| Cancelled orders | 1 |

| Cancelled order value | 3,500.00 |



Cancelled order value is reported separately and is excluded from completed revenue.



\### Monthly Revenue



| Month | Completed Orders | Revenue |

|---|---:|---:|

| January 2025 | 2 | 4,710.00 |

| February 2025 | 1 | 730.00 |

| March 2025 | 2 | 760.00 |

| April 2025 | 2 | 3,100.00 |

| May 2025 | 1 | 3,940.00 |



January recorded the highest monthly revenue in the dataset.



\### Top Three Products by Revenue



| Product | Revenue |

|---|---:|

| Laptop | 7,000.00 |

| Monitor | 2,700.00 |

| Office Chair | 1,950.00 |



The Laptop generated the highest revenue among the products analyzed.



\### Revenue by Category



| Category | Revenue | Units Sold |

|---|---:|---:|

| Electronics | 9,700.00 | 5 |

| Furniture | 1,950.00 | 3 |

| Accessories | 1,590.00 | 12 |

| \*\*Total\*\* | \*\*13,240.00\*\* | \*\*20\*\* |



Electronics generated the highest revenue, while Accessories recorded the highest number of units sold.



\### Customer Spending



| Customer | Completed Orders | Total Spend |

|---|---:|---:|

| Sara | 3 | 8,330.00 |

| Fahad | 1 | 1,800.00 |

| Ali | 2 | 1,510.00 |

| Omar | 1 | 1,300.00 |

| Lina | 1 | 300.00 |



Sara was the highest-spending customer in the dataset.



\### Orders Above Average Order Value



Three completed orders exceeded the average order value of 1,655.00:



| Order ID | Order Value |

|---|---:|

| 1009 | 3,940.00 |

| 1001 | 3,660.00 |

| 1007 | 1,800.00 |



\### Data-Quality Checks



\- \*\*Customers without orders:\*\* Nora was identified as having no orders.

\- \*\*Missing customer region:\*\* Lina's region is missing.

\- \*\*Duplicate order-item IDs:\*\* No duplicate IDs were returned by the query.

\- \*\*Orders without order items:\*\* No orders without matching order-item records were found.

\- \*\*Products without completed sales:\*\* No products met this condition in the current dataset.

\- \*\*Revenue validation:\*\* Completed revenue matched the sum of revenue across product categories, with a difference of 0.00.



\## Limitations



\- The dataset is fictional and small; it does not represent actual company performance.

\- The analysis measures revenue, not profit. Product costs and operating expenses are unavailable.

\- Customer demographics and marketing data are not included.

\- The dataset covers only five months, which is insufficient for reliable seasonality analysis.

\- Missing customer-region information may limit geographic analysis.

\- Findings depend on the documented rule that cancelled orders are excluded from completed revenue.



\## Project Structure



```text

retail\_sales\_analysis/

├── database/

│   └── 01\_create\_database.sql

├── docs/

│   └── README.md

├── queries/

│   └── 01\_analysis\_queries.sql

└── results/

&#x20;   └── validated\_findings.md

```



\## How to Run the Project



1\. Open `database/01\_create\_database.sql` in SQL Server Management Studio.

2\. Execute the script to create and populate the `RetailSalesPractice` database.

3\. Open `queries/01\_analysis\_queries.sql`.

4\. Select the `RetailSalesPractice` database and execute the queries.

5\. Compare the results with the findings documented in this README and `results/validated\_findings.md`.



Recheck the findings whenever the underlying data or business rules change.



\## Conclusion



This project demonstrates the use of SQL to transform relational retail data into structured business information. It covers revenue analysis, customer and product performance, order-level calculations, and selected data-quality checks.



The results provide a foundation for further analysis using Excel and Power BI. Any business conclusions should account for the dataset's fictional nature and limitations.

