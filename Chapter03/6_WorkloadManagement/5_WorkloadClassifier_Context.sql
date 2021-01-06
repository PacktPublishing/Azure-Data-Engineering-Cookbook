
-- Execute against the Azure Synapse Sql pool
CREATE WORKLOAD CLASSIFIER [wlcsalesdashboard]

WITH (WORKLOAD_GROUP = 'xlargerc'

,MEMBERNAME = 'salesreport'

,WLM_LABEL = 'manager'

,WLM_CONTEXT = 'dashboard'

,IMPORTANCE = HIGH);

GO



CREATE WORKLOAD CLASSIFIER [wlcsalesqueries]

WITH (WORKLOAD_GROUP = 'xlargerc'

,MEMBERNAME = 'salesreport'

,WLM_LABEL = 'manager'

,IMPORTANCE = LOW);

