workflow rnscalesql

{ 

    param 

    ( 

        # Name of the Azure SQL Database server (Ex: bzb98er9bp) 

        [parameter(Mandatory=$true)]  

        [string] $SqlServerName, 

 

        # Target Azure SQL Database name  

        [parameter(Mandatory=$true)]  

        [string] $DatabaseName, 

 

        # When using in the Azure Automation UI, please enter the name of the credential asset for the "Credential" parameter 

        [parameter(Mandatory=$true)]  

        [PSCredential] $Credential 

    ) 

     

    inlinescript 

    { 

        $ServerName = $Using:SqlServerName + ".database.windows.net"

        $db = $Using:DatabaseName

        $UserId = $Using:Credential.UserName 

        $Password = ($Using:Credential).GetNetworkCredential().Password 

        $ServerName

        $db

        $UserId

        $Password

        $MasterDatabaseConnection = New-Object System.Data.SqlClient.SqlConnection 

        $MasterDatabaseConnection.ConnectionString = "Server = $ServerName; Database = Master; User ID = $UserId; Password = $Password;" 

        $MasterDatabaseConnection.Open(); 

        

        $MasterDatabaseCommand = New-Object System.Data.SqlClient.SqlCommand 

        $MasterDatabaseCommand.Connection = $MasterDatabaseConnection 

        $MasterDatabaseCommand.CommandText =  

            " 

       

                ALTER DATABASE $db MODIFY (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0');

                

            " 

        

        $MasterDbResult = $MasterDatabaseCommand.ExecuteNonQuery();

    } 

}

