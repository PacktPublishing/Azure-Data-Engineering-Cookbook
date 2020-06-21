#Create resource group

New-AzResourceGroup -Name packtade -location centralus

#create credential object for the Azure SQL Server admin credential
$sqladminpassword = ConvertTo-SecureString 'Sql@Server@1234' -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ('sqladmin', $sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName azadesqlserver -SqlAdministratorCredentials $sqladmincredential -Location "central us" -ResourceGroupName packtade

New-AzSqlDatabase -ServerName azadesqlserver `
				  -DatabaseName azadesqldw `
				  -Edition DataWarehouse `
				  -RequestedServiceObjectiveName DW100c `
				  -ResourceGroupName packtade
				  
#Get the client public ip
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip

#Whitelist the public IP in firewall
New-AzSqlServerFirewallRule -FirewallRuleName "home" `
							-StartIpAddress $clientip `
							-EndIpAddress $clientip `
							-ServerName azadesqlserver `
							-ResourceGroupName packtade
							
# Remove Synapse SQL Pool
# Remove-AzSqlServer -ServerName azadesqlserver -ResourceGroupName packtade		



