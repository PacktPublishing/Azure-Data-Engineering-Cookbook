# Provision an Azure SQL Database
param(
[string]$resourcegroup="packtade",
[string]$servername="azadesqlserver",
[string]$databasename="azadesqldb",
[string]$password='Sql@Server@1234',
[string]$location="central us"
)
# create resource group
New-AzResourceGroup -Name $resourcegroup -Location $location -force

#create credential object for the Azure SQL Server admin credential
$sqladminpassword = ConvertTo-SecureString $password -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ('sqladmin', $sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName $servername -SqlAdministratorCredentials $sqladmincredential -Location $location -ResourceGroupName $resourcegroup

# create the database 
New-AzSqlDatabase -DatabaseName $databasename  -Edition basic -ServerName $servername -ResourceGroupName $resourcegroup

# Enable access to azure services.
# This is required for data factory to connect to the database.
 New-AzSqlServerFirewallRule -ServerName $servername -ResourceGroupName $resourcegroup -AllowAllAzureIPs

 <#
To connect to the database using sqlcmd, open a new powershell window and execute the below command

sqlcmd -S "azadesqlserver.database.windows.net" -U sqladmin -P "Sql@Server@1234" -d azadesqldb

#>							


