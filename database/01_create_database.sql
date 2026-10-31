/*
Project: Retail Sales SQL Analysis
Platform: SQL Server / T-SQL
Purpose: Create a small relational dataset for hands-on analysis.
Run this script in SQL Server Management Studio (SSMS) or a compatible SQL Server query window.
*/

IF DB_ID('RetailSalesPractice') IS NULL
    CREATE DATABASE RetailSalesPractice;
GO

USE RetailSalesPractice;
GO

DROP TABLE IF EXISTS dbo.OrderItems;
DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Products;
DROP TABLE IF EXISTS dbo.Customers;
GO

CREATE TABLE dbo.Customers (
    CustomerID INT NOT NULL PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Region NVARCHAR(50) NULL,
    SignupDate DATE NULL
);

CREATE TABLE dbo.Products (
    ProductID INT NOT NULL PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0)
);

CREATE TABLE dbo.Orders (
    OrderID INT NOT NULL PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);

CREATE TABLE dbo.OrderItems (
    OrderItemID INT NOT NULL PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),
    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID) REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID)
);
GO

INSERT INTO dbo.Customers (CustomerID, CustomerName, Region, SignupDate) VALUES
(1, N'Sara', N'East', '2025-01-10'),
(2, N'Ali', N'West', '2025-02-15'),
(3, N'Nora', N'North', '2025-03-20'),
(4, N'Omar', N'East', '2025-04-05'),
(5, N'Lina', NULL, '2025-05-12'),
(6, N'Fahad', N'West', '2025-06-01');

INSERT INTO dbo.Products (ProductID, ProductName, Category, UnitPrice) VALUES
(101, N'Laptop', N'Electronics', 3500.00),
(102, N'Mouse', N'Accessories', 80.00),
(103, N'Keyboard', N'Accessories', 150.00),
(104, N'Monitor', N'Electronics', 900.00),
(105, N'Office Chair', N'Furniture', 650.00),
(106, N'Webcam', N'Accessories', 220.00);

INSERT INTO dbo.Orders (OrderID, CustomerID, OrderDate, Status) VALUES
(1001, 1, '2025-01-12', N'Completed'),
(1002, 2, '2025-01-18', N'Completed'),
(1003, 1, '2025-02-03', N'Completed'),
(1004, 4, '2025-02-17', N'Cancelled'),
(1005, 5, '2025-03-09', N'Completed'),
(1006, 2, '2025-03-25', N'Completed'),
(1007, 6, '2025-04-02', N'Completed'),
(1008, 4, '2025-04-21', N'Completed'),
(1009, 1, '2025-05-05', N'Completed');

INSERT INTO dbo.OrderItems (OrderItemID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1001, 101, 1, 3500.00),
(2, 1001, 102, 2, 80.00),
(3, 1002, 104, 1, 900.00),
(4, 1002, 103, 1, 150.00),
(5, 1003, 105, 1, 650.00),
(6, 1003, 102, 1, 80.00),
(7, 1004, 101, 1, 3500.00),
(8, 1005, 103, 2, 150.00),
(9, 1006, 106, 1, 220.00),
(10, 1006, 102, 3, 80.00),
(11, 1007, 104, 2, 900.00),
(12, 1008, 105, 2, 650.00),
(13, 1009, 101, 1, 3500.00),
(14, 1009, 106, 2, 220.00);
GO

-- Sanity checks: inspect each table before writing analysis queries.
SELECT * FROM dbo.Customers ORDER BY CustomerID;
SELECT * FROM dbo.Products ORDER BY ProductID;
SELECT * FROM dbo.Orders ORDER BY OrderID;
SELECT * FROM dbo.OrderItems ORDER BY OrderItemID;
GO
