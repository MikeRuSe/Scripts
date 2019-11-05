"Hola" > ficheronuevo.txt
$permisos = Get-Acl .\fichero.txt
Set-Acl .\ficheronuevo.txt -AclObject $permisos