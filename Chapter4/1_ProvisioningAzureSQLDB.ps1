# Provision an Azure SQL Database

# Set parameters
$resourcegroup  = "packtade"
$servername = "azadesqlserver"
$databasename = "azadesqldb"
$password = 'Sql@Server@1234'
$location="central us"
# create resource group
New-AzResourceGroup -Name packtade -Location "central us" -force

#create credential object for the Azure SQL Server admin credential
$sqladminpassword = ConvertTo-SecureString $password -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ('sqladmin', $sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName $servername -SqlAdministratorCredentials $sqladmincredential -Location $location -ResourceGroupName $resourcegroup

# create the database 
New-AzSqlDatabase -DatabaseName $databasename  -Edition basic -ServerName $servername -ResourceGroupName $resourcegroup


# whitelist the client/host public IP
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip

New-AzSqlServerFirewallRule -FirewallRuleName "home" `
							-StartIpAddress $clientip `
							-EndIpAddress $clientip `
							-ServerName $servername `
							-ResourceGroupName $databasename

<#
To connect to the database using sqlcmd, open a new powershell window and execute the below command

sqlcmd -S "azadesqlserver.database.windows.net" -U sqladmin -P "Sql@Server@1234" -d azadesqldb

#>							


