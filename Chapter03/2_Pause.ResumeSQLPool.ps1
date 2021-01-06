# Pause or resume a Synapse SQL pool using PowerShell

#get the Synapse SQL pool object
$dw = Get-AzSqlDatabase -ServerName azadesqlserver -DatabaseName azadesqldw -ResourceGroupName packtade

#check the status
$dw.Status

#suspend/pause the Synapse SQL pool compute
$dw | Suspend-AzSqlDatabase

#resume Synapse SQL pool
$dw | Resume-AzSqlDatabase





