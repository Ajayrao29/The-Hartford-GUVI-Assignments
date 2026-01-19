Day 2 - SQL Training - Insurance Database

CREATE DATABASE INSDB;
USE INSDB;

CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Policies (
    PolicyID INT IDENTITY PRIMARY KEY,
    PolicyName VARCHAR(50),
    PolicyType VARCHAR(50),
    PremiumAmount INT,
    DurationYears INT
);

CREATE TABLE PolicyAssignments (
    AssignmentID  INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    PolicyID INT,
    AgentID VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID)
);

CREATE TABLE Claims (
    ClaimID INT IDENTITY PRIMARY KEY,
    AssignmentID INT,
    ClaimDate DATE,
    ClaimAmount INT,
    ClaimStatus VARCHAR(50),
    FOREIGN KEY (AssignmentID) REFERENCES PolicyAssignments(AssignmentID)
);

CREATE TABLE Agents (
AgentID INT IDENTITY PRIMARY KEY,
AgentName VARCHAR(50),
Phone VARCHAR(15),
City Varchar(50),
);

ALTER TABLE PolicyAssignments
ALTER COLUMN AgentID INT;


INSERT INTO Customers 
VALUES 
('Ajay', 'Rao', '2005-01-29', '6305284031', 'ajayrao1294@gmail.com');
INSERT INTO Customers 
VALUES 
('Ravi', 'Kumar', '1999-05-15', '9876543210', 'ravikumar@gmail.com');

INSERT INTO Policies
VALUES
('Health Plus', 'Health', 12000, 5),
('Life Secure', 'Life', 15000, 10);
INSERT INTO Policies
VALUES
('Star Plus', 'Health', 16000, 1);

INSERT INTO PolicyAssignments
VALUES
(1, 1, 'AGT101', '2024-01-01', '2029-01-01'),
(2, 2, 'AGT102', '2023-06-01', '2033-06-01');

Update PolicyAssignments set AgentID=1 WHERE AssignmentID=1;
Update PolicyAssignments set AgentID=2 WHERE AssignmentID=2;

INSERT INTO Claims
VALUES
(1, '2024-06-15', 50000, 'Approved'),
(2, '2024-08-10', 100000, 'Pending');
INSERT INTO Claims
VALUES
(2, '2024-05-05', 50000, 'Rejected');



INSERT INTO Agents VALUES ('Ramesh','9876543210','Chennai'),
('Suresh','9123456780','Hyderabad');
INSERT INTO Agents VALUES ('Raju','9989723210','Banglore');

ALTER TABLE PolicyAssignments
ALTER COLUMN AgentID INT;

ALTER TABLE PolicyAssignments
ADD CONSTRAINT FK_PolicyAssignments_Agents
FOREIGN KEY (AgentID)
REFERENCES Agents(AgentID);



--Assignment

Select * from Customers;
Select CustomerID, PolicyID, StartDate, EndDate from PolicyAssignments;
Select * From Policies WHERE PolicyType='Health';
Select * from Policies Where PremiumAmount>10000 and DurationYears=1;
Select DISTINCT City from Agents;
Select * From Policies WHERE PolicyType= 'Health' OR PolicyType='Life' OR PolicyType='Motor';
Select * From Policies WHERE PolicyType IN( 'Health','Life','Motor');
Select * from Customers where DateOfBirth > '2001-01-01'and DateOfBirth < '2020-12-31';
Select * from Claims where ClaimStatus='Rejected';
Select * from Agents where City LIKE '_A%';
Select Max(ClaimAmount) as HighestCA, Min(ClaimAmount) as LowestCA from Claims;
Select TOP 1 * From Claims ORDER BY ClaimDate DESC;
UPDATE Policies Set PremiumAmount=PremiumAmount*1.10;
DELETE FROM PolicyAssignments WHERE EndDate < GETDATE();
Select Count(*) from Claims where ClaimStatus='Rejected';
SELECT PolicyID,PolicyName,PremiumAmount,PremiumAmount * 0.06 AS LocalTaxes,PremiumAmount + (PremiumAmount * 0.06) AS PremiumAmountWithTax,
PremiumAmount/12.0 AS MonthlyPremiumAmount FROM Policies;
ALTER TABLE Customers ADD Address VARCHAR(100), City VARCHAR(50);
ALTER TABLE Agents ADD DevOfId INT;
ALTER TABLE Agents ADD CONSTRAINT FK_Agents_DevOf FOREIGN KEY (DevOfId) REFERENCES Agents(AgentID);

SELECT P.* FROM Policies P JOIN PolicyAssignments PA ON P.PolicyID = PA.PolicyID
WHERE PA.CustomerID = 5;

SELECT C.CustomerID, C.FirstName, C.LastName, P.PolicyName, P.PolicyType
FROM Customers C JOIN PolicyAssignments PA ON C.CustomerID = PA.CustomerID
JOIN Policies P ON PA.PolicyID = P.PolicyID;

