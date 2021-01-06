DROP TABLE IF EXISTS orders;
CREATE EXTERNAL TABLE orders(
InvoiceNo string,
StockCode string,
Description string,
Quantity int,
InvoiceDate string,
UnitPrice decimal(10,2),
CustomerID string,
Country string,
orderid int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION 'wasbs://orders@packtstorage.blob.core.windows.net/data';



INSERT OVERWRITE DIRECTORY 'wasbs://ordersummary@packtstorage.blob.core.windows.net/salesbycountry'
select country,sum(Quantity*UnitPrice) as totalsales from orders group by country order by country
