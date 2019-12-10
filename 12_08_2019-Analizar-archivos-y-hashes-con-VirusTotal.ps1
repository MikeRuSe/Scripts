## Buscar el hash de un archivo en VirusTotal
## Testeado y desarrollado en Windows 8.1 Pro y en Windows 10 Pro
## Registrar la API Key: https://www.virustotal.com/gui/join-us
    $VT_API = "key de la api registrada"

## Set TLS 1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Function submit-VTHash($VThash)
{
    $VTcuerpo = @{resource = $VThash; apikey = $VT_API}
    $VTresultado = Invoke-RestMethod -Method GET -Uri 'https://www.virustotal.com/vtapi/v2/file/report' -Body $VTcuerpo

    return $vtResultado
}
Write-Host "¿Que desea analizar?" -ForegroundColor Green
Start-Sleep -Milliseconds 200
Write-Host "
1 Un hash
2 Un archivo
Otro: Nada
" -ForegroundColor Magenta
Start-Sleep -Milliseconds 200
$opcion= Read-Host "Introduzca un valor"
If ($opcion -eq "1"){
        ## Escriba el hash
        Write-Host "Introduzca el código hash" -ForegroundColor Yellow
        $hash= Read-Host "Introduzca un valor"
           # $hash = "ba4038fd20e474c047be8aad5bfacdb1bfc1ddbe12f803f473b7918d8d819436"
    ## Introducimos el hash en la función
    $VTresultado = submit-VTHash($hash)
    ## RESULTADOS
        Write-Host -ForegroundColor Cyan "Resource    : " -NoNewline; Write-Host $VTresultado.resource
        Write-Host -ForegroundColor Cyan "Scan date   : " -NoNewline; Write-Host $VTresultado.scan_date
        Write-Host -ForegroundColor Cyan "Positives   : " -NoNewline; Write-Host $VTresultado.positives
        Write-Host -ForegroundColor Cyan "Total Scans : " -NoNewline; Write-Host $VTresultado.total
        Write-Host -ForegroundColor Cyan "Permalink   : " -NoNewline; Write-Host $VTresultado.permalink
    }
    Else{
If ($opcion -eq "2"){
        ## Escriba el hash
        Write-Host "Introduzca la ubicación de la carpeta del archivo (C:\Users\Administrador) sin la barra del final" -ForegroundColor Yellow
        $ubicacion= Read-Host "Introduzca un valor"
         Write-Host "Introduzca del archivo (Archivo.txt)" -ForegroundColor Yellow
         $ruta= Read-Host "Introduzca un valor"
            $archivo= "$ubicacion\$ruta"
            $hash= Get-FileHash -LiteralPath $archivo -Algorithm SHA256
            $hash= ($hash.Hash).ToLower()
    ## Introducimos el hash en la función
    $VTresultado = submit-VTHash($hash)
    ## RESULTADOS
        Write-Host -ForegroundColor Cyan "Fuente                : " -NoNewline; Write-Host $VTresultado.resource
        Write-Host -ForegroundColor Cyan "Fecha del analáisis   : " -NoNewline; Write-Host $VTresultado.scan_date
        Write-Host -ForegroundColor Cyan "Errores encontrados   : " -NoNewline; Write-Host $VTresultado.positives
        Write-Host -ForegroundColor Cyan "Análisis totales      : " -NoNewline; Write-Host $VTresultado.total
        Write-Host -ForegroundColor Cyan "Link del análisis     : " -NoNewline; Write-Host $VTresultado.permalink
        $virus= $VTresultado.positives
        if ($virus -gt 0){
            Write-Host -ForegroundColor Red "Se han detectado amenazas"
            Write-Host -ForegroundColor DarkRed "Ubicación de la amenaza  : " -NoNewline; Write-Host -ForegroundColor Gray "$archivo "
            }
        else{
            Write-Host -ForegroundColor Green "No hay riesgos"
            }
        }
Else{
        Write-Host "No se analizará nada" -ForegroundColor Red
    }
}
