# Implementing vertical scaling for an Azure SQL Database using PowerShell

#Create an Azure automation account
$automation = New-AzAutomationAccount -ResourceGroupName packtade -Name adeautomate -Location centralus -Plan Basic

#Create a new automation runbook of type PowerShell workflow
$runbook = New-AzAutomationRunbook 	-Name rnscalesql `
									-Description "Scale up sql azure when CPU is 40%" `
									-Type PowerShellWorkflow `
									-ResourceGroupName packtade `
									-AutomationAccountName $automation.AutomationAccountName
									
								#Create automation credentials.

$sqladminpassword = ConvertTo-SecureString 'Sql@Server@1234' -AsPlainText -Force
$sqladmincredential = New-Object System.Management.Automation.PSCredential ('sqladmin', $sqladminpassword)
$creds = New-AzAutomationCredential -Name sqlcred `
									-Description "sql azure creds" `
									-ResourceGroupName packtade `
									-AutomationAccountName $automation.AutomationAccountName `
									-Value $sqladmincredential

# Follow the steps from the document to edit and add the powershell code to scale an azure sql database. 

# define the runbook parameters
$Params = @{"SQLSERVERNAME"="azadesqlserver";"DATABASENAME"="azadesqldb";"CREDENTIAL"="sqlcred"}
# Create a webhook
$expiry = (Get-Date).AddDays(1)  
New-AzAutomationWebhook -Name whscaleazure `
						-RunbookName $runbook.Name `
						-Parameters $Params `
						-ResourceGroupName packtade `
						-AutomationAccountName $automation.AutomationAccountName `
						-IsEnabled $true `
						-ExpiryTime $expiry

# Note the webhookURI as it's not available once the session window is closed.
$whr = New-AzActionGroupReceiver -Name agrscalesql `
								 -WebhookReceiver `
								 -ServiceUri "https://s25events.azure-automation.net/webhooks?token=NfL30nj%2fkuSo8TTT7CqDwRIWEdeXR1lklkK%2fzgELCiY%3d"

#Create a new action group.
$ag = Set-AzActionGroup -ResourceGroupName packtade -Name ScaleSQLAzure -ShortName scaleazure -Receiver $whr

#define the alert trigger condition
$condition = New-AzMetricAlertRuleV2Criteria  -MetricName "cpu_percent" `
											  -TimeAggregation maximum `
											  -Operator greaterthan `
											  -Threshold 40 `
											  -MetricNamespace "Microsoft.Sql/servers/databases"

#Create the alert with the condition and action defined in previous steps.
$rid = (Get-AzSqlDatabase -ServerName azadesqlserver -ResourceGroupName packtade -DatabaseName azadesqldb).Resourceid
Add-AzMetricAlertRuleV2 -Name monitorcpu `
						-ResourceGroupName packtade `
						-WindowSize 00:01:00 `
						-Frequency 00:01:00 `
						-TargetResourceId $rid `
						-Condition $condition  `
						-Severity 1 `
						-ActionGroupId $ag.id
						





			 




