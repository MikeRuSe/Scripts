## Buscar el hash de un archivo en VirusTotal
## Testeado y desarrollado en Windows 8.1 Pro y en Windows 10 Pro
## Registrar la API Key: https://www.virustotal.com/gui/join-us
## Es recomendable cambiar la API de abajo
    $VT_API = "45eb3db57881fe217aad8935f2f7ce0e025098f02545649390c4ff6ab491a977"
## Establecemos el protocolo TLS 1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function submit-VTHash($VThash)
{
    $VTcuerpo = @{resource = $VThash; apikey = $VT_API}
    $VTresultado = Invoke-RestMethod -Method GET -Uri 'https://www.virustotal.com/vtapi/v2/file/report' -Body $VTcuerpo

    return $vtResultado
}

## Menú personalizado
$Titulo = 'ANTIVIRUS v1.0.4 by www.github.com/MikeRuSe'
Clear-Host
    Write-Host "                " -NoNewline; Write-Host "====================== $Titulo ======================" -ForegroundColor Gray
    Write-Host " "
    Write-Host "                                                    " -NoNewline;Write-Host "¿Qué desea analizar?" -ForegroundColor Green
    Write-Host " "
    Write-Host "                 " -NoNewline; Write-Host " Presione '1' para analizar un hash" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '2' para analizar un archivo" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '3' para analizar una carpeta y sus archivos (pueden no aparecer todos los datos de los archivos...)" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione '4' para recuperar contraseñas WiFi" -ForegroundColor Magenta
    Write-Host "                 " -NoNewline;Write-Host " Presione otra tecla para salir" -ForegroundColor Red
    Write-Host " "
# Comienzo del script:
    Start-Sleep -Milliseconds 200
