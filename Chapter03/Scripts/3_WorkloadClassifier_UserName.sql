-- Execute against the Azure Synapse Sql pool

CREATE WORKLOAD CLASSIFIER [wlcsalesreport]

WITH (WORKLOAD_GROUP = 'xlargerc'

,MEMBERNAME = 'salesreport'

,IMPORTANCE = HIGH);	

GO

CREATE WORKLOAD CLASSIFIER [wlcadhocquery]

WITH (WORKLOAD_GROUP = 'xlargerc'

,MEMBERNAME = 'adhocquery'

,IMPORTANCE = LOW);

