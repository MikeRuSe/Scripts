### Imprimir dos archivos y unirlos mediante WSL

"pagina 1" | Out-file 01-22-10-2019.txt
"pagina 2" | Out-File 02-22-10-2019.txt
gc .\01-22-10-2019.txt | Out-Printer "Microsoft Print to PDF"
gc .\02-22-10-2019.txt | Out-Printer "Microsoft Print to PDF"
ls *.pdf
wsl ls
wsl pdfunits 01-22-10-2019-P.pdf 02-22-10-2019-P.pdf
.\out.pdf

#### Crear 5 carpetas con 10 ficheros cada una:

foreach ($pruebas1 in 1..5)
{
    New-Item -Name $pruebas1 -ItemType Directory
    foreach ($prueba in 1..10)
    {
    New-Item -Name $prueba -ItemType file -Path $pruebas1 -Value "hola"
    }
 }
