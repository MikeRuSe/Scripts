## Crear fichero:

Write-Host "Introduzca a que OU pertenecerá" -ForegroundColor Magenta
$ou=Read-Host "OU"
Write-Host "Introduzca a que grupo pertenecerá" -ForegroundColor Magenta
$group=Read-Host "Grupo"
Write-Host "Introduzca el nombre de usuario" -ForegroundColor Magenta
$user=Read-Host "Usuario"
Write-Host "Introduzca la contraseña 'tipo 8 carácteres con letras, numeros y caracteres especiales'" -ForegroundColor Magenta
$pass=Read-Host "Contraseña"
"$ou,$group,$user,$pass" >> crear.csv

#-----------------------------------------------------------------------------------------------------------#


## Fichero ya creado:

'Andel,SMIR1,User10,Andel_2020','Andel,SMIR1,User20,Andel_2020', 'Andel,SMIR1,User30,Andel_2020', 'Andel,SMIR1,User40,Andel_2020', 'Andel,SMIR1,User50,Andel_2020' > create.csv
'Andel,SMIR2,User11,Andel_2020','Andel,SMIR2,User21,Andel_2020', 'Andel,SMIR2,User31,Andel_2020', 'Andel,SMIR2,User41,Andel_2020', 'Andel,SMIR2,User51,Andel_2020' >> create.csv
'Andel,ITEL1,User12,Andel_2020','Andel,ITEL1,User22,Andel_2020', 'Andel,ITEL1,User32,Andel_2020', 'Andel,ITEL1,User42,Andel_2020', 'Andel,ITEL1,User52,Andel_2020' >> create.csv
'Andel,ITEL2,User13,Andel_2020','Andel,ITEL2,User23,Andel_2020', 'Andel,ITEL2,User33,Andel_2020', 'Andel,ITEL2,User43,Andel_2020', 'Andel,ITEL2,User53,Andel_2020' >> create.csv
'Andel,ASIR1,User14,Andel_2020','Andel,ASIR1,User24,Andel_2020', 'Andel,ASIR1,User34,Andel_2020', 'Andel,ASIR1,User44,Andel_2020', 'Andel,ASIR1,User54,Andel_2020' >> create.csv
'Andel,ASIR2,User15,Andel_2020','Andel,ASIR2,User25,Andel_2020', 'Andel,ASIR2,User35,Andel_2020', 'Andel,ASIR2,User45,Andel_2020', 'Andel,ASIR2,User55,Andel_2020' >> create.csv

#-----------------------------------------------------------------------------------------------------------#

## Creación estructura AD según fichero
foreach($vars in (gc create.csv)){
    $OU= $vars.split(",")[0]
    $grupo= $vars.split(",")[1]
    $usuario= $vars.split(",")[2]
    $contraseña= $vars.split(",")[3]
    Clear
New-ADOrganizationalUnit -Name $OU -ProtectedFromAccidentalDeletion $false -Path "DC=Andel,DC=local"; Clear
    #Write-Host "Creando OU    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green
    Start-Sleep -Milliseconds 135
    
New-ADuser -name $usuario -sam $usuario -accountpassword (convertto-securestring $contraseña -asplaintext -force) -enable $true
    #Write-Host "Creando Usuario $usuario    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green 
    Write-Host "Usuario '$usuario' creado " -ForegroundColor Green
    Start-Sleep -Milliseconds 50
    
New-ADGroup -name $grupo -GroupScope Global -Path "OU=$OU,DC=Andel,DC=local"; Clear
    #Write-Host "Creando Grupo $grupo    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green   
    Write-Host "Grupo '$grupo' creado " -ForegroundColor Green
    Start-Sleep -Milliseconds 50
    Clear
Add-ADGroupMember $grupo -Members $usuario
    #Write-Host "Añadiendo el Usuario $usuario al grupo $grupo    " -ForegroundColor Cyan -NoNewline; Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green -NoNewline; Start-Sleep -Milliseconds 150;Write-Host "." -ForegroundColor Green
    Write-Host "Usuario '$usuario' se introdujo dentro del grupo '$grupo' " -ForegroundColor Green; Start-Sleep -Milliseconds 200; Clear
    
New-Item "C:\Users\Service_Users\$usuario" -ItemType Directory -Force
    Write-Host "Carpeta del usuario creada" -ForegroundColor Green; Start-Sleep -Milliseconds 200
New-SMBShare –Name $usuario –Path C:\Users\Service_Users  -Description "Carpeta compartida de $usuario"
    Write-Host "Carpeta del usuario compartida" -ForegroundColor Green; Start-Sleep -Milliseconds 200

    }Start-Sleep -Milliseconds 100; Write-Host "Se ha creado toda la estructura de AD del fichero 'create.csv' " -ForegroundColor Yellow

#-----------------------------------------------------------------------------------------------------------#

## Deshabilitando cuentas
'SMIR1,User10','SMIR1,User20', 'SMIR1,User30', 'SMIR1,User40', 'SMIR1,User50' > user.txt
foreach($vars in (gc user.txt)){
    Disable-ADAccount -Identity $vars.split(",")[1] 
    $cuenta= $vars.split(",")[1] 
    Write-Host "Cuenta '$cuenta' DESHABILITADA" -ForegroundColor Red
    }
    
