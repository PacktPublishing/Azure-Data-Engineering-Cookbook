DROP TABLE IF EXISTS Customer
GO
CREATE TABLE Customer
	(
		id INT,
		[name] VARCHAR(100)
	)
GO
INSERT INTO customer 
	VALUES(1,'Hyphen'),(2,'Page'),(3,'Data Inc'),(4,'Delta'),(5,'Genx'),(6,'Rand Inc'),(7,'Hallo Inc')
GO
DROP TABLE IF EXISTS Sales
GO
CREATE TABLE Sales 
	(
		CustomerName VARCHAR(100),
		Country VARCHAR(100),
		Amount DECIMAL(10,2),
		CreateDate DATETIME DEFAULT (GETDATE())
	)
GO
DROP TABLE IF EXISTS SalesStaging
GO
CREATE TABLE SalesStaging
	(
		CustomerName VARCHAR(100),
		Country VARCHAR(100),
		Amount DECIMAL(10,2)
	)
GO
DROP TABLE IF EXISTS RunningTotal
GO
CREATE TABLE RunningTotal
(
	CustomerName varchar(100),
	Country varchar(100),
	quantity int,
	unitprice decimal(10,2),
	Amount decimal(10,2),
	runningtotal decimal(10,2)
)
GO
CREATE OR ALTER PROCEDURE dbo.MergeSales
AS
BEGIN  
    SET NOCOUNT ON;  
    MERGE Sales AS target  
    USING SalesStaging AS source 
    ON (target.Country = source.Country and target.CustomerName=source.CustomerName)  
    WHEN MATCHED THEN
        UPDATE SET Amount = source.Amount
    WHEN NOT MATCHED THEN  
        INSERT (CustomerName,Country,Amount)  
        VALUES (source.CustomerName, source.Country,source.Amount);
  
END;  
