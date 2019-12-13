# Mandar y ejecutar un comando de powershell mediante el protocolo TCP desde Linux a un Servidor Windows
## Fichero necesario en Linux:
  
  ```Bash PowerShell_Command.txt
  nano PowerShell_Command.txt
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
