
$Titulo = 'FIREWALL RULES by www.github.com/MikeRuSe'
Clear-Host
    Write-Host "                " -NoNewline; Write-Host "====================== $Titulo ======================" -ForegroundColor Gray
    Write-Host " "
    Write-Host "                                                    " -NoNewline;Write-Host "¿Qué desea analizar?" -ForegroundColor Green
    Write-Host " "
    Write-Host "                 " -NoNewline; Write-Host " Presione '1' borrar cola de la impresora" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '2' una conexion ssh" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '3' crear regla de firewall" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione otra tecla para salir" -ForegroundColor Red
    Write-Host " "
# Comienzo del script:
    Start-Sleep -Milliseconds 200
$opcion= Read-Host "Introduzca un valor"
if($opcion -eq 1){
    $web= iwr ("http://10.202.0.122/PHP_clase/examen/5.php?enviar=firewall")
    $datos= ($web.AllElements | Where Class -eq “lol” | %{$_.innerText})
    if($datos.TrimEnd() -eq "10"){
        foreach($impresora in Get-Printer){ 
        foreach ($cola in (Get-PrintJob -PrinterName $impresora.Name)){
            if ($cola.size -gt $datos.TrimEnd()+"Kb"){
                if($cola.UserName -eq "administrador"){
                    Remove-PrintJob -ID $cola.id -PrinterName "Brother Color Leg Type1 Class Driver"
                }
            }
            else{}
          }
       }
       Get-PrintJob "Brother Color Leg Type1 Class Driver"
   }
}
elseif($opcion -eq 2){
        $web= iwr ("http://10.202.0.122/PHP_clase/examen/5.php?enviar=connection")
        $ip= ($web.AllElements | Where Class -eq “lol” | %{$_.innerText})
            $user= Read-Host "USER"
            $ip = $ip.TrimEnd()
            #ping $ip
            ssh $user@$ip
            }
elseif($opcion -eq 3){
        $web= iwr ("http://10.202.0.122/PHP_clase/examen/5.php?enviar=firewall")
        $puerto= ($web.AllElements | Where Class -eq “lol” | %{$_.innerText})
            ## Crear la regla de firewall:
            $puerto= $puerto.TrimEnd()
            New-NetFirewallRule -DisplayName bloqueo -Action Block -Direction Inbound -Enabled True -Protocol UDP -LocalPort $puerto
            }
else {quit}
