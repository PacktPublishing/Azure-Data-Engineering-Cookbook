param (
$resourcegroupname = "packtade",
$location = "centralus",
$datafactoryname = "packtdatafactory"
)


Set-AzDataFactoryV2 -Name $datafactoryname -resourcegroupname $resourcegroupname -location $location