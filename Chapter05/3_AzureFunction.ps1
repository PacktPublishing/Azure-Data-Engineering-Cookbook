using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}
$tenantid = $Request.Body.TenantId
$user = $Request.Body.User
$rg = $Request.Body.ResourceGroupName
$sn = $Request.Body.ServerName
$db = $Request.Body.DatabaseName
$Password = ConvertTo-SecureString -String $Request.Body.Password -AsPlainText -Force
$creds = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user,$password


if ($name) {
    
    Connect-AzAccount -Credential $creds -Tenant $tenantid -ServicePrincipal
    Resume-AzSqlDatabase -ServerName $sn -DatabaseName $db -ResourceGroupName $rg
    #$body = "Hello, $name. This HTTP triggered function executed successfully."
    $dwstatus= (Get-AzSqlDatabase -ResourceGroupName $rg -ServerName $sn -DatabaseName $db).Status

    $body  = "{""Synapse Sql Pool Status"":""$dwstatus""}"
}


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
