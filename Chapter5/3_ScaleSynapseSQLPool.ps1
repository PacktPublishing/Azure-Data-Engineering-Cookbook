# Scale an Azure Synapse SQL pool instance using PowerShell

# get synapse sql pool object
$dw = Get-AzSqlDatabase -ServerName azadesqlserver -DatabaseName azadesqldw -ResourceGroupName packtade

# get current performance tier
$dw.CurrentServiceObjectiveName

# scale performance tier to DW200c 
$dw | Set-AzSqlDatabase -RequestedServiceObjectiveName DW200c

# change performance tier to DW100c - scale down
$dw | Set-AzSqlDatabase -RequestedServiceObjectiveName DW100c


