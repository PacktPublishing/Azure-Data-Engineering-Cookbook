# Azure CLI is required to perform the steps in this recipe.

# login to Azure CLI
az login

# create a new resource group
az group create --name rgpgressql --location eastus

# create Azure Server for PostgreSQL
az postgres server create --resource-group rgpgressql --name adepgresqlserver  --location eastus --admin-user pgadmin --admin-password postgre@SQL@1234 --sku-name B_Gen5_1

# whitelist the client/host public IP in Azure PostgreSQL Server firewall
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip

az postgres server firewall-rule create --resource-group rgpgressql --server adepgresqlserver --name hostip --start-ip-address $clientip --end-ip-address $clientip

<# Connecting to Azure Server for PostgreSQL using psql.exe
Switch the directory to psql.exe path
CD C:\Program Files\PostgreSQL\12\bin
# Execute the below command
.\psql.exe --host=adepgresqlserver.postgres.database.azure.com --port=5432 --username=pgadmin@adepgresqlserver --dbname=postgres
#>