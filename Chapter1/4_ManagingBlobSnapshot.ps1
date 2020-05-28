# Managing blob Snapshot

#set the parameter values
$storageaccountname="packtadestorage"
$resourcegroup="packtade"
$sourcecontainername ="logfiles"

# Creating blob snapshot

#get the storage context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context

#get blob context
$blob = Get-AzStorageBlob -Blob *Logfile5* -Container $sourcecontainername -Context $storagecontext

#create blob snapshot
$blob.ICloudBlob.CreateSnapshot()


#listing blob snapshots

# get blobs in a container
$blobs = Get-AzStorageBlob -Container $sourcecontainername -Context $storagecontext

#list snapshots
$blobs | Where-Object{$_.ICloudBlob.IsSnapshot -eq $true}


# Promoting snapshot

#get reference of original blob
$blob = Get-AzStorageBlob -Blob *Logfile5* -Container $sourcecontainername -Context $storagecontext
$originalblob = $blob | Where-Object{$_.ICloudBlob.IsSnapshot -eq $false}

#get reference of the blob snapshot
$blobsnapshot = $blob | Where-Object{$_.ICloudBlob.IsSnapshot -eq $true}

#overwrite the original blob with the snapshot
Start-CopyAzureStorageBlob -CloudBlob $blobsnapshot.ICloudBlob -DestCloudBlob $originalblob.ICloudBlob -Context $storagecontext -Force

# Deleting blob snapshot
Remove-AzStorageBlob -CloudBlob $originalblob.ICloudBlob -DeleteSnapshot -Context $storagecontext
