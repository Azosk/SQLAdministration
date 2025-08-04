USE AdventureWorks2022
GO

-- Select all employees from a table
-- SELECT * FROM HumanResources.Employee

-- Select top 100 records from a table
-- SELECT TOP (100) *
-- FROM HumanResources.Employee;

-- Select bottom 100 records from a table
-- SELECT TOP (100) *
-- FROM HumanResources.Employee ORDER BY Employee.BusinessEntityID DESC;

-- Select all employee job titles and their birthdate that have been born before 1955
-- SELECT JobTitle, BirthDate FROM HumanResources.Employee
-- WHERE Employee.BirthDate < '1/1/1955';

-- Select persons name by first name a nd last name
-- SELECT Person.FirstName, Person.LastName FROM Person.Person
-- WHERE Person.FirstName = 'Ken' AND Lastname = 'Myer';

-- Select all emloyee job titles and hire dates and sort them by their hire date descending
-- To do ascending leave it blank or type ASC
-- SELECT JobTitle, HireDate FROM HumanResources.Employee
-- ORDER BY Employee.HireDate DESC;

-- Select all employee job titles and hire dates, then sort them by job title descending and after hiredate ascending
-- SELECT JobTitle, HireDate FROM HumanResources.Employee
-- ORDER BY Employee.JobTitle DESC, HireDate ASC;

-- Select all records with the word 'Marketing' in the job title
-- SELECT * FROM HumanResources.Employee
-- WHERE JobTitle LIKE '%Marketing%'; --CONTAINS

-- Select all records with Vice at the start of the job title
-- SELECT * FROM HumanResources.Employee
-- WHERE JobTitle LIKE 'Vice %'; --STARTS WITH

-- Select all records with Manager at the end of the job title
-- SELECT * FROM HumanResources.Employee
-- WHERE JobTitle LIKE '% Manager'; -- ENDS WITH

-- Select names with aliased columns
-- SELECT
--     Person.FirstName AS [First], 
--     Person.LastName [Last] 
-- FROM Person.Person
-- WHERE Person.FirstName = 'Ken' 
-- AND Lastname = 'Myer';


-- Select all job titles and include their pay rate (using aliases) if it exceeds 25 and sort by lowest pay
-- Here I improved the query, using as for fieldname aliases which makes it more portable
-- We also did it for the tables, to make it more readable, and I made sure to use a flat number value
-- Prior we used '50' which makes it a string. We also had left join but there are no null values in our filter, 
-- so we changed it to inner join.
-- SELECT 
--     JobTitle AS [Job Title], 
--     Rate AS [Rate of Pay]
-- FROM [HumanResources].[Employee] AS empData
-- INNER JOIN [HumanResources].[EmployeePayHistory] AS payData
-- ON empData.BusinessEntityID = payData.BusinessEntityID
-- WHERE payData.Rate > 50 ORDER BY Rate ASC;

-- Select firstname, lastname, rate, and start date. Join department history and pay history to
-- our table using inner joins. Sort the table by last name ascending, and only include entries
-- where the pay rate is above 20 and the start date was after 1/1/2010.
-- We improved this query by using the ISO standard date format (2010-1-1) and adding 
-- a filter for not including records where the department end date is not null. This
-- is because the department can have multiple entries with end dates and we want the
-- most recent start/end date based on their current role.

-- SELECT 
--     FirstName AS [First Name],
--     LastName AS [Last Name],
--     Rate AS [Rate of Pay],
--     StartDate AS [Initial Start Date]
-- FROM [Person].[Person] AS person
-- INNER JOIN [HumanResources].[EmployeeDepartmentHistory] AS department
--     ON person.BusinessEntityID = department.BusinessEntityID
-- INNER JOIN [HumanResources].[EmployeePayHistory] AS pay
--     ON person.BusinessEntityID = pay.BusinessEntityID
-- WHERE 
--     pay.Rate > 20 
--     AND department.StartDate > '2010-01-01' 
--     AND department.EndDate IS NULL
-- ORDER BY LastName ASC;

-- Select all products and their names and number, including the work orders in production
-- and the scrap reasons in production. Then, we perform an inner join to get all the
-- products that have work orders and also include a scrap reason by their ID.
-- Finally, we filter it by products that have a order quantity of more than 10,
-- and then we sort them by the order quantity (ascending).
-- SELECT 
--     prod.Name AS [Product Name],
--     prod.ProductNumber AS [ProductNumber],
--     wo.OrderQty AS [Order Quantity],
--     wo.StockedQty AS [Stocked Quantity],
--     scrap.ScrapReasonID AS [Scrap ID]
-- FROM [Production].[Product] prod
-- INNER JOIN [Production].[WorkOrder] wo 
--     ON wo.productID = prod.ProductID
-- RIGHT JOIN [Production].[ScrapReason] scrap
--     ON wo.ScrapReasonID = scrap.ScrapReasonID
-- WHERE StockedQty > 10
-- ORDER BY OrderQty ASC;

