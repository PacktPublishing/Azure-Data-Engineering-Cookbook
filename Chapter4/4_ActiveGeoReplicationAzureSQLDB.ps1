# Implementing active Geo-Replication for an Azure SQL Database using PowerShell

# set parameters 
$resourcegroup = "packtade"
$primaryserver="azadesqlserver"
$secondaryserver="azadesqlsecondary "
$secondaryserverlocation="westus"
$databasename="$databasename"
$password='Sql@Server@1234'
$username='sqladmin' 
# create the readable secondary

#create credential object for the Azure SQL Server admin credential

$sqladminpassword = ConvertTo-SecureString $password -AsPlainText -Force

$sqladmincredential = New-Object System.Management.Automation.PSCredential ($username, $sqladminpassword)

New-AzSQLServer -ServerName $secondaryserver -SqlAdministratorCredentials $sqladmincredential -Location $secondaryserverlocation -ResourceGroupName $resourcegroup

# Configure Active Geo Replication between primary and secondary
$primarydb = Get-AzSqlDatabase -DatabaseName $databasename -ServerName $primaryserver -ResourceGroupName $resourcegroup
$primarydb | New-AzSqlDatabaseSecondary -PartnerResourceGroupName $resourcegroup -PartnerServerName $secondaryserver -AllowConnections "All"

# perform manual failover from primary to secondary
$secondarydb = Get-AzSqlDatabase -DatabaseName $databasename -ServerName $secondaryserver -ResourceGroupName $resourcegroup
$secondarydb | Set-AzSqlDatabaseSecondary -PartnerResourceGroupName $resourcegroup -Failover

# Get Active geo-replication details
Get-AzSqlDatabaseReplicationLink -DatabaseName $databasename `
								 -PartnerResourceGroupName $resourcegroup `
								 -PartnerServerName $secondaryserver `
								 -ServerName $primaryserver `
								 -ResourceGroupName $resourcegroup


#Remove Active Geo-Replication
$primarydb = Get-AzSqlDatabase -DatabaseName $databasename -ServerName $primaryserver -ResourceGroupName $resourcegroup
$primarydb | Remove-AzSqlDatabaseSecondary -PartnerResourceGroupName $resourcegroup -PartnerServerName $secondaryserver

