##Crear la estructura de red del Centro leyendo de un fichero, teniendo en cuenta:
#Hay seis grupos de clases, seis unidades organizativas
#Hay que crear usuarios y grupos para cada clase
#Hay que deshabilitar usuarios y moverlos a la unidad organizativa de los deshabilitados
#Borrar unidades organizativas
##Una vez creada la estructura y los usuarios funcionando (crear funciones para cada punto):
#Para cada usuario instalar el software que te parezca
#Para un usuario controlar la impresión que realiza
#Para cada usuario controlar que no ejecuta más de 10 procesos
#Realizar una copia de seguridad cada vez que se modifica el fichero
#El fichero con la estructura viene de una carpeta compartida (acceso remoto a la máquina)


## Crear estructuras Unidades Organizativas:
New-ADOrganizationalUnit -Name "Andel" -ProtectedFromAccidentalDeletion $false -Path "DC=Andel,DC=local"
Write-Host "Unidad Organizativa 'Andel' creada " -ForegroundColor Cyan

'SMIR1','SMIR2', 'ITEL1', 'ITEL2', 'ASIR1', 'ASIR2' > ou.txt

foreach($OU in (gc ou.txt)){
    New-ADOrganizationalUnit -Name "$OU"  -ProtectedFromAccidentalDeletion $false -Path "OU=Andel,DC=Andel,DC=local"
    Write-Host "Unidad Organizativa '$OU' creada " -ForegroundColor Cyan

}

'SMIR1,User10','SMIR1,User20', 'SMIR1,User30', 'SMIR1,User40', 'SMIR1,User50' > user.txt
'SMIR2,User11','SMIR2,User21', 'SMIR2,User31', 'SMIR2,User41', 'SMIR2,User51' >> user.txt
'ITEL1,User12','ITEL1,User22', 'ITEL1,User32', 'ITEL1,User42', 'ITEL1,User52' >> user.txt
'ITEL2,User13','ITEL2,User23', 'ITEL2,User33', 'ITEL2,User43', 'ITEL2,User53' >> user.txt
'ASIR1,User14','ASIR1,User24', 'ASIR1,User34', 'ASIR1,User44', 'ASIR1,User54' >> user.txt
'ASIR2,User15','ASIR2,User25', 'ASIR2,User35', 'ASIR2,User45', 'ASIR2,User55' >> user.txt

foreach($vars in (gc user.txt)){
    New-ADuser -name $vars.split(",")[1] -sam $vars.split(",")[1] -accountpassword (convertto-securestring "Andel_2020" -asplaintext -force) -enable $true
    $usuario= $vars.split(",")[1]
    Write-Host "Usuario '$usuario' creado " -ForegroundColor Green
    $VAR= $vars.split(",")[0]
    New-ADGroup -name $vars.split(",")[0] -GroupScope Global -Path "OU=$VAR,OU=Andel,DC=Andel,DC=local"
    Write-Host "Grupo '$VAR' creado " -ForegroundColor Green
    Add-ADGroupMember $vars.split(",")[0] -Members $vars.split(",")[1]
    Write-Host "Usuario '$usuario' se introdujo dentro del grupo '$VAR' " -ForegroundColor Yellow
    }

## Importamos el módulo:
Import-Module SmbShare
Write-Host "Módulo importado" -ForegroundColor Cyan

## Creamos una carpeta para cada Usuario y la compartimos
foreach($usuario in (gc user.txt)){
    $usuario= $usuario.split(",")[1]
    New-Item "C:\Users\Service_Users\$usuario" -ItemType Directory -Force
    Write-Host "Carpeta del usuario creada" -ForegroundColor Green
    New-SMBShare –Name $usuario –Path C:\Users\Service_Users  -Description "Carpeta compartida de $usuario"
    Write-Host "Carpeta del usuario compartida" -ForegroundColor Green
    }

#############################
## DESHABILITADOS 


'SMIR1,User10','SMIR1,User20', 'SMIR1,User30', 'SMIR1,User40', 'SMIR1,User50' > user.txt
foreach($vars in (gc user.txt)){
    Disable-ADAccount -Identity $vars.split(",")[1] 
    $cuenta= $vars.split(",")[1] 
    Write-Host "Cuenta '$cuenta' DESHABILITADA" -ForegroundColor Red
    }

New-ADOrganizationalUnit -Name "Deshabilitados"  -ProtectedFromAccidentalDeletion $false -Path "OU=Andel,DC=Andel,DC=local"
foreach($vars in (gc user.txt)){
    $var= $vars.split(",")[1]
    Move-ADObject "CN=$var,CN=Users,DC=Andel,DC=local" -TargetPath "OU=Deshabilitados,OU=Andel,DC=Andel,DC=local"
    }

#############################
## BORRADOS:

Remove-ADOrganizationalUnit "OU=Andel,DC=Andel,DC=local" -Recursive
Write-Host "Unidad Organizativa 'Andel' borrada " -ForegroundColor Red

################################################
################################################
###############   EXTRA   ######################
################################################
################################################

## Instalar software
## Invoke-Command NombreDelPC -ErrorAction Stop -ScriptBlock{Install-Package -Name "C:\Windows\Installer\12df2aa.msi" -force} 
Install-Package -Name "C:\Windows\Installer\12df2aa.msi" -force
Get-AppxPackage -AllUsers



## Contar procesos de un usuario
## Invoke-Command NombreDelPC -ErrorAction Stop -ScriptBlock{ (Get-Process -IncludeUserName | Where-Object {$_.username -match "Administrador"}).count } 
$procesos= (Get-Process -IncludeUserName | Where-Object {$_.username -match "Administrador"}).count
if ($procesos -gt 10){
    ([System.Windows.MessageBox]::Show("CIERRA APPS QUE ESTAS CONSUMIENDO MUCHA ENERGIA", 'No mas de 10 procesos simultáneos'))
    }

## Impresion
foreach ($impresora in Get-Printer)
{
    foreach ($trabajo in Get-PrintJob $impresora.Name)
    {
        if($trabajo.Size -gt 1kb)
        {
            if($trabajo.UserName -EQ "administrador")
            {
                "ES MAYOR, LO ELIMINO"
                $trabajo.Id
                Remove-PrintJob -ID $trabajo.Id -PrinterName $impresora.Name
                    ([System.Windows.MessageBox]::Show("Recuerda que no debes impromir archivos de mas de 1kb", 'Error de impresión'))

            }
        }
    }
}

## Copias de seguridad
dir c:/hola -r | ? {!($_.psiscontainer) -AND $_.lastwritetime -gt (get-date).date} | % {Copy-Item -path $_.fullname -destination /hola1}
