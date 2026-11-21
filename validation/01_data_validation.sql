
USE RetailSalesPractice;
GO

-- =============================================
-- V01: Revenue Reconciliation
-- Validate completed revenue against monthly revenue.
-- =============================================

WITH TotalRevenue AS (
    SELECT
        SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
),
MonthlyRevenue AS (
    SELECT
        DATEFROMPARTS(
            YEAR(o.OrderDate),
            MONTH(o.OrderDate),
            1
        ) AS RevenueMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS MonthlyRevenue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
),
MonthlyTotal AS (
    SELECT
        SUM(MonthlyRevenue) AS TotalMonthlyRevenue
    FROM MonthlyRevenue
)
SELECT
    t.TotalRevenue,
    m.TotalMonthlyRevenue,
    t.TotalRevenue - m.TotalMonthlyRevenue AS Difference,
    CASE
        WHEN t.TotalRevenue = m.TotalMonthlyRevenue
            THEN 'PASS'
        ELSE 'FAIL'
    END AS ValidationStatus
FROM TotalRevenue AS t
CROSS JOIN MonthlyTotal AS m;
GO


-- =============================================
-- V02: Order-Level Revenue Validation
-- Display revenue for each completed order.
-- =============================================

WITH OrderTotals AS (
    SELECT
        o.OrderID,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderRevenue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY o.OrderID
)
SELECT
    OrderID,
    OrderRevenue,
    COUNT(*) OVER () AS ValidatedOrders,
    SUM(OrderRevenue) OVER () AS TotalOrderRevenue,
    CASE
        WHEN COUNT(*) OVER () = 8
         AND SUM(OrderRevenue) OVER () = 13240.00
            THEN 'PASS'
        ELSE 'FAIL'
    END AS ValidationStatus
FROM OrderTotals
ORDER BY OrderID;
GO


-- =============================================
-- V03: Average Order Value (AOV) Verification
-- =============================================

WITH OrderTotals AS (
    SELECT
        o.OrderID,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderValue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY o.OrderID
),
AOVCalculation AS (
    SELECT
        COUNT(*) AS CompletedOrders,
        SUM(OrderValue) AS TotalRevenue,
        AVG(OrderValue) AS CalculatedAOV
    FROM OrderTotals
)
SELECT
    CompletedOrders,
    TotalRevenue,
    CAST(CalculatedAOV AS DECIMAL(12, 2)) AS CalculatedAOV,
    CASE
        WHEN CompletedOrders = 8
         AND TotalRevenue = 13240.00
         AND CAST(CalculatedAOV AS DECIMAL(12, 2)) = 1655.00
            THEN 'PASS'
        ELSE 'FAIL'
    END AS ValidationStatus
FROM AOVCalculation;
GO


-- =============================================
-- V04: Cancelled Orders Exclusion
-- Compare revenue across order statuses.
-- =============================================

WITH RevenueByStatus AS (
    SELECT
        o.Status,
        SUM(oi.Quantity * oi.UnitPrice) AS StatusRevenue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    GROUP BY o.Status
),
RevenueSummary AS (
    SELECT
        SUM(StatusRevenue) AS AllRevenue,
        SUM(
            CASE
                WHEN Status = 'Completed'
                THEN StatusRevenue
                ELSE 0
            END
        ) AS CompletedRevenue,
        SUM(
            CASE
                WHEN Status = 'Cancelled'
                THEN StatusRevenue
                ELSE 0
            END
        ) AS CancelledRevenue
    FROM RevenueByStatus
)
SELECT
    AllRevenue,
    CompletedRevenue,
    CancelledRevenue,
    CASE
        WHEN AllRevenue = 16740.00
         AND CompletedRevenue = 13240.00
         AND CancelledRevenue = 3500.00
            THEN 'PASS'
        ELSE 'FAIL'
    END AS ValidationStatus
FROM RevenueSummary;
GO


-- =============================================
-- V05: Referential Integrity Validation
-- Check for orphan records in related tables.
-- =============================================

SELECT
    'Orders without Customers' AS ValidationCheck,
    COUNT(*) AS IssueCount
FROM dbo.Orders AS o
LEFT JOIN dbo.Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL

UNION ALL

SELECT
    'OrderItems without Orders',
    COUNT(*)
FROM dbo.OrderItems AS oi
LEFT JOIN dbo.Orders AS o
    ON oi.OrderID = o.OrderID
WHERE o.OrderID IS NULL

UNION ALL

SELECT
    'OrderItems without Products',
    COUNT(*)
FROM dbo.OrderItems AS oi
LEFT JOIN dbo.Products AS p
    ON oi.ProductID = p.ProductID
WHERE p.ProductID IS NULL;
GO


-- =============================================
-- V06: Data Quality Checks
-- =============================================

-- Check 1: Customers with missing region

SELECT
    'Customers with Missing Region' AS ValidationCheck,
    COUNT(*) AS IssueCount
FROM dbo.Customers
WHERE Region IS NULL

UNION ALL

-- Check 2: Orders without order items

SELECT
    'Orders without Order Items',
    COUNT(*)
FROM dbo.Orders AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.OrderItems AS oi
    WHERE oi.OrderID = o.OrderID
)

UNION ALL

-- Check 3: Products without completed sales

SELECT
    'Products without Completed Sales',
    COUNT(*)
FROM dbo.Products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.OrderItems AS oi
    INNER JOIN dbo.Orders AS o
        ON oi.OrderID = o.OrderID
    WHERE oi.ProductID = p.ProductID
      AND o.Status = 'Completed'
)

UNION ALL

-- Check 4: Order items with missing values

SELECT
    'Order Items with Missing Values',
    COUNT(*)
FROM dbo.OrderItems
WHERE OrderID IS NULL
   OR ProductID IS NULL
   OR Quantity IS NULL
   OR UnitPrice IS NULL;
GO