-- Select all customers and employees into one data set discarding duplicates
-- SELECT p.FirstName, e.JobTitle
-- FROM [HumanResources].[Employee] AS e 
-- INNER JOIN [Person].[Person] p
-- ON e.BusinessEntityID = p.BusinessEntityID
-- UNION
-- SELECT p.FirstName, p.PersonType 
-- FROM [Sales].[Customer] AS c 
-- INNER JOIN [Person].[Person] p
-- ON c.CustomerID = p.BusinessEntityID;

-- Select all customers and employees into one data set including all duplicates
-- SELECT p.FirstName, e.JobTitle
-- FROM [HumanResources].[Employee] AS e 
-- INNER JOIN [Person].[Person] p
-- ON e.BusinessEntityID = p.BusinessEntityID
-- UNION ALL
-- SELECT p.FirstName, p.PersonType 
-- FROM [Sales].[Customer] AS c 
-- INNER JOIN [Person].[Person] p
-- ON c.CustomerID = p.BusinessEntityID;

-- Using DISTINCT eliminates all duplicates from a table.
-- In this case, it is anyone with a different first and last name.
-- SELECT DISTINCT 
--     per.FirstName [First Name],
--     per.LastName [Last Name]
-- FROM [Sales].[Customer] cust
-- INNER JOIN [Person].[Person] per
--     ON per.BusinessEntityID = cust.PersonID;

-- SELECT DISTINCT
--     per.PersonType [Person Type]
-- FROM [Person].[Person] per;

-- SELECT 
--     per.FirstName [First Name],
--     per.LastName [Last Name]
-- FROM [Sales].[Customer] cust
-- INNER JOIN [Person].[Person] per
--     ON per.BusinessEntityID = cust.PersonID
-- GROUP BY per.FirstName, per.LastName
-- ORDER BY per.LastName DESC;

-- Find the number of customers
-- SELECT 
--     COUNT(per.FirstName) 
-- FROM [Sales].Customer cust
-- INNER JOIN [Person].[Person] per
-- ON per.BusinessEntityID = cust.PersonID;

-- Find the number of customer with the same first name as long as there is 
-- more than 15 occurences and the first name starts with A
-- SELECT 
--     per.FirstName AS [First Name],
--     COUNT(per.FirstName) AS [Number of occurences]
-- FROM [Sales].[Customer] cust
-- INNER JOIN [Person].[Person] per
-- ON per.BusinessEntityID = cust.PersonID
-- WHERE per.FirstName LIKE 'A%'
-- GROUP BY per.FirstName
-- HAVING COUNT(per.FirstName) > 15
-- ORDER BY per.FirstName;

-- Find total, average, lowest and highest amounts for sales
-- SELECT 
--     COUNT(sale.SalesOrderID) [Number of Sales],
--     AVG(sale.TotalDue) [Sale Average],
--     SUM(sale.TotalDue) [Total of all Sales],
--     MIN(sale.TotalDue) [Lowest Sale],
--     MAX(sale.TotalDue) [Highest Sale]
-- FROM [Sales].[SalesOrderHeader] sale;
-- GROUP BY sale.TotalDue;

-- Find the total sales, average sales, lowest and highest sales for a particular employee.
-- List their first and last name and sort them by sales average.
-- SELECT 
--     per.BusinessEntityID [Empoloyee ID],
--     per.FirstName [First Name],
--     per.LastName [Last Name],
--     COUNT(sale.SalesOrderID) [Number of Sales],
--     SUM(sale.TotalDue) [Total Sales],
--     MAX(sale.TotalDue) [Highest Sale],
--     MIN(sale.TotalDue) [Lowest Sale],
--     AVG(sale.TotalDue) [Sale Average]
-- FROM [Person].[Person] per
-- INNER JOIN [Sales].[SalesPerson] emp
-- ON per.BusinessEntityID = emp.BusinessEntityID
-- INNER JOIN [Sales].[SalesOrderHeader] sale
-- ON emp.BusinessEntityID = sale.SalesPersonID
-- GROUP BY per.BusinessEntityID, per.FirstName, per.LastName
-- ORDER BY SUM(sale.SalesOrderID) DESC;



-- SELECT 
--     p.BusinessEntityID [Empoloyee ID],
--     CONCAT(p.FirstName, ' ', p.LastName) [Full Name],
--     COUNT(sale.SalesOrderID) [Number of Sales],
--     FORMAT(SUM(sale.TotalDue), 'C') [Total Sales],
--     FORMAT(MAX(sale.TotalDue), 'C') [Highest Sale],
--     FORMAT(MIN(sale.TotalDue), 'C') [Lowest Sale],
--     FORMAT(AVG(sale.TotalDue), 'C') [Sale Average]
-- FROM [Person].[Person] p
-- INNER JOIN [Sales].[SalesPerson] emp
-- ON p.BusinessEntityID = emp.BusinessEntityID
-- INNER JOIN [Sales].[SalesOrderHeader] sale
-- ON emp.BusinessEntityID = sale.SalesPersonID
-- GROUP BY p.BusinessEntityID, p.FirstName, p.LastName
-- ORDER BY SUM(sale.SalesOrderID) DESC;