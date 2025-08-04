-- USE AdventureWorks2022;
-- Inserting Values

-- Template
-- INSERT INTO Schema.TableName (col1, col2, col3....) VALUES (val1, val2, val3...)

-- SELECT CurrencyCode, Name, ModifiedDate
-- FROM [Sales].[Currency]
-- WHERE Name = 'Cayman Dollar';

-- Insert a new currency (here you can mix in match because
-- we listed the columns, but if we didn't we would have to use
-- the EXACT order as shown in the next example)

-- INSERT INTO [Sales].[Currency]
-- (
--     [CurrencyCode],
--     [Name],
--     [ModifiedDate]
-- )
-- VALUES
-- (
--     'KYD',
--     'Cayman Dollar',
--     GETDATE()
-- )

-- Another Method of doing it but the values have to be in the order
-- of where the columns are situated. We also show an example to fix
-- or UPDATE the column thereafter if mistakes are made.

-- INSERT INTO [Sales].[Currency] VALUES ('BTW', 'Bitcoin', GETDATE());


-- UPDATE [Sales].[Currency]
-- SET CurrencyCode = 'BTC'
-- WHERE CurrencyCode = 'BTW';

-- Inserting multiple currencies
-- INSERT INTO [Sales].[Currency]
-- VALUES( 'ETH', 'Ethereum', GETDATE()),
--     ('BCH', 'Bitcoin Cash', GETDATE()),
--     ('BNB', 'BNB', GETDATE()),
--     ('XRP', 'XRP', GETDATE())

-- SELECT CurrencyCode, Name, ModifiedDate
-- FROM [Sales].[Currency]
-- WHERE CurrencyCode = 'BCH' OR CurrencyCode = 'ETH' OR CurrencyCode = 'BNB' OR CurrencyCode = 'XRP';

-- PARTIAL INSERT
-- You can see this example has a default constraint that provides a date on the time it is
-- modified, so even though we do a partial insert and don't insert a date it doesn't 
-- affect our insert and still provides a modified date. However, it is important to understand
-- the table to know the changes and how it will be affected if we do a partial insert.

-- INSERT INTO [Sales].[Currency] ([CurrencyCode], [Name])
-- VALUES ('LTC', 'Litecoin');

-- SELECT CurrencyCode, Name, ModifiedDate
-- FROM [Sales].[Currency]
-- WHERE Name = 'Litecoin';

-- SELECT INTO statements which is good for table backups
-- SELECT SalesOrderID, SalesOrderNumber, TotalDue INTO [Sales].[SalesOrderBackup2023]
-- FROM [Sales].[SalesOrderHeader];

-- You can do an actual database backup like this but you need persmissions
-- USE master
-- BACKUP DATABASE AdventureWorks2022
-- TO DISK = 'C:\Users\Thomas\Documents\AdventureWorks2022.bak'
-- WITH FORMAT, INIT;
