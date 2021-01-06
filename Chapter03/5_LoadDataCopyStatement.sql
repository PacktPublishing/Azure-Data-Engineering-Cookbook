-- Loading data into SQL Pool using COPY INTO statement
-- Follow the instructions in 4.1_LoadDataPolybaseTSQL.ps1 to create and upload sample data to 
-- an Azure Synapse SQL pool. 


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

-- Use copy statement to insert data from the data lake to orders table
-- The SECRET is the Azure Storage account key.
COPY INTO orders 
from 'https://azadedls.dfs.core.windows.net/ecommerce/orders/*.txt'
with 
(
	fieldterminator = '|'
	,encoding='utf8'
	,CREDENTIAL=(IDENTITY= 'storage account key', SECRET='RmM0cmNi0SUZ1OP3yy6HW61xg9KvjWW1Mui9ET/lf41duSi8SsVItYtwiwvH4R7aku0DGY/KFG6qW/p5gHocvQ==')
)

GO
Select count(*) from orders;