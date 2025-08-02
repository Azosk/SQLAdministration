-- Below are some commands that can be used for creating, deleting, and modifying tables.
-- It also shows how to create, delete, and use a database.

-- CREATE DATABASE Intro_db
-- DROP DATABASE Intro_db
-- USE Intro_db

-- CREATE TABLE Employees
-- (
--     Id INT PRIMARY KEY IDENTITY,
--     FirstName VARCHAR(50) NOT NULL,
--     LastName VARCHAR(50) NOT NULL,
--     DateOfBirth DATETIME2,
--     PhoneNumber VARCHAR(10)
-- )

-- DROP TABLE Employees

-- CREATE TABLE JobTitles 
-- (
--     Id INT PRIMARY KEY IDENTITY,
--     [Name] VARCHAR(100) NOT NULL,
-- )

-- ALTER TABLE Employees
-- ADD JobtitleId INT NOT NULL;

-- ALTER TABLE Employees
-- ADD FOREIGN KEY (JobtitleId) REFERENCES JobTitles(Id);

-- ALTER TABLE Employees
-- ADD EmployeeId VARCHAR(10) UNIQUE

-- ALTER TABLE Employees
-- ADD EmploymentDate DATETIME2 DEFAULT GetDate()

-- ALTER TABLE Employees
-- DROP COLUMN DateOfBirth
-- ALTER COLUMN DateOfBirth date
-- DROP CONSTRAINT UQ__EmployeeID
-- ADD CONSTRAINT UQ_EmployeeId UNIQUE(EmployeeId)