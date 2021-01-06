<#
Connect-AzAccount
Follow the instructions to login to the Azure account.
#>
#Create a new resource group
New-AzResourceGroup -Name Packtade-powershell -Location 'East US'

# Create a new Azure Storage Account
New-AzStorageAccount -ResourceGroupName Packtade-powershell `
	-Name packtstoragepowershell `
	-SkuName Standard_LRS `
	-Location 'East US' `
	-Kind StorageV2 `
	-AccessTier Hot

