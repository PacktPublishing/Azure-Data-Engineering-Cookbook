
# set parameters
$resourcegroup = "packtADE"
$location="eastus"
$vnetname = "packtVnet"
$storageaccountname = "packtadestorage"

# deny access to public networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name packtadestorage -DefaultAction Deny


#create a new virtual network
New-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroup -Location $location -AddressPrefix "10.1.0.0/16"

# get virtual network object
$vnet = Get-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroup

# Create a new subnet in the virtual network
Add-AzVirtualNetworkSubnetConfig -Name default -VirtualNetwork $vnet -AddressPrefix "10.1.0.0/24" -ServiceEndpoint "Microsoft.Storage"

# apply subnet changes to the virtual network
$vnet | Set-AzVirtualNetwork


# get virtual network object
$vnet = Get-AzVirtualNetwork -Name $vnet -ResourceGroupName $resourcegroup
# get the subnet object
$subnet = Get-AzVirtualNetworkSubnetConfig -Name default -VirtualNetwork $vnet


# Allow access to the virtual network to the Azure storage
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -VirtualNetworkResourceId $subnet.Id

# list out all virtual network rules for an Azure Storage account
Get-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -VirtualNetworkResourceId $subnet.Id).VirtualNetworkRules

# remove the virtual network rule from the Azure Storage account
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -VirtualNetworkResourceId $subnet.id

# remove the virtual network
Remove-AzVirtualNetwork -Name $vnetname $resourcegroup -Force

# allow access to all networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -DefaultAction Allow
