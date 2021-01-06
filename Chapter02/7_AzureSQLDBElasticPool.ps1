#Implementing Azure SQL Database elastic pool using PowerShell


# set parameters
$resourcegroup="packtade"
$servername = "azadesqlserver"
$username='sqladmin'
$password='Sql@Server@1234'
$database1name = "azadedb1"
$database2name= "azadedb2"
$elasticpoolname="adepool"

#create credential object for the Azure SQL Server admin credential
$sqladminpassword = ConvertTo-SecureString $password -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ($username, $sqladminpassword)

# create the azure sql server
New-AzSqlServer -ServerName $servername -SqlAdministratorCredentials $sqladmincredential -Location "central us" -ResourceGroupName $resourcegroup


#Create an elastic pool
New-AzSqlElasticPool -ElasticPoolName $elasticpoolname `
					 -ServerName $servername `
					 -Edition standard ` 
					 -Dtu 100 `
					 -DatabaseDtuMin 20 `
					 -DatabaseDtuMax 100 `
					 -ResourceGroupName $resourcegroup
					 
#Create a new database in elastic pool
New-AzSqlDatabase -DatabaseName $database1name -ElasticPoolName $elasticpoolname -ServerName $servername -ResourceGroupName $resourcegroup

#Create a new database outside of an elastic pool
New-AzSqlDatabase -DatabaseName $database2name -Edition Standard -RequestedServiceObjectiveName S3 -ServerName $servername -ResourceGroupName $resourcegroup

#Add an existing database to the elastic pool
$db = Get-AzSqlDatabase -DatabaseName $database2name -ServerName $servername -ResourceGroupName $resourcegroup
$db | Set-AzSqlDatabase -ElasticPoolName $elasticpoolname

#remove a database from an elastic pool
$db = Get-AzSqlDatabase -DatabaseName $database1name -ServerName $servername -ResourceGroupName $resourcegroup
$db | Set-AzSqlDatabase -Edition Standard -RequestedServiceObjectiveName S3


# get elastic pool object 
$epool = Get-AzSqlElasticPool -ElasticPoolName $elasticpoolname -ServerName $servername -ResourceGroupName $resourcegroup

# get all databases in an elastic pool
$epdbs = $epool | Get-AzSqlElasticPoolDatabase

# change the edition of all databases in an elastic pool to standard S3
foreach($db in $epdbs) {
$db | Set-AzSqlDatabase -Edition Standard -RequestedServiceObjectiveName S3
}
# Remove an elastic pool 
$epool | Remove-AzSqlElasticPool








					 

