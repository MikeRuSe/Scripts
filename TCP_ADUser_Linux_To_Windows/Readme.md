# Mandar y ejecutar un comando de powershell mediante el protocolo TCP desde Linux a un Servidor Windows
## Fichero necesario en Linux:
  ### PowerShell_Command.txt
  ```Bash 
  nano PowerShell_Command.txt
  ```
  ### Guardar lo siguiente en PowerShell_Command.txt
  ```Bash
  New-ADUser -Name "Pedro Jimenez" -GivenName "Peter" -Surname "Jimenez" -SamAccountName "P.Jimenez" -UserPrincipalName "Pedro.Jimenez@prueba.es" -Path "OU=uo1,DC=Andel,DC=Local" -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $true
  ```
## Ejecutar el listener en el Servidor de Windows en el que vamos a crear usuarios
```PowerShell
#Server
$ip=[IPAddress]"0.0.0.0"
$TcpListener=New-Object System.Net.Sockets.TcpListener (New-Object System.Net.IPEndPoint($ip,"5555"))
$TcpListener.Start()

while($true)
{
$mensaje=(New-Object System.IO.StreamReader ($TcpListener.AcceptTcpClient().GetStream())).ReadLine()
$mensaje | iex
}
$TcpListener.Stop()
```
## Comando que debemos ejecutar en linux una vez cumplido los pasos anteriores:
```Bash
cat PowerShell_Command.txt > /dev/tcp/Ip_Servidor_Windows/5555
```
