select 
country,
stockcode,
customerid,
sum(quantity*unitprice) as totalsales
from orders 
group by country,stockcode,customerid
order by country
