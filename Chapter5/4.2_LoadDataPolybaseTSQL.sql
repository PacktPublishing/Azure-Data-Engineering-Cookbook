-- Execute the queries agains the Synapse SQL pool

-- Create master key
CREATE MASTER KEY;
GO
-- Execute the below command to create database scoped credential. 
-- The SECRET is the Azure storage account key from 4.1_LoadDataPolybaseTSQL.ps1
CREATE DATABASE SCOPED CREDENTIAL ADLSCreds
WITH
IDENTITY = 'azadedls',
SECRET = 'RmM0cmNi0SUZ1OP3yy6HW61xg9KvjWW1Mui9ET/lf41duSi8SsVItYtwiwvH4R7aku0DGY/KFG6qW/p5gHocvQ=='


-- Create the external data source
-- ecommerce@azadedls is a container in azadedls storage account
CREATE EXTERNAL DATA SOURCE adls
WITH (
TYPE = HADOOP,
LOCATION='abfs://ecommerce@azadedls.dfs.core.windows.net', 
CREDENTIAL = ADLSCreds
);


-- Create external file format
CREATE EXTERNAL FILE FORMAT orderfileformat
WITH
( FORMAT_TYPE = DELIMITEDTEXT
, FORMAT_OPTIONS ( FIELD_TERMINATOR = '|'
, DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss'
));

-- Create external table
CREATE EXTERNAL TABLE ext_orders(
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
LOCATION='/orders/'
, DATA_SOURCE = adls
, FILE_FORMAT = orderFileFormat
, REJECT_TYPE = VALUE
, REJECT_VALUE = 0
);
GO

-- count the number of rows in the external table
Select count(*) from ext_orders;

-- load the data into production table from external table
SELECT * into Orders FROM ext_orders
OPTION (LABEL = 'CTAS : Load orders');





