## Obtener de una carpeta compartida ficheros (TXT) que tienes que imprimir (PDF)
cd \\localhost\a$
# Ubicación de los archivos
$txtPath = "\\localhost\a`$\logs\service_log.txt"
$pdfPath = "b:\service_log.pdf"

# Variables requeridas de Word
$wdExportFormatPDF = 17
$wdDoNotSaveChanges = 0

# Ejecutar word de forma invisible
$word = New-Object -ComObject word.application
$word.visible = $false

# Añadir un documento word
$doc = $word.documents.add()

# Poner el texto dentro del documento
$txt = Get-Content $txtPath
$selection = $word.selection
$selection.typeText($txt)

# Orientación de la página
$doc.PageSetup.Orientation = 1

# Exportar el PDF y salir de Word invisible sin guardar
$doc.ExportAsFixedFormat($pdfPath,$wdExportFormatPDF)
$doc.close([ref]$wdDoNotSaveChanges)
$word.Quit()

## Obtener de una carpeta compartida ficheros que se han almacenado en formato HTML (tienes que guardar las páginas web en la carpeta compartida) que posteriomente hay que imprimir (PDF)
cd \\localhost\a$\logs
foreach ($html in (ls *.html -Name)){
    Copy-Item -Path $html -Destination b:\$html
    # Ubicación de los archivos
    $txtPath = "\\localhost\a`$\logs\$html"
    $pdfPath = "b:\$html.pdf"

    # Variables requeridas de Word
    $wdExportFormatPDF = 17
    $wdDoNotSaveChanges = 0

    # Ejecutar word de forma invisible
    $word = New-Object -ComObject word.application
    $word.visible = $false

    # Añadir un documento word
    $doc = $word.documents.add()

    # Poner el texto dentro del documento
    $txt = Get-Content $txtPath
    $selection = $word.selection
    $selection.typeText($txt)

    # Orientación de la página
    $doc.PageSetup.Orientation = 1

    # Exportar el PDF y salir de Word invisible sin guardar
    $doc.ExportAsFixedFormat($pdfPath,$wdExportFormatPDF)
    $doc.close([ref]$wdDoNotSaveChanges)
    $word.Quit()
    
    }