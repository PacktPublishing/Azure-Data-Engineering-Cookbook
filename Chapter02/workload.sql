SELECT 'Total income is', ((OrderQty * UnitPrice) * (1.0 - UnitPriceDiscount)), ' for ',
p.Name AS ProductName 
FROM SalesLT.Product AS p 
INNER JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID 
where p.name like '%go%'
ORDER BY ProductName ASC;
GO
select * from [SalesLT].[Product] where name like '%abc%';
GO
select * from [SalesLT].[Product] where name like '%ca%';
GO
select * from [SalesLT].[Product] where name like '%bd%';
GO
USE AdventureWorks2012;
GO
SELECT DISTINCT Name
FROM [SalesLT].[Product] AS p 
WHERE EXISTS
    (SELECT *
     FROM [SalesLT].[ProductModel] AS pm 
     WHERE p.ProductModelID = pm.ProductModelID
           AND pm.Name LIKE 'Long-Sleeve Logo Jersey%');

GO
SELECT DISTINCT Name
FROM [SalesLT].[Product] p
WHERE ProductModelID IN
    (SELECT ProductModelID 
     FROM SalesLT.ProductModel AS pm
     WHERE p.ProductModelID = pm.ProductModelID
        AND Name LIKE '%Long ersey%');
GO
select * from [SalesLT].[SalesOrderDetail] sod 
cross join [SalesLT].[SalesOrderHeader] soh
GO
select CAST(sod.productid as nvarchar(max)) from [SalesLT].[SalesOrderDetail] sod 
cross join [SalesLT].[SalesOrderHeader] soh
GO
select CAST(sod.productid as nvarchar(max)) from [SalesLT].[SalesOrderDetail] sod 
cross join [SalesLT].[SalesOrderHeader] soh
GO
select CAST(sod.productid as nvarchar(max)) from [SalesLT].[SalesOrderDetail] sod 
cross join [SalesLT].[SalesOrderHeader] soh
GO
select CAST(sod.productid as nvarchar(max)) from [SalesLT].[SalesOrderDetail] sod 
cross join [SalesLT].[SalesOrderHeader] soh
GO
select Name from [SalesLT].[Product] WHERE ListPrice>100
GO
select Name from [SalesLT].[Product] WHERE ListPrice>=100 and Weight>1 
GO
select ProductID from SalesLT.SalesOrderDetail where OrderQty > 2
GO
select ProductID from SalesLT.SalesOrderDetail where OrderQty >= 2 and UnitPrice>1






