# Implementing Auto-failover group for an Azure SQL Database using PowerShell

# set parameters 
$resourcegroup = "packtade"
$primaryserver="azadesqlserver"
$secondaryserver="azadesqlsecondary "
$secondaryserverlocation="westus"
$databasename="$databasename"
$database2name="azadesqldb2"
$password='Sql@Server@1234'
$username='sqladmin' 
$failovergroupname = "adefg"


# set the credentials
$sqladminpassword = ConvertTo-SecureString 'Sql@Server@1234' -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ('sqladmin', $sqladminpassword)

# create the secondary server
New-AzSQLServer -ServerName $secondaryserver -SqlAdministratorCredentials $sqladmincredential -Location $secondaryserverlocation -ResourceGroupName $resourcegroup


# Create the auto-failover group
New-AzSqlDatabaseFailoverGroup -ServerName $primaryserver `
							   -FailoverGroupName $failovergroupname `
							   -PartnerResourceGroupName $resourcegroup `
							   -PartnerServerName $secondaryserver `
							   -FailoverPolicy Automatic `
							   -ResourceGroupName $resourcegroup
							   
# Add database to the auto failover group
$db = Get-AzSqlDatabase -DatabaseName $databasename -ServerName $primaryserver -ResourceGroupName $resourcegroup
$db | Add-AzSqlDatabaseToFailoverGroup -FailoverGroupName $failovergroupname

# Create and add the database to the auto failover group
$db = New-AzSqlDatabase -DatabaseName $database2name -Edition basic -ServerName $primaryserver -ResourceGroupName $resourcegroup
$db | Add-AzSqlDatabaseToFailoverGroup -FailoverGroupName $failovergroupname

# get failover group details
Get-AzSqlDatabaseFailoverGroup -ServerName $primaryserver -FailoverGroupName $failovergroupname -ResourceGroupName $resourcegroup


# perform manual failover to secondary server$secondarysqlserver = Get-AzSqlServer -ResourceGroupName packtade -ServerName azadesqlsecondary
$secondarysqlserver = Get-AzSqlServer -ResourceGroupName $resourcegroup -ServerName $secondaryserver
$secondarysqlserver | Switch-AzSqlDatabaseFailoverGroup -FailoverGroupName $failovergroupname

# Remove the failover group
# Failover group is removed at the primary.Since we failed over to secondary in previous step, secondary is the new primary.
Remove-AzSqlDatabaseFailoverGroup -ServerName $secondaryserver -FailoverGroupName $failovergroupname -ResourceGroupName $resourcegroup









