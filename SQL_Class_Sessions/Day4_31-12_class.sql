CREATE DATABASE DEMODB;
USE DEMODB;

CREATE TABLE Employee
(
 Id INT,
 Name VARCHAR(50),
 Salary INT,
 Gender VARCHAR(10),
 City VARCHAR(50),
 Dept VARCHAR(50)
)
GO
INSERT INTO Employee VALUES (3,'Pranaya', 4500, 'Male', 'New York', 'IT')
INSERT INTO Employee VALUES (1,'Anurag', 2500, 'Male', 'London', 'IT')
INSERT INTO Employee VALUES (4,'Priyanka', 5500, 'Female', 'Tokiyo', 'HR')
INSERT INTO Employee VALUES (5,'Sambit', 3000, 'Male', 'Toronto', 'IT')
INSERT INTO Employee VALUES (7,'Preety', 6500, 'Female', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (6,'Tarun', 4000, 'Male', 'Delhi', 'IT')
INSERT INTO Employee VALUES (2,'Hina', 500, 'Female', 'Sydney', 'HR')
INSERT INTO Employee VALUES (8,'John', 6500, 'Male', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (10,'Pam', 4000, 'Female', 'Delhi', 'IT')
INSERT INTO Employee VALUES (9,'Sara', 500, 'Female', 'London', 'IT')

Select * from Employee where Id=8;

CREATE CLUSTERED INDEX IX_Employee_ID ON Employee(Id ASC);

