# Create and Cosmos DB account and SQL API database
# returns the primary connection string.
param(
$resourceGroupName = "packtade",
$location = "centralus",
$accountName = "packtcosmosdb",
$apiKind = "Sql"
)

# Create or update the resource group
New-AzResourceGroup -Name $resourceGroupName -location $location -force

# Create the Cosmos DB SQL API 
New-AzCosmosDBAccount `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Name $accountName `
    -ApiKind $apiKind
	
# Create the orders database
New-AzCosmosDBSqlDatabase -ResourceGroupName $ResourceGroupName -AccountName $accountName -Name orders

# Create the weborders container
New-AzCosmosDBSqlContainer `
	-ResourceGroupName $resourceGroupName `
	-AccountName $accountName `
	-DatabaseName orders `
	-Name weborders `
	-PartitionKeyKind hash `
	-PartitionKeyPath /invoiceno


$cs = Get-AzCosmosDBAccountKey -ResourceGroupName $resourceGroupName -Name $accountName -Type "Connectionstrings"

write-host "Note the connection string.It's required for the next step" -ForegroundColor Green 

$cs['Primary SQL Connection String']