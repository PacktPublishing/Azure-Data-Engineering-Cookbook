
-- Execute against the Azure Synapse Sql pool
CREATE WORKLOAD CLASSIFIER [wlcsalesmgr]

WITH (WORKLOAD_GROUP = 'xlargerc'

,MEMBERNAME = 'salesreport'

,WLM_LABEL = 'manager'

,IMPORTANCE = HIGH);

GO



CREATE WORKLOAD CLASSIFIER [wlcsalesdev]

WITH (WORKLOAD_GROUP = 'xlargerc'

,MEMBERNAME = 'salesreport'

,WLM_LABEL = 'developer'

,IMPORTANCE = LOW);

GO

