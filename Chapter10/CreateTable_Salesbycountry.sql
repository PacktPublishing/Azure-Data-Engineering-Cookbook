-- Creates salesbycountry table in Azure Synapse SQL Pool
CREATE TABLE salesbycountry
(
country VARCHAR(100),
Amount DECIMAL(10,2),
min_eventdatetime_ts DATETIME,
max_eventdatetime_ts DATETIME
)
