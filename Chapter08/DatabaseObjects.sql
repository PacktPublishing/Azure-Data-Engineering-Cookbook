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

DROP TABLE IF EXISTS SalesStaging
GO
CREATE TABLE SalesStaging
	(
		CustomerName VARCHAR(100),
		Country VARCHAR(100),
		Amount DECIMAL(10,2)
	)

