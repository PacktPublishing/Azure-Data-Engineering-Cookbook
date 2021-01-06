-- salesreportnocontext.sql
select 
Datepart(year,invoicedate) as [year],
Datepart(month,invoicedate) as [month],
stockcode,
customerid,
country,
sum(quantity*unitprice) as totalsales
from orders 
group by Datepart(year,invoicedate),Datepart(month,invoicedate),country,stockcode,customerid
order by country,[year],[month],stockcode,customerid
option(label = 'manager')
