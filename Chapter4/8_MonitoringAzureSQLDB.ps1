# Monitoring an Azure SQL Database using Azure Portal

# create the resource group
New-AzResourceGroup -Name packtade -Location "central us" -force

#create credential object for the Azure SQL Server admin credential
$sqladminpassword = ConvertTo-SecureString 'Sql@Server@1234' -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ('sqladmin', $sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName azadesqlserver -SqlAdministratorCredentials $sqladmincredential -Location "central us" -ResourceGroupName packtade

#Create the SQL Database
New-AzSqlDatabase -DatabaseName adeawlt -Edition basic -ServerName azadesqlserver -ResourceGroupName packtade -SampleName AdventureWorksLT

# whitelist the client's IP 
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip
New-AzSqlServerFirewallRule -FirewallRuleName "home" -StartIpAddress $clientip -EndIpAddress $clientip -ServerName azadesqlserver -ResourceGroupName packtade


# execute the workload
# sqlcmd is required for this recipe
# change the input file path 
sqlcmd -S azadesqlserver.database.windows.net -d adeawlt -U sqladmin -P Sql@Server@1234 -i "C:\ADECookbook\Chapter4\workload.sql" > "C:\ADECookbook\Chapter4\workload_output.txt"