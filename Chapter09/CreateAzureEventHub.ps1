param(
[string]$resourcegroup,
[string]$location,
[string]$eventhubnamespace,
[string]$eventhubname
)

$ns = New-AzEventHubNamespace -ResourceGroupName $resourcegroup -Name $eventhubnamespace -Location $location -verbose

$ehub = New-AzEventHub -ResourceGroupName $resourcegroup -Namespace $eventhubnamespace -Name $eventhubname

$keys = Get-AzEventHubKey -ResourceGroupName $resourcegroup -Namespace $eventhubnamespace -Name RootManageSharedAccessKey

$connectionstring =  $keys.PrimaryConnectionString + ";EntityPath=$eventhubname"

write-host $connectionstring
