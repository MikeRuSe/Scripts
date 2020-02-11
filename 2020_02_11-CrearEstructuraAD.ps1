Write-Host "Introduzca a que OU pertenecerá" -ForegroundColor Magenta
$ou=Read-Host "OU"
Write-Host "Introduzca a que grupo pertenecerá" -ForegroundColor Magenta
$group=Read-Host "Grupo"
Write-Host "Introduzca el nombre de usuario" -ForegroundColor Magenta
$user=Read-Host "Usuario"
Write-Host "Introduzca la contraseña 'tipo 8 carácteres con letras, numeros y caracteres especiales'" -ForegroundColor Magenta
$pass=Read-Host "Contraseña"
"$ou,$group,$user,$pass" >> crear.csv


foreach($vars in (gc crear.csv)){
    $OU= $vars.split(",")[0]
    $grupo= $vars.split(",")[1]
    $usuario= $vars.split(",")[2]
    $contraseña= $vars.split(",")[3]
    Clear
New-ADOrganizationalUnit -Name $OU -ProtectedFromAccidentalDeletion $false -Path "DC=Andel,DC=local"
    Clear
    Write-Host "Creando OU    " -ForegroundColor Yellow -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 80; Write-Host "." -ForegroundColor Green -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 100; Write-Host "." -ForegroundColor Green -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 100; Write-Host "." -ForegroundColor Green -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 80; Write-Host "." -ForegroundColor Green -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 100; Write-Host "." -ForegroundColor Green -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 100; Write-Host "." -ForegroundColor Green -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 100; Write-Host "." -ForegroundColor Green -NoNewline;
New-ADuser -name $vars.split(",")[2] -sam $vars.split(",")[2] -accountpassword (convertto-securestring $contraseña -asplaintext -force) -enable $true
    Write-Host "Usuario '$usuario' creado " -ForegroundColor Green
New-ADGroup -name $grupo -GroupScope Global -Path "OU=$OU,DC=Andel,DC=local"
    Write-Host "Grupo '$grupo' creado " -ForegroundColor Green
Add-ADGroupMember $vars.split(",")[1] -Members $vars.split(",")[2]
    Write-Host "Usuario '$usuario' se introdujo dentro del grupo '$grupo' " -ForegroundColor Yellow
    }
    Start-Sleep -Milliseconds 100
