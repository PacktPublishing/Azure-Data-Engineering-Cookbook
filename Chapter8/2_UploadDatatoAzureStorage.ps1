<#
Connect-AzAccount
Follow the instructions to login to the Azure account.
#>
param(
[string]$resourcegroupname,
[string]$storageaccountname,
[string]$location,
[string]$datadirectory,
[boolean]$createstorageaccount,
[boolean]$uploadfiles
)

if($createstorageaccount -eq $true)
{
	#Create a new resource group
	New-AzResourceGroup -Name $resourcegroupname -Location $location -Force

	# Create a new Azure Storage Account
	$storage = New-AzStorageAccount -ResourceGroupName $resourcegroupname `
		-Name $storageaccountname `
		-SkuName Standard_LRS `
		-Location $location `
		-Kind StorageV2 `
		-AccessTier Hot
		
	# Create source storage container
	New-AzStorageContainer -Name orders -Context $storage.context
	
	New-AzStorageContainer -Name processedfiles -Context $storage.context
}

If($uploadfiles -eq $true)
{
	# get storage context
	$storage = Get-AzStorageAccount -ResourceGroupName $resourcegroupname -Name $storageaccountname
	#upload ~/chapter7/Data/ to orders container
	#get files to be uploaded from the directory
	$files = Get-ChildItem -Path $datadirectory
	#iterate through each file int the folder and upload it to the azure container
	foreach($file in $files){
	$filename = $file.name
		Set-AzStorageBlobContent -File $file.FullName -Context $storage.context -Blob datain/$filename -Container orders -Force
	}
}

# Get storage account key. It's used in creating Data factory linked service.
Get-AzStorageAccountKey -ResourceGroupName $resourcegroupname -Name $storageaccountname


