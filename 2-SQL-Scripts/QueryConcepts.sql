USE AdventureWorks2022;

-- Inner Query or SubQuery example. This shows how to retrieve employees with
-- more vacation hours than the average employee (average hours is 50 in this case).
-- SELECT
--     BusinessEntityID,
--     LoginID,
--     JobTitle,
--     VacationHours
-- FROM [HumanResources].[Employee]
-- WHERE VacationHours > (SELECT
--     AVG(VacationHours)
-- FROM [HumanResources].[Employee])
-- ORDER BY VacationHours DESC;

-- Use a subquery in order to obtain the average hours for each employee,
-- then use that subquery to filter employees with Janitor job title that
-- have more than the average vacation hours.
-- SELECT 
--     e.BusinessEntityID,
--     e.LoginID,
--     e.JobTitle,
--     e.Vacationhours,
--     q.AverageVacation -- Drawn from subquery
-- FROM [HumanResources].[Employee] e
-- JOIN (SELECT 
--     JobTitle,
--     AVG(VacationHours) AverageVacation
--     FROM [HumanResources].[Employee]
--     GROUP BY JobTitle) q
-- ON e.JobTitle = q.JobTitle
-- WHERE e.VacationHours > q.AverageVacation
-- AND e.JobTitle = 'Janitor';

-- WITH Sales_CTE (FirstName, LastName, SalesPersonID, SalesOrderID, SalesYear)
-- AS
-- -- Define CTE
-- (
--     SELECT 
--         p.FirstName,
--         p.LastName,
--         SalesPersonID,
--         SalesOrderID,
--         YEAR(OrderDate) AS SalesYear
--     FROM [Sales].[SalesOrderHeader]
--     INNER JOIN [Person].[Person] p
--     ON SalesPersonID = p.BusinessEntityID
--     WHERE SalesPersonID IS NOT NULL
-- )

-- SELECT FirstName, LastName, COUNT(SalesOrderID) AS TotalSales, SalesYear
-- FROM Sales_CTE
-- WHERE SalesYear > '2012'
-- GROUP BY FirstName, LastName, SalesYear, SalesPersonID
-- ORDER BY SalesPersonID, SalesYear;


-- Using Subquery
-- SELECT 
--     SalesOrderID, 
--     CarrierTrackingNumber,
--     OrderQTY,
--     (SELECT MAX(UnitPrice) FROM [Sales].[SalesOrderDetail]) AS UnitPrice,
--     (SELECT MIN(UnitPrice) FROM [Sales].[SalesOrderDetail]) AS UnitPrice
-- FROM [Sales].[SalesOrderDetail];

-- Using OVER
-- SELECT
--     SalesOrderID,
--     CarrierTrackingNumber,
--     OrderQty,
--     MAX(UnitPrice) OVER() AS MaxUnitPrice,
--     MIN(UnitPrice) OVER() AS MinUnitPrice
-- FROM [Sales].[SalesOrderDetail];

-- This does a group by which aggregates that data to rows by
-- combining orders that have the same salesorderID.
--
-- SELECT 
--     SalesOrderID, 
--     CarrierTrackingNumber, 
--     OrderQty, 
--     MAX(UnitPrice) AS MaxUnitPrice, 
--     MIN(UnitPrice) AS MinUnitPrice
-- FROM [Sales].[SalesOrderDetail]
-- WHERE SalesOrderID = 43659
-- GROUP BY SalesOrderID, CarrierTrackingNumber, OrderQty;

-- Partitioning the Data which shows each existing row and adds
-- a column to all roles including the maxunitprice and minuniprice
-- for that particular salesID.

-- SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, UnitPrice,
--     MAX(UnitPrice) OVER(PARTITION BY SalesOrderID) AS MaxUnitPrice,
--     MIN(UnitPrice) OVER(PARTITION BY SalesOrderID) AS MinUnitPrice
-- FROM [Sales].[SalesOrderDetail]
-- WHERE SalesOrderID = 43659;

-- Sum by Sales order
-- SELECT SalesorderID, CarrierTrackingNumber, OrderQty,
--     SUM(UnitPrice) OVER(PARTITION BY SalesOrderID) AS Total
-- FROM [Sales].[SalesOrderDetail];

-- Adds a row number in order to give a count to the rows based on
-- their placement within the table

-- SELECT
--     BusinessEntityID,
--     LoginID,
--     JobTitle,
--     VacationHours,
--     ROW_NUMBER() OVER(ORDER BY LoginID) AS [RowCount]
-- FROM [HumanResources].[Employee];

-- 


-- Selects all employees and lists their job title and orders them
-- by vacation hours. They are then assigned a rank, and if that rank
-- is the same number (i.e. there are two rank 1's) then the next rank
-- would be set to three. Derank fixes this by having the next rank
-- (i.e. there are two rank 1's) to 2 instead of 3.

-- SELECT
--     BusinessEntityID,
--     LoginID,
--     JobTitle,
--     VacationHours,
--     RANK() OVER(PARTITION BY JobTitle ORDER BY VacationHours) AS [Rank]
-- FROM [HumanResources].[Employee];

-- UPDATE [HumanResources].[Employee] SET VacationHours = 88
-- WHERE LoginID = 'adventure-works\pat0';


-- Here is the ranking for janitor employees. If you want to get the rank 
-- value in a WHERE statement, you must convert this query to a CTE and
-- then request it in a new query. This is because you can't filter by
-- a window function, such as RANK, ROW, DENSE_RANK, etc

-- SELECT
--     BusinessEntityID,
--     LoginID,
--     JobTitle,
--     VacationHours,
--     DENSE_RANK() OVER(PARTITION BY JobTitle ORDER BY VacationHours) AS [Rank]
-- FROM [HumanResources].[Employee]

-- Getting the rank from a window function
-- WITH Rank_CTE
-- AS
-- (SELECT
--     BusinessEntityID,
--     LoginID,
--     JobTitle,
--     VacationHours,
--     DENSE_RANK() OVER(PARTITION BY JobTitle ORDER BY VacationHours) AS [Rank]
-- FROM [HumanResources].[Employee])
-- SELECT * FROM Rank_CTE WHERE Rank = 1;

-- LEAD and LAG work by date, so it shows the next stock level or the prior
-- stock level here based on date. The 5 here indicates that it skips the
-- last five nextstocklevels and the first 5 priorstocklevels here.

-- SELECT ProductID, Name, ProductNumber, SafetyStockLevel,
-- LEAD(SafetyStockLevel, 5, 0) OVER (ORDER BY ProductID) AS NextStocklevel,
-- LAG(SafetyStockLevel, 5, 0) OVER (ORDER BY ProductID) AS PriorStockLevel
-- FROM [Production].[Product];

-- The difference here is that ISNULL will return a character which can
-- be a number, but it still registers as a varchar. However, COALESCE
-- checks the types, so if you input a number it will return an error.
-- These are useful for outputting data instead of null to the end user.

-- SELECT TOP (10)
--     ISNULL([Title], 'No Title') AS Title,
--     FirstName,
--     COALESCE([MiddleName], 'N/A') AS MiddleName,
--     LastName,
--     Suffix,
--     EmailPromotion,
--     AdditionalContactInfo
-- FROM [Person].[Person];

-- Another example is that ISNULL returns a value based on the
-- expression. COALESCE returns a value based on the parameter.
-- So here, COALESCE will return the full word but ISNULL won't.

-- DECLARE @string VARCHAR(3);
-- SELECT 'COALESCE', COALESCE(@string, 'longer')
-- UNION ALL
-- SELECT 'ISNULL', ISNULL(@string,'longer');