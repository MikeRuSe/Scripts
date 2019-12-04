#Conexión SSH y comprobación del HASH
New-SSHSession -ComputerName 10.202.0.143 -Credential (Get-Credential)
$md5L= (Invoke-SSHCommand -Index 0 "md5sum users.txt")
$md5s= $md5L.Output
$hash1= ($md5s.split(" ")[0])

Get-SCPFile -LocalFile users.txt -RemoteFile users.txt -ComputerName 10.202.0.143 -Credential (Get-Credential) -Force
$hashW= "C:\Users\Administrador\users.txt"
$hashX= Get-FileHash -LiteralPath $hashW -Algorithm MD5
$hash2= ($hashX.Hash).ToLower()
if($hash1 -eq $hash4){
    $nombreypass = (gc .\users.txt)
    foreach ($create in $nombreypass){
        # Crea un usuario en un lugar determinado
        $user= $create.split(",")[0]
        $pass= $create.split(",")[1]
        New-ADUSer -Name "$user" -Sam $user -Path "OU=uo1,DC=Andel,DC=Local" -AccountPassword (ConvertTo-SecureString "$pass passwor0001" -AsPlainText -force) -Enable $true
        echo "usuario $user creado correctamente"
        mkdir $user -Whatif
    }
}
else{
    echo "El archivo ha sido manipulado"
    }
Remove-SSHSession -SessionId 0
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