#-----------------------------------------------------------------------------------------------------------#  

## Creando una Unidad Organizativa a la que se muevan las cuentas deshabilitadas
New-ADOrganizationalUnit -Name "Deshabilitados"  -ProtectedFromAccidentalDeletion $false -Path "OU=Andel,DC=Andel,DC=local"
foreach($vars in (gc user.txt)){
    $var= $vars.split(",")[1]
    Move-ADObject "CN=$var,CN=Users,DC=Andel,DC=local" -TargetPath "OU=Deshabilitados,OU=Andel,DC=Andel,DC=local"
    }

#-----------------------------------------------------------------------------------------------------------#

## Borrado de Unidad Organizativa Recursivo (OUs de la OU, Grupos, Usuarios, ...)

Remove-ADOrganizationalUnit "OU=Andel,DC=Andel,DC=local" -Recursive
Write-Host "Unidad Organizativa 'Andel' borrada " -ForegroundColor Red

$IntroducirIdentidadGrupo= Read-Host "Introducir Identidad Grupo a eliminar"
Remove-ADGroup -Identity $IntroducirIdentidadGrupo
Write-Host "Grupo $IntroducirIdentidadGrupo borrado " -ForegroundColor Red

$IntroducirIdentidadUser= Read-Host "Introducir Identidad User a eliminar"
Remove-ADUser -Identity $IntroducirIdentidadUser
Write-Host "Usuario $IntroducirIdentidadUser borrado " -ForegroundColor Red

#-----------------------------------------------------------------------------------------------------------#


## Impresora (controlar que no se impriman más de 10 archivos)
# Llenado de cola

"hola1" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola2" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola3" | Out-Printer "Brother Color Leg Type1 Class Driver" ; Start-Sleep -Seconds 1
"hola4" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola5" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola6" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola7" | Out-Printer "Brother Color Leg Type1 Class Driver" ; Start-Sleep -Seconds 1
"hola8" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola9" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola10" | Out-Printer "Brother Color Leg Type1 Class Driver"
"hola11" | Out-Printer "Brother Color Leg Type1 Class Driver"

# Función limpieza de cola con límite 10
function impresora {
    if ((Get-PrintJob -PrinterName "Brother Color Leg Type1 Class Driver").count -gt 10){
        $ID= ((Get-PrintJob -PrinterName "Brother Color Leg Type1 Class Driver").Id | select-object -skip 10)
        foreach ($idborrar in $ID){
            Remove-PrintJob -ID $idborrar -PrinterName "Brother Color Leg Type1 Class Driver"
           } 
        ([System.Windows.MessageBox]::Show("Recuerda que no puedes imprimir más de 10 archivos, debes cuidar el medio ambiente :) ", 'Límite de impresión'))
        } 
} impresora

# Función limpieza de cola con límite establecido en el parámetro
function impresora ($limit){
    if ((Get-PrintJob -PrinterName "Brother Color Leg Type1 Class Driver").count -gt $limit){
        $ID= ((Get-PrintJob -PrinterName "Brother Color Leg Type1 Class Driver").Id | select-object -skip $limit)
        foreach ($idborrar in $ID){
            Remove-PrintJob -ID $idborrar -PrinterName "Brother Color Leg Type1 Class Driver"
           } 
        ([System.Windows.MessageBox]::Show("Recuerda que no puedes imprimir más de 10 archivos, debes cuidar el medio ambiente :) ", 'Límite de impresión'))
        } 
} impresora "INTROUCE EL LÍMITE DE ARCHIVOS A IMPRIMIR"

#-----------------------------------------------------------------------------------------------------------#

## Copias de seguridad de carpetas de usuario

# Un solo usuario
function copia-uno ($usuario){
    $ficheroMAIN= "C:\Users\Service_Users\$usuario"
    $ficheroBK= "C:\Users\Service_Users_bk\"
    if($ficheroMAIN.LastWriteTime -gt $ficheroBK.LastWriteTime){
        Copy-Item C:\Users\Service_Users\$usuario C:\Users\Service_Users_bk\ -Recurse -Force -Verbose 
        }
    else{ 
        Write-Host "No hace falta copiar nada" -ForegroundColor Yellow
        }
} copia-uno "INTRODUCE EL USUARIO A COPIAR"


# Todos los usuarios
function copia-todos{
    foreach($vars in (gc create.csv)){
        $usuario= $vars.split(",")[2]
        $ficheroMAIN= "C:\Users\Service_Users\$usuario"
        $ficheroBK= "C:\Users\Service_Users_bk\"
        if($ficheroMAIN.LastWriteTime -gt $ficheroBK.LastWriteTime){
            Copy-Item C:\Users\Service_Users\$usuario C:\Users\Service_Users_bk\ -Recurse -Force -Verbose 
            }
        else{ Write-Host "No hace falta copiar nada" -ForegroundColor Yellow
            }
} copia-todos
