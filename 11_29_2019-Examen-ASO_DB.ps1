# Obtener los usuarios de una base de datos y crearlos en windows server
## Conexión a la base de datos
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$ConnectionString = "server=" + "localhost" + ";port=3306; uid=" + "root" + ";database="+"webwp"
$Connection.ConnectionString = $ConnectionString

## Query de usuario
$Connection.Open()
$Query='SELECT user_login FROM `wp_users`'
$Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
$DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
$DataSet = New-Object System.Data.DataSet
$RecordCount = $dataAdapter.Fill($dataSet, "data")
$user= ($DataSet.Tables[0] |ft -HideTableHeaders)
$Connection.Close() 

## Query de contraseña
$Connection.Open()
$Query='SELECT user_pass FROM `wp_users`'
$Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
$DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
$DataSet = New-Object System.Data.DataSet
$RecordCount = $dataAdapter.Fill($dataSet, "data")
$pass= ($DataSet.Tables[0] |ft -HideTableHeaders)
$Connection.Close() 

## Unimos usuario y contraseña en un fichero separado por un espacio
$user + " " + $pass > users.txt

##Creamos el usuario con su contraseña
$nombreypass = (gc .\users.txt)
foreach ($create in $nombreypass){
        # Crea un usuario en un lugar determinado
        $user= $create.split(" ")[0]
        $pass= $create.split(" ")[1]
        New-ADUSer -Name "$user" -Sam $user -Path "OU=uo1,DC=Andel,DC=Local" -AccountPassword (ConvertTo-SecureString "$pass passwor0001" -AsPlainText -force) -Enable $true
        echo "usuario $user creado correctamente"
    }
## Registro errores
$ErrorActionPreference = "Stop"
Get-Childitem "C:\" -ErrorAction "Inquire"

# Monitorización
## PROCESOS
for(1)
{
    "###****************###" >> monitorizar.txt
    Get-Date >> monitorizar.txt
    Get-Process | select Name,Threads | %{
        $_.Name + "---->" + ($_.Threads).id.count >> monitorizar.txt
    }
    Start-Sleep -Seconds 5
}
## SERVICIOS
for(1)
{
    "###****************###" >> monitorizar_servicios.txt
    Get-Date >> monitorizar_servicios.txt
    Get-Service | select Name,Status | %{
        $_.Name + "---->" + $_.Status >> monitorizar_servicios.txt
    }
    Start-Sleep -Seconds 5
}