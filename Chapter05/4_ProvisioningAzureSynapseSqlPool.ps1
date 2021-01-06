# create and pause sql pool
param(
[string]$resourcegroupname,
[string]$servername,
[string]$databasename,
[string]$sqladmin,
[string]$sqladminpassword,
[string]$location
)

#Create resource group

New-AzResourceGroup -Name $resourcegroupname -location $location -force

#create credential object for the Azure SQL Server admin credential
$_sqladminpassword = ConvertTo-SecureString $sqladminpassword -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ($sqladmin, $_sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName $servername -SqlAdministratorCredentials $sqladmincredential -Location $location -ResourceGroupName $resourcegroupname

$dw = New-AzSqlDatabase -ServerName $servername `
				  -DatabaseName $databasename `
				  -Edition DataWarehouse `
				  -RequestedServiceObjectiveName DW100c `
				  -ResourceGroupName $resourcegroupname
				  
# pause sql pool
Suspend-AzSqlDatabase -ResourceGroupName $resourcegroupname -ServerName $servername -DatabaseName $databasename

