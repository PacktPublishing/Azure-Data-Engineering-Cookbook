# Create a new container

#set the parameter values
$storageaccountname="packtadestorage"
$resourcegroup="packtade"
$sourcecontainername="logfiles"
$destcontainername="textfiles"

#Get storage account context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

# create the container 
$destcontainer = New-AzStorageContainer -Name $destcontainername -Context $storagecontext

#copy a single blob from one container to another

# name of the blob to copy from soure to destination container
$blob="Logfile1"
Start-CopyAzureStorageBlob -SrcBlob $blob `
						   -SrcContainer $sourcecontainername `
						   -DestContainer $destcontainername `
						   -Context $storagecontext `
						   -DestContext $storagecontext

# copy all blobs in new container
Get-AzStorageBlob -Container $sourcecontainername -Context $storagecontext | Start-CopyAzureStorageBlob -DestContainer $destcontainername -DestContext $storagecontext -force

# Listing blobs in an Azure storage container

# list the blobs in the destination container

(Get-AzStorageContainer -Name $destcontainername -Context $storagecontext).CloudBlobContainer.ListBlobs()

# Modifying blob access tier

# Get the blob reference 
$blob = Get-AzStorageBlob -Blob *Logfile4* -Container $sourcecontainername -Context $storagecontext

#Get current access tier
$blob

#change access tier to cool
$blob.ICloudBlob.SetStandardBlobTier("Cool")

#Get the modified access tier
$blob


# Change the access tier of all the blobs in a container

#get blob reference
$blobs = Get-AzStorageBlob -Container $destcontainername -Context $storagecontext

#change the access tier of all the blobs in the container
$blobs.icloudblob.setstandardblobtier("Cool")

#verify the access tier
$blobs


# Downloading blob

#get the storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

#download the blob

# Name of the blob to be downloaded
$blob = "Logfile1"
Get-AzStorageBlobContent -Blob "Logfile1" `
						 -Container $sourcecontainername `
						 -Destination C:\ADECookbook\Chapter1\Logfiles\ `
						 -Context $storagecontext -Force
						 
# Deleting blob

#get the storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

# name of the blob to be removed
$blob="Logfile2"

#remove blob
Remove-AzStorageBlob -Blob $blob -Container $sourcecontainername -Context $storagecontext


