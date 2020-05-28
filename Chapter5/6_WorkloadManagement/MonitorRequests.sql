-- Execute against the Azure Synapse Sql pool
SELECT 
r.session_id,
s.login_name,
r.status,
r.resource_class,
r.classifier_name,
r.group_name,
r.importance,
r.submit_time,
r.start_time
FROM sys.dm_pdw_exec_requests r join sys.dm_pdw_exec_sessions s 
on s.session_id=r.session_id
WHERE 
r.status in ('Running','Suspended')
  AND s.session_id <> session_id()
  AND s.login_name in ('salesreport','adhocquery')
ORDER BY submit_time

