# Create service principal 
param(
[string]$resourcegroupname,
[string]$password
)

$startdate = Get-Date
$enddate = $startdate.AddYears(1)
$sp = New-AzADServicePrincipal `
		-DisplayName hdinsightsp `
		-StartDate $startdate `
		-EndDate $enddate `
		-Role 'Contributor'  `
		-Scope /subscriptions/b85b0984-a391-4f22-a832-fb6e46c39f38/resourceGroups/$resourcegroupname


$sp

$pwd = ConvertTo-SecureString -String $password -AsPlainText -Force
# Create service principal credentials
New-AzADAppCredential -ApplicationId $sp.ApplicationId -Password $pwd -startdate $startdate -enddate $enddate
	



