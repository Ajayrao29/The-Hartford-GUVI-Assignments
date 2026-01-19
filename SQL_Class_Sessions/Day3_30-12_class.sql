--SUBQUERIES, SET OPERATIONS----

CREATE DATABASE CP;
USE CP;

------------------------CASE…ELSE in SQL Server------------------------------------------

CREATE TABLE Customer
(
CustomerID INT,
CustomerName VARCHAR(50),
City VARCHAR(30)
);
CREATE TABLE Product
(
ProductID INT,
ProductName VARCHAR(50),
Price INT
);
CREATE TABLE Orders
(
OrderID INT,
CustomerID INT,
ProductID INT,
Quantity INT
);

INSERT INTO Customer VALUES
(1, 'Amit', 'Delhi'),
(2, 'Neha', 'Mumbai'),
(3, 'Rohit', 'Pune'),
(4, 'Karan', 'Delhi');
INSERT INTO Product VALUES
(101, 'Laptop', 40000),
(102, 'Mobile', 15000),
(103, 'Headphones', 3000),
(104, 'Keyboard', 2000);
INSERT INTO Orders VALUES
(1, 1, 103, 2),
(2, 1, 104, 1),
(3, 2, 102, 1),
(4, 2, 103, 2),
(5, 3, 104, 2),
(6, 4, 101, 1);

--Calculate Total Purchase per Customer
SELECT
c.CustomerID,
c.CustomerName,
SUM(p.Price * o.Quantity) AS TotalPurchase
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Product p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName;

--CASE…ELSE to Categorize Customers
SELECT
c.CustomerID,
c.CustomerName,
SUM(p.Price * o.Quantity) AS TotalPurchase,
CASE
WHEN SUM(p.Price * o.Quantity) < 10000 THEN 'Regular'
WHEN SUM(p.Price * o.Quantity) BETWEEN 10000 AND 25000 THEN 'Silver'
ELSE 'Gold'
END AS CustomerCategory
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Product p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName;

--CASE with ELSE in ORDER BY (Customer Priority)
SELECT
c.CustomerName,
SUM(p.Price * o.Quantity) AS TotalPurchase
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Product p ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY
CASE
WHEN SUM(p.Price * o.Quantity) > 25000 THEN 1
WHEN SUM(p.Price * o.Quantity) BETWEEN 10000 AND 25000 THEN 2
ELSE 3
END;

---------------------------------Merge In SQL Server------------------------------------

CREATE TABLE Customer_Master
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(50),
City VARCHAR(30)
);
CREATE TABLE Customer_Staging
(
CustomerID INT,
CustomerName VARCHAR(50),
City VARCHAR(30)
);

INSERT INTO Customer_Master VALUES
(1, 'Ravi Kumar', 'Delhi'),
(2, 'Sonia Gupta', 'Mumbai'),
(3, 'Arjun Singh', 'Chennai');
INSERT INTO Customer_Staging VALUES
(2, 'Sonia Gupta', 'Pune'), -- City changed
(3, 'Arjun Singh', 'Chennai'),
(4, 'Meenal Shah', 'Ahmedabad'); -- New customer

select * from customer_master;
select * from customer_staging;

--using Merge to update master table.
MERGE Customer_Master AS T
USING Customer_Staging AS S
ON T.CustomerID = S.CustomerID
WHEN MATCHED THEN
UPDATE SET
T.CustomerName = S.CustomerName,
T.City = S.City
WHEN NOT MATCHED BY TARGET THEN
INSERT (CustomerID, CustomerName, City)
VALUES (S.CustomerID, S.CustomerName, S.City)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

--Resultant Table Data
select * from customer_master;
select * from customer_staging;

------------------------------------ROLLUP in SQL Server----------------------------------

CREATE TABLE Sales
(
CustomerName VARCHAR(30),
ProductName VARCHAR(30),
Amount INT
);
INSERT INTO Sales VALUES
('Ravi', 'Laptop', 50000),
('Ravi', 'Mouse', 2000),
('Ravi', 'Keyboard',3000),
('Neha', 'Laptop', 52000),
('Neha', 'Mouse', 2500),
('Amit', 'Laptop', 48000);

--ROLLUP on Customer and Product
SELECT
CustomerName,
ProductName,
SUM(Amount) AS TotalAmount
FROM Sales
GROUP BY ROLLUP (CustomerName, ProductName)
ORDER BY CustomerName, ProductName;

--ROLLUP with GROUPING() (Readable Report)
SELECT
CASE
WHEN GROUPING(CustomerName) = 1 THEN 'All Customers'
ELSE CustomerName
END AS Customer,
CASE
WHEN GROUPING(ProductName) = 1 THEN 'All Products'
ELSE ProductName
END AS Product,
SUM(Amount) AS TotalAmount
FROM Sales
GROUP BY ROLLUP (CustomerName, ProductName)
ORDER BY GROUPING(CustomerName), CustomerName;

--------------------------------------CUBE in SQL Server----------------------------------

--CUBE on Sales

SELECT
CustomerName,
ProductName,
SUM(Amount) AS TotalAmount
FROM Sales
GROUP BY CUBE (CustomerName, ProductName)
ORDER BY CustomerName, ProductName;

--CUBE with GROUPING() for Clear Labels
SELECT
CASE
WHEN GROUPING(CustomerName) = 1 THEN 'All Customers'
ELSE CustomerName
END AS Customer,
CASE
WHEN GROUPING(ProductName) = 1 THEN 'All Products'
ELSE ProductName
END AS Product,
SUM(Amount) AS TotalAmount
FROM Sales
GROUP BY CUBE (CustomerName, ProductName)
ORDER BY GROUPING(CustomerName), GROUPING(ProductName), Customer;

---------------------------------GROUPING SETS in SQL Server-------------------------------

--Customer-wise and Product-wise Totals (No Detail Rows)

SELECT
CustomerName,
ProductName,
SUM(Amount) AS TotalAmount
FROM Sales
GROUP BY GROUPING SETS
(
(CustomerName),
(ProductName)
)
ORDER BY CustomerName, ProductName;

--Detail Rows + Customer Totals + Grand Total
SELECT
CASE
WHEN GROUPING(CustomerName) = 1 THEN 'All Customers'
ELSE CustomerName
END AS Customer,
CASE
WHEN GROUPING(ProductName) = 1 THEN 'All Products'
ELSE ProductName
END AS Product,
SUM(Amount) AS TotalAmount
FROM Sales
GROUP BY GROUPING SETS
(
(CustomerName, ProductName),
(CustomerName),
()
)
ORDER BY GROUPING(CustomerName), Customer;