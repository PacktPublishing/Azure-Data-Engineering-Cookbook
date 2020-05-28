# Securing Azure Storage Account with Shared Access Signatures

# Set parameter values
$resourcegroup = "packtade"
$storageaccount = "packtadestorage"
$blobname = "logfile1.txt"
$containername = "logfiles"

# securing blobs with SAS

#get storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccount).Context

#set the token expiry time
$starttime = Get-Date
$endtime = $starttime.AddDays(1)

# get the SAS token into a variable
$sastoken = New-AzStorageBlobSASToken -Container "logfiles" -Blob "logfile1.txt" -Permission lr -StartTime $starttime -ExpiryTime $endtime -Context $storagecontext # view the SAS token.

$sastoken

#get storage account context using the SAS token
$ctx = New-AzStorageContext -StorageAccountName $storageaccount -SasToken $sastoken

#list the blob details

Get-AzStorageBlob -blob $blobname  -Container $containername -Context $ctx

# upload blob
$file = "C:\ADECookbook\Chapter1\Logfiles\Logfile1.txt"
# This will error out as the SAS token only has read access
Set-AzStorageBlobContent -File $file -Container $containername -Context $ctx


# Securing container with SAS   


#get storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccount).Context

# set the SAS expiry time
$starttime = Get-Date
$endtime = $starttime.AddDays(1)
# create container access policy
New-AzStorageContainerStoredAccessPolicy -Container $containername `
										 -Policy writepolicy `
										 -Permission lw `
										 -StartTime $starttime `
										 -ExpiryTime $endtime `
										 -Context $storagecontext


# get the SAS token
$sastoken = New-AzStorageContainerSASToken -Name $containername -Policy writepolicy -Context $storagecontext

#get the storage context with SAS token
$ctx = New-AzStorageContext -StorageAccountName $storageaccount -SasToken $sastoken



#list blobs using SAS token
Get-AzStorageBlob -Container logfiles -Context $ctx



