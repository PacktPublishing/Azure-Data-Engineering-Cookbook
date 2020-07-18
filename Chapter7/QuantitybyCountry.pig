orders = LOAD 'wasbs://orders@packtstorage.blob.core.windows.net/data' USING PigStorage('|') AS (InvoiceNo:chararray, StockCode:chararray, Description:chararray, Quantity:int, InvoiceDate:chararray, UnitPrice:float,CustomerID:chararray,Country:chararray,orderid:int);
groupbycountry = Group orders by Country;
quantitybycountry = Foreach groupbycountry Generate group as Country,SUM(orders.Quantity) AS TotalQuantity;
Store quantitybycountry into 'wasbs://ordersummary@packtstorage.blob.core.windows.net/quantitybycountry' USING PigStorage (',');