$opcion= Read-Host "Introduzca un valor"
If ($opcion -eq "1"){
        ## Escriba el hash
        Write-Host "Introduzca el código hash" -ForegroundColor Yellow
        $hash= Read-Host "Introduzca un valor"
           #Para probar el script podemos usar el siguiente hash: "ba4038fd20e474c047be8aad5bfacdb1bfc1ddbe12f803f473b7918d8d819436"
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
        ## Archivo
        Write-Host "Introduzca la ubicación de la carpeta del archivo (C:\Users\Administrador) sin la barra del final" -ForegroundColor Yellow
        $ubicacion= Read-Host "Introduzca la ruta del archivo"
         Write-Host "Introduzca del archivo (Archivo.txt)" -ForegroundColor Yellow
         $ruta= Read-Host "Introduzca el nombre del archivo"
            $archivo= "$ubicacion\$ruta"
            $hash= Get-FileHash -LiteralPath $archivo -Algorithm SHA256
            $hash= ($hash.Hash).ToLower()
    ## Introducimos el hash en la función
    $VTresultado = submit-VTHash($hash)
    ## RESULTADOS
        Write-Host -ForegroundColor Cyan "Fuente                : " -NoNewline; Write-Host $VTresultado.resource
        Write-Host -ForegroundColor Cyan "Fecha del análisis    : " -NoNewline; Write-Host $VTresultado.scan_date
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

If ($opcion -eq "3"){
        ## Iniciamos la variable del contador de virus
        $virus_counter= 0
        ## Análisis de directorios y sus archivos
        $dir= Read-Host "Introduzca la dirección del directorio a analizar"
        ## Preguntamos si queremos que se guarden los logs
        Write-Host "¿Desea guardar un archivo con los logs?"
         $logs= Read-Host "Si/No"
            if ($logs -ne "Si"){
                Write-Host -ForegroundColor Red "No se alamcenarán los logs"
            }
            else{
                $logsUbi= Read-Host "Ubicación de la carpeta en la que se almacenarán los logs"
                cd $logsUbi
                    $año= (date).Year
                    $mes= (date).Month 
                    $dia= (date).Day 
                    $hora= (date).Hour
                    $minuto= (date).Minute             
                    mkdir "Logs del $año-$mes-$dia_$hora_$minuto" -Force
                    cd "Logs del $año-$mes-$dia_$hora_$minuto"
                        $diaAño= (date).DayOfYear
                        "====================== Análisis del día $diaAño a las $hora : $minuto ======================" > Análisis_de_malware.log
            }
        ## Obtenemos todos los archivos de la carpeta seleccionada con la función -Recurse y con -FullName obtenemos la ruta exacta de cada archivo de la carpeta
        foreach($directorio in (Get-ChildItem -File -Force $dir -Recurse).FullName){
            ## Se obtiene el hash del archivo que se va a analizar. Si es un directorio saldrá un error del tipo NULL en la shell
            $hash= Get-FileHash -LiteralPath $directorio -Algorithm SHA256
            ## Convertimos el hash a minúsculas
            $hash= ($hash.Hash).ToLower()
            ## Introducimos el hash en la función
            $VTresultado = submit-VTHash($hash)
            ## Extracción de resultados
            Write-Host -ForegroundColor Cyan "Fuente                : " -NoNewline; Write-Host $VTresultado.resource
            Write-Host -ForegroundColor Cyan "Fecha del analáisis   : " -NoNewline; Write-Host $VTresultado.scan_date
            Write-Host -ForegroundColor Cyan "Errores encontrados   : " -NoNewline; Write-Host $VTresultado.positives
            Write-Host -ForegroundColor Cyan "Análisis totales      : " -NoNewline; Write-Host $VTresultado.total
            Write-Host -ForegroundColor Cyan "Link del análisis     : " -NoNewline; Write-Host $VTresultado.permalink
            ## Extraemos en la shell si hay virus o no, si hay virus, saldrá un texto en rojo mencionando que hay amenazas y nos proporcionará la ubicación del archivo infectado
            $virus= $VTresultado.positives
            if ($virus -gt 0){
                Write-Host -ForegroundColor Red "Se han detectado amenazas"
                Write-Host -ForegroundColor DarkRed "Ubicación de la amenaza: " -NoNewline; Write-Host -ForegroundColor Gray "$directorio"
                $virus_counter++
                    if($logs -eq "Si"){
                         "## Ubicación de la amenaza:" >> Análisis_de_malware.log
                         $directorio >> Análisis_de_malware.log
                         "## Fecha:" >> Análisis_de_malware.log
                         $VTresultado.scan_date >> Análisis_de_malware.log
                         "## Amenazas en el archivo:" >> Análisis_de_malware.log
                         $VTresultado.positives >> Análisis_de_malware.log
                         "## Link de Virus Total:" >> Análisis_de_malware.log
                         $VTresultado.permalink >> Análisis_de_malware.log
                         " " >> Análisis_de_malware.log
                         "#########################################################" >> Análisis_de_malware.log
                         " " >> Análisis_de_malware.log
                    }
                  Start-Sleep -Milliseconds 300
                }
            else{
                Write-Host -ForegroundColor Green "No hay riesgos"
               }
          }
          If($virus_counter -gt 0){
                Write-Host -ForegroundColor Red "Se han detectado $virus_counter amenazas"
                Write-Host -ForegroundColor DarkRed "Revise los logs más arriba o en el archivo"
                if ($logs -eq "Si"){
                    notepad Análisis_de_malware.log
                }
                cd C:
            }
          Else{ 
                Write-Host -ForegroundColor Green "No hay amenazas"
            }
          
     }
     Else{
If ($opcion -eq "4"){
    ## Script para recuperar contraseñas de WiFi en el ordenador
     ## Obtenemos la información de las SSID a las que se ha conectado nuestro PC
     $WifiSSIDs = (netsh wlan show profiles | Select-String ': ' ) -replace ".*:\s+"
      ## Extraemos la contraseña almacenada en el PC mediante la funcion de key=clear | Select-String 'Key Content'
      $WifiInfo = foreach($SSID in $WifiSSIDs) {
        ## Si el PC no está en inglés debemos sustituir el 'Contenido de la clave' por 'Key Content'
        $Contraseña = (netsh wlan show profiles name=$SSID key=clear | Select-String 'Contenido de la clave') -replace ".*:\s+"
        New-Object -TypeName psobject -Property @{"Contraseña"=$Contraseña;"SSID"=$SSID}
            }
            ## La opción "ConvertTo-Json" es opcional, podríamos poner un "ConvertTo-Html" para luego subirlo a una web, como no es el caso lo dejamos en "ConvertTo-Json"
      $WifiInfo | ConvertTo-Json
      }
Else{
        ## Cualquier otro carácter introducido que no pertenezca a los declarados más arriba hará que se cancele la ejecución del script
        Write-Host "No se analizará nada" -ForegroundColor Red
   }
  }
 }
}