# Loading data in SQL Pool using Polybase with T-SQL

# Set parameters
param(
$resourcegroupname = "packtade",
$storageaccountname = "azadedls",
$location = "central us",
$directory  = "C:\ADE\azure-data-engineering-cookbook\Chapter5\Data2"
)



#Get Azure Data Lake Storage account
$dlsa = Get-AzStorageAccount -Name $storageaccountname -resourcegroupname $resourcegroupname

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
Get-AzStorageBlob -Container ecommerce -Context $dlsa.Context | Format-Table



