-- to be executed agains the Azure Synapse SQL Pool

CREATE USER salesreport FROM LOGIN salesreport

GO

CREATE USER adhocquery FROM LOGIN adhocquery

GO

GRANT SELECT ON orders TO adhocquery

GO

GRANT SELECT ON orders TO salesreport

