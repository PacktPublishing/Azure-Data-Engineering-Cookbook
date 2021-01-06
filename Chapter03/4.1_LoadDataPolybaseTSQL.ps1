# Loading data in SQL Pool using Polybase with T-SQL

# Set parameters
$resourcegroupname = "packtade"
$storageaccountname = "azadedls"
$servername = "azadesqlserver"
$directory  = "C:\ADE\azure-data-engineering-cookbook\Chapter5\Data"


#Create a new Azure Data Lake Storage account
$dlsa = New-AzStorageAccount -ResourceGroupName $resourcegroupname `
							 -Name $storageaccountname `
							 -SkuName Standard_LRS `
							 -Location centralus `
							 -Kind StorageV2 `
							 -AccessTier Hot `
							 -EnableHierarchicalNamespace $true # required for data lake 

#create the file system (container)
New-AzDatalakeGen2FileSystem -Name ecommerce -Context $dlsa.Context     

#Create the directory within the file system
New-AzDataLakeGen2Item -FileSystem ecommerce -Path "orders/" -Context $dlsa.Context -Directory

#upload files to the directory

#get all files to be uploaded
$files = Get-ChildItem -Path $directory

#upload all files in the data directory to Azure data lake storage
foreach($file in $files) {
$source = $file.FullName 
$dest = "orders/" + $file.Name
New-AzDataLakeGen2Item -FileSystem ecommerce -Path $dest -Source $source -Context $dlsa.Context -ConcurrentTaskCount 50 -Force
}      

#list out all the files from the orders directory in Azure data lake storage
Get-AzStorageBlob -Container ecommerce -Context $dlsa.Context

# Get storage account key. Save it for later use.
$dlsa | Get-AzStorageAccountKey

# Whitelist client's IP
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip
New-AzSqlServerFirewallRule -FirewallRuleName "home" `
							-StartIpAddress $clientip `
							-EndIpAddress $clientip `
							-ServerName $servername `
							-ResourceGroupName $resourcegroupname

							

