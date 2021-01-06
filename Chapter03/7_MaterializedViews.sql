CREATE materialized view mvw_salesreport 

WITH (DISTRIBUTION=HASH(country))

AS

SELECT	

	country,

	sum(quantity*unitprice) as totalsales,

	count(*) as ordercount

FROM dbo.orders 

GROUP BY country