SELECT C.FirstName, C.LastName, CL.ClaimAmount, CL.ClaimStatus,CL.ClaimDate
FROM Claims CL JOIN PolicyAssignments PA ON CL.AssignmentID = PA.AssignmentID
JOIN Customers C ON PA.CustomerID = C.CustomerID;

SELECT C.FirstName, P.PolicyName, A.AgentName, PA.StartDate, PA.EndDate
FROM PolicyAssignments PA
JOIN Customers C ON PA.CustomerID = C.CustomerID
JOIN Policies P ON PA.PolicyID = P.PolicyID
JOIN Agents A ON CAST(A.AgentID AS VARCHAR) = PA.AgentID;


SELECT C.FirstName, P.PolicyName, CL.ClaimAmount, CL.ClaimStatus,CL.ClaimDate
FROM Claims CL JOIN PolicyAssignments PA ON CL.AssignmentID = PA.AssignmentID
JOIN Customers C ON PA.CustomerID = C.CustomerID JOIN Policies P ON PA.PolicyID = P.PolicyID;

SELECT C.CustomerID,C.FirstName,C.LastName,P.PolicyName
FROM Customers C
LEFT JOIN PolicyAssignments PA ON C.CustomerID = PA.CustomerID
LEFT JOIN Policies P ON PA.PolicyID = P.PolicyID;

SELECT DISTINCT C.CustomerID,C.FirstName,C.LastName FROM Customers C
LEFT JOIN PolicyAssignments PA ON C.CustomerID = PA.CustomerID
LEFT JOIN Claims CL ON PA.AssignmentID = CL.AssignmentID
WHERE CL.ClaimID IS NULL;

SELECT C.FirstName, SUM(CL.ClaimAmount) AS TotalClaimAmount FROM Customers C
JOIN PolicyAssignments PA ON C.CustomerID = PA.CustomerID
JOIN Claims CL ON PA.AssignmentID = CL.AssignmentID
GROUP BY C.FirstName;

SELECT C.FirstName,SUM(CL.ClaimAmount) AS TotalClaimAmount FROM Customers C
JOIN PolicyAssignments PA ON C.CustomerID = PA.CustomerID
JOIN Claims CL ON PA.AssignmentID = CL.AssignmentID
GROUP BY C.FirstName HAVING SUM(CL.ClaimAmount) > 50000;

SELECT A.AgentName, COUNT(PA.PolicyID) AS PolicyCount FROM Agents A
LEFT JOIN PolicyAssignments PA ON CAST(A.AgentID AS VARCHAR) = PA.AgentID
GROUP BY A.AgentName;




--Getting to know which customer has which policy & its details
SELECT
      C.FirstName, C.LastName, P.PolicyName, P.PolicyType, PA.StartDate, PA.EndDate
FROM Customers C 
JOIN PolicyAssignments PA ON C.CustomerID = PA.CustomerID
JOIN Policies P ON PA.PolicyID = P.PolicyID;

-- Getting all claims with customer name and policy name 

SELECT 
    C.FirstName, C.LastName, P.PolicyName, CL.ClaimDate, CL.ClaimAmount, CL.ClaimStatus
FROM Claims CL
JOIN PolicyAssignments PA ON CL.AssignmentID = PA.AssignmentID
JOIN Customers C ON PA.CustomerID = C.CustomerID
JOIN Policies P ON PA.PolicyID = P.PolicyID; 



--PracticeQueries--

--2.Display policies with PremiumAmount greater than 5,000.
Select * from Policies where PremiumAmount>5000;

--3.List claims where ClaimAmount is less than 100,000
Select * from Claims where ClaimAmount<100000;

--4. Display policies that expire on or before '2025-12-31'.


--PracticeQueries-OnFunctions--
--STRING FUNCTIONS--

--1.Display customer full name by concatenating FirstName and LastName.

Select Concat(FirstName,LastName) from Customers;

--2.Find customers whose FirstName starts with ‘A’.

Select * from Customers where FirstName Like 'A%';

--3.Display LastName in UPPERCASE.

Select Upper(LastName) from Customers;

--4.Find customers whose LastName length is more than 4 characters.

Select * from Customers where Len(LastName)>4;

--5.Display the first 3 characters of FirstName.

Select Left(FirstName,3) from Customers;

--6.Replace the word ‘Life’ with ‘Term Life’ in PolicyType.

Select Replace(PolicyName,'Life','Term Life') from Policies;


----------------------------------------------------------------------------------------

Notes:

CRUD OPERATIONS:

DML - INSERT/UPDATE/DELETE/SELECT



SELECT (WHAT YOU WANT TO SEE)

FROM (Source - from which you want to display data)

WHERE (Condition to give)

ORDER BY ColumnName(s) sort criteria (ASC/DESC) (By default ASC) 
- can give multiple coloumn names after orderby -if its a tie case with first column it uses second column for sorting.

GROUP BY - group criteria

Having -  to apply condition over group

----------------------------------------------------------------------------------------


