
USE RetailSalesPractice;
GO

-- Revenue is calculated as Quantity * UnitPrice.
-- Completed revenue excludes cancelled orders.

-- Task 1: Total revenue and completed orders

SELECT
    COUNT(DISTINCT o.OrderID) AS CompletedOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM dbo.Orders AS o
INNER JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.Status = 'Completed';
GO


-- Task 2: Monthly revenue

SELECT
    DATEFROMPARTS(
        YEAR(o.OrderDate),
        MONTH(o.OrderDate),
        1
    ) AS RevenueMonth,
    COUNT(DISTINCT o.OrderID) AS CompletedOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM dbo.Orders AS o
INNER JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.Status = 'Completed'
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY RevenueMonth;
GO


-- Task 3: Top 3 products by revenue

SELECT TOP (3)
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Orders AS o
    ON oi.OrderID = o.OrderID
INNER JOIN dbo.Products AS p
    ON oi.ProductID = p.ProductID
WHERE o.Status = 'Completed'
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY
    TotalRevenue DESC,
    p.ProductName ASC;
GO


-- Task 4: Revenue by category

SELECT
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue,
    SUM(oi.Quantity) AS UnitsSold,
    COUNT(DISTINCT o.OrderID) AS OrdersCount
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Orders AS o
    ON oi.OrderID = o.OrderID
INNER JOIN dbo.Products AS p
    ON oi.ProductID = p.ProductID
WHERE o.Status = 'Completed'
GROUP BY p.Category
ORDER BY TotalRevenue DESC;
GO


-- Task 5: Customer spending

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT o.OrderID) AS CompletedOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.Status = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    TotalSpent DESC,
    c.CustomerName ASC;
GO


-- Task 6: Customers without orders

SELECT
    c.CustomerID,
    c.CustomerName
FROM dbo.Customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Orders AS o
    WHERE o.CustomerID = c.CustomerID
)
ORDER BY c.CustomerID;
GO


-- Task 7: Average order value (AOV)

;WITH OrderTotals AS (
    SELECT
        o.OrderID,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderValue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY o.OrderID
)
SELECT
    COUNT(*) AS CompletedOrders,
    SUM(OrderValue) AS TotalRevenue,
    CAST(AVG(OrderValue) AS DECIMAL(12, 2)) AS AverageOrderValue
FROM OrderTotals;
GO


-- Task 8: Products without completed sales

SELECT
    p.ProductID,
    p.ProductName,
    p.Category
FROM dbo.Products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.OrderItems AS oi
    INNER JOIN dbo.Orders AS o
        ON oi.OrderID = o.OrderID
    WHERE oi.ProductID = p.ProductID
      AND o.Status = 'Completed'
)
ORDER BY p.ProductID;
GO


-- Task 9: Orders above average order value

;WITH OrderTotals AS (
    SELECT
        o.OrderID,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderValue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
    GROUP BY o.OrderID
)
SELECT
    OrderID,
    OrderValue
FROM OrderTotals
WHERE OrderValue > (
    SELECT AVG(OrderValue)
    FROM OrderTotals
)
ORDER BY
    OrderValue DESC,
    OrderID ASC;
GO


-- Task 10A: Customers with missing region

SELECT
    CustomerID,
    CustomerName,
    Region
FROM dbo.Customers
WHERE Region IS NULL;
GO


-- Task 10B: Duplicate order item IDs

SELECT
    OrderItemID,
    COUNT(*) AS DuplicateCount
FROM dbo.OrderItems
GROUP BY OrderItemID
HAVING COUNT(*) > 1;
GO


-- Task 10C: Orders without order items

SELECT
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.Status
FROM dbo.Orders AS o
LEFT JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE oi.OrderID IS NULL
ORDER BY o.OrderID;
GO


-- Task 10D: Revenue by order status

SELECT
    o.Status,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderValue
FROM dbo.Orders AS o
INNER JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
GROUP BY o.Status
ORDER BY TotalOrderValue DESC;
GO


-- Revenue check

SELECT
    COUNT(DISTINCT o.OrderID) AS CompletedOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS CompletedRevenue
FROM dbo.Orders AS o
INNER JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.Status = 'Completed';
GO


-- Revenue by category check

SELECT
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Orders AS o
    ON oi.OrderID = o.OrderID
INNER JOIN dbo.Products AS p
    ON oi.ProductID = p.ProductID
WHERE o.Status = 'Completed'
GROUP BY p.Category
ORDER BY TotalRevenue DESC;
GO


-- Compare total revenue with category revenue

;WITH TotalSales AS (
    SELECT
        SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
    FROM dbo.Orders AS o
    INNER JOIN dbo.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.Status = 'Completed'
),
CategorySales AS (
    SELECT
        SUM(oi.Quantity * oi.UnitPrice) AS CategoryRevenue
    FROM dbo.OrderItems AS oi
    INNER JOIN dbo.Orders AS o
        ON oi.OrderID = o.OrderID
    INNER JOIN dbo.Products AS p
        ON oi.ProductID = p.ProductID
    WHERE o.Status = 'Completed'
)
SELECT
    t.TotalRevenue,
    c.CategoryRevenue,
    t.TotalRevenue - c.CategoryRevenue AS Difference
FROM TotalSales AS t
CROSS JOIN CategorySales AS c;
GO
