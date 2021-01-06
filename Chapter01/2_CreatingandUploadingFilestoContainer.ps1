# Creating a new container in an Azure Storage Account

$storageaccountname="packtadestorage"
$containername="logfiles"
$resourcegroup="packtade"

#Get the Azure Storage account context
$storagecontext = (Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccountname).Context;

#Create a new container
New-AzStorageContainer -Name $containername -Context $storagecontext

#upload single file to container

#change the file path and blob name
$file = "C:\ADECookbook\Chapter01\Logfiles\Logfile1.txt"
$blob = "Logfile1.txt"
Set-AzStorageBlobContent -File $file -Context $storagecontext -Blob $blob -Container $containername


#uploading multiple files to a container

$directory  = "C:\ADECookbook\Chapter1\Logfiles"
#get files to be uploaded from the directory
$files = Get-ChildItem -Path $directory

#iterate through each file int the folder and upload it to the azure container

foreach($file in $files){

    Set-AzStorageBlobContent -File $file.FullName -Context $storagecontext -Blob $file.BaseName -Container $containername -Force

}


