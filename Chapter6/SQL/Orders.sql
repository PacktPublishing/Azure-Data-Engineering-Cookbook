-- Create orders table
IF OBJECT_ID('Orders', 'U') IS NOT NULL 
  DROP TABLE Orders; 
GO
CREATE TABLE Orders(
InvoiceNo varchar(100),
StockCode varchar(100),
Description varchar(1000),
Quantity int,
InvoiceDate varchar(100),
UnitPrice decimal(10,2),
CustomerID varchar(500),
Country varchar(500),
orderid int
)
WITH
(
DISTRIBUTION = ROUND_ROBIN,
CLUSTERED COLUMNSTORE INDEX
);