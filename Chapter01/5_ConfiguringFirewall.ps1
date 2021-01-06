# Set parameters

$storageaccountname = "$resourcegroupstorage"
$resourcegroup = "$resourcegroup"

# deny access to all networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -DefaultAction Deny


#get client/host public IP Address
$mypublicIP = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

#Add client IP address firewall rule
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -AccountName $storageaccountname -IPAddressOrRange $mypublicIP


# Add/whitelist a custom IP address to firewall

Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -AccountName $storageaccountname -IPAddressOrRange "20.24.29.30"


#whitelist range of IPs
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -AccountName $storageaccountname -IPAddressOrRange "20.24.0.0/24"


# Get existing firewall rules
(Get-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname).IpRules

#Remove the client IP from the firewall rule
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -IPAddressOrRange $mypublicIP

#Remove the single IP from the firewall rule
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -IPAddressOrRange "20.24.29.30"

#Remove the IP range from the firewall rule
Remove-AzStorageAccountNetworkRule -ResourceGroupName $resourcegroup -Name $storageaccountname -IPAddressOrRange "20.24.0.0/24"

# Allow access to all networks
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourcegroup -Name $storageaccountname -DefaultAction Allow







