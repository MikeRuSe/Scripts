$Titulo = 'FIREWALL RULES by www.github.com/MikeRuSe'
Clear-Host
    Write-Host "                " -NoNewline; Write-Host "====================== $Titulo ======================" -ForegroundColor Gray
    Write-Host " "
    Write-Host "                                                    " -NoNewline;Write-Host "¿Qué desea analizar?" -ForegroundColor Green
    Write-Host " "
    Write-Host "                 " -NoNewline; Write-Host " Presione '1' crear una regla de firewall" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '2' para activar una regla del firewall" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '3' para ver logs del firewall" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '4' para desactivar una regla del firewall" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione otra tecla para salir" -ForegroundColor Red
    Write-Host " "
# Comienzo del script:
    Start-Sleep -Milliseconds 200
$opcion= Read-Host "Introduzca un valor"

if ($opcion -eq 1){
$nombre= Read-Host "NOMBRE DE LA REGLA"
$accion= Read-Host "ACCIÓN - Block o Allow"
$direccion= Read-Host "DIRECCIÓN - Inbound u Outbound"
$protocolo= Read-Host "PROTOCOLO - ICMPv4, TCP, UDP..."

## Crear la regla de firewall:
New-NetFirewallRule -DisplayName $nombre -Action $accion -Direction $direccion -Enabled True -Protocol $protocolo
}
elseif ($opcion -eq 2){
$nombre= Read-Host "NOMBRE DE LA REGLA"

## Habilitar la regla:
Enable-NetFirewallRule -Name $nombre
}
elseif ($opcion -eq 3){
## Ver logs:
$block= ((get-content C:\Windows\System32\LogFiles\Firewall\pfirewall.log).count - 6)
Write-Host "Se han bloqueado $block paquetes" -ForegroundColor Green
[System.Windows.MessageBox]::Show("Se han bloqueado $block paquetes", 'Firewall by MikeRuSe')
}
elseif ($opcion -eq 4){
$nombre= Read-Host "NOMBRE DE LA REGLA"

## Deshabilitar la regla del firewall:
Disable-NetFirewallRule -Name $nombre
}
else { Write-Host "No ha seleccionado nada"}
