
param(
$resourcegroupname = "packtade",
$location = "centralus",
$sqlservername = "packtsqlserver",
$sqlpoolname = "packtdw",
$sqladminuser = "sqladmin",
$sqlpassword = "Sql@Server@1234"
)

#Create resource group

New-AzResourceGroup -Name $resourcegroupname -location $location -force

#create credential object for the Azure SQL Server admin credential
$sqladminpassword = ConvertTo-SecureString $sqlpassword -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ($sqladminuser, $sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName $sqlservername `
				-SqlAdministratorCredentials $sqladmincredential `
				-Location $location `
				-ResourceGroupName $resourcegroupname

$dw = New-AzSqlDatabase -ServerName $sqlservername `
				  -DatabaseName $sqlpoolname `
				  -Edition DataWarehouse `
				  -RequestedServiceObjectiveName DW100c `
				  -ResourceGroupName $resourcegroupname
				  
#Get the client public ip
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip

#Whitelist the public IP in firewall
New-AzSqlServerFirewallRule -FirewallRuleName "home" `
							-StartIpAddress $clientip `
							-EndIpAddress $clientip `
							-ServerName $sqlservername `
							-ResourceGroupName $resourcegroupname
							

# suspend SQL Pool
# Write-host "Suspend SQL pool to save cost.We'll resume it later as and when required."
# $dw | Suspend-AzSqlDatabase

