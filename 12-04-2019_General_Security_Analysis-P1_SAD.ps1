### PARTE 1

## Analisis de seguridad general:
Write-Host "¿Que desea analizar?" -ForegroundColor Green
Start-Sleep -Milliseconds 200
Write-Host "
1 Updates
2 Virus
3 Contraseñas
4 Ping a un puerto
5 Updates y virus
Otro: Nada
" -ForegroundColor Magenta
Start-Sleep -Milliseconds 200
$opcion= Read-Host "Introduzca un valor"
If ($opcion -eq "1"){
    Write-Host "Updates" -ForegroundColor Cyan
    Start-Sleep -Milliseconds 800
    # Updates
    Get-HotFix | Select-Object Description
    Write-Host "Número de actualizaciones" -ForegroundColor Green
    (Get-HotFix).Description.count
    }
    else{
If ($opcion -eq "2"){
    Write-Host "Virus" -ForegroundColor Cyan
    Start-Sleep -Milliseconds 800
    # Antivirus
    Start-MpScan
    (Get-MpThreatCatalog).ThreatName
    }
    else{
If ($opcion -eq "3"){
    ## Realizar un script que avise sobre el uso de contraseñas inseguras.
        Write-Host "Vamos a comprobar la seguridad de tu contraseña" -ForegroundColor Magenta
        $pass= read-host "Introduce la contraseña"
        If ($pass.Length -le 3) {
            Write-Host "La contraseña no es segura" -ForegroundColor Red
            Start-Sleep -Seconds 1
                Write-Host "Sugerencia de contraseña segura:" -ForegroundColor Yellow
                $Assembly = Add-Type -AssemblyName System.Web
                [System.Web.Security.Membership]::GeneratePassword(30,9) 
                }
        Else {
            Write-Host "La contraseña es segura (nivel 1)" -ForegroundColor Green
            Start-Sleep -Milliseconds 500
            Write-Host "Hacemos un segundo analisis por fuerza bruta?" -ForegroundColor Magenta
            $segundo= (read-host "si/no")
            if ($segundo -eq "si"){
                Write-Host "Vamos a comprobar la seguridad de tu contraseña con HashCat" -ForegroundColor Magenta
                cd A:\Programas\hashcat-5.1.0 
                $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
                $utf8 = new-object -TypeName System.Text.UTF8Encoding
                $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($pass)))
                $hash = $hash.ToLower() -replace '-', ''
                .\hashcat64.exe -m 0 -a 0 $hash rockyou.txt
                $resultado= (Get-Content .\hashcat.potfile)
                $resultado = $resultado -replace "$hash", ''
                $resultado = $resultado -replace ':', ''
                $resultado
                }
            else {
                Write-Host "Tu contraseña no es 100% segura" -ForegroundColor Yellow
                }
        }

    }
    else{
If ($opcion -eq "4"){
    ## Realizar un script que compruebe un puerto en un servidor.
    Write-Host "Script que comprueba un puerto en un servidor" -ForegroundColor Magenta

    $ip= Read-Host "Introduce el servidor o la dirección IP:" 
    $port= Read-Host "Puerto" 
    Write-Host "Dirección IP introducida:	$ip" -ForegroundColor DarkGreen 
    Write-Host "Puerto TCP introducida:	$port" -ForegroundColor DarkGreen 
    $connection = new-object net.Sockets.TcpClient
    try 
    {
	    $connection.connect($ip,$port)
	    $connection.close()
	    Write-Host "Puerto $port abierto" -ForegroundColor Green
    }
    catch
    {
    	Write-Host "Puerto $port cerrado" -ForegroundColor Red
    }
}
else{
If ($opcion -eq "5"){
    # Updates
    Start-Sleep -Milliseconds 800
    Get-HotFix | Select-Object Description
    # Antivirus
    Start-Sleep -Milliseconds 800
    Start-MpScan
    Write-Host "Updates" -ForegroundColor Cyan
    (Get-HotFix).Description
    Start-Sleep -Seconds 5
    Write-Host "Virus" -ForegroundColor Cyan
    (Get-MpThreatCatalog).ThreatName

    }
    else{
Else {
    Write-Host "No se analizará nada" -ForegroundColor Red
     }
    }
   }
  }
 }
}
    
   
