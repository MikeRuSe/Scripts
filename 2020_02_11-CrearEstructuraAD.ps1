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
    Write-Host "Creando OU    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green
    Start-Sleep -Milliseconds 1350
    Clear
  New-ADuser -name $usuario -sam $usuario -accountpassword (convertto-securestring $contraseña -asplaintext -force) -enable $true
    Write-Host "Creando Usuario $usuario    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green 
    Write-Host "Usuario '$usuario' creado " -ForegroundColor Green
    Start-Sleep -Milliseconds 1350
    Clear
  New-ADGroup -name $grupo -GroupScope Global -Path "OU=$OU,DC=Andel,DC=local"
    Write-Host "Creando Grupo $grupo    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green   
    Write-Host "Grupo '$grupo' creado " -ForegroundColor Green
    Start-Sleep -Milliseconds 1350
    Clear
  Add-ADGroupMember $grupo -Members $usuario
    Write-Host "Añadiendo el Usuario $usuario al grupo $grupo    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green
    Write-Host "Usuario '$usuario' se introdujo dentro del grupo '$grupo' " -ForegroundColor Green
    Clear
    }
Start-Sleep -Milliseconds 100; Write-Host "SE EJECUTARON TODOS LOS SCRIPTS DE LA SECUENCIA 'FOREACH' " -ForegroundColor Yellow
    
