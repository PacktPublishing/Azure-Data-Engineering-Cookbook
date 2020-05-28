# Provisioning Azure MySql Database
# Azure CLI is required for this recipe


# login to Azure CLI
az login

# create a new resource group
az group create --name rgmysql --location eastus

# create Azure server for MySql
az mysql server create --resource-group rgmysql --name ademysqlserver  --location eastus --admin-user dbadmin --admin-password mySQL@1234 --sku-name B_Gen5_1

# whitelist the client/host public IP
$clientip = (Invoke-RestMethod -Uri https://ipinfo.io/json).ip

az mysql server firewall-rule create --resource-group rgmysql --server ademysqlserver --name clientIP --start-ip-address $clientip --end-ip-address $clientip

# To connect to MySQL db, we can use MySQL workbench, mysql command line utility or any third party utility.
# specify the server name as <yourmysqlservername>.mysql.database.azure.com 

