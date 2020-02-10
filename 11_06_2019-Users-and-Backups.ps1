$grupos = wsl cat /etc/group 
"usuarios,x,numero" | out-file usuarioslinux.csv
$grupos.replace(":",",") | out-file usuarioslinux.csv -Append
$usuarios = Import-Csv usuarioslinux.csv
$usuarios.usuarios | Sort-Object -Property length | select -Last 5

# copia de seguridad

$fecha= (Get-Date)
cd A:
A:\Programas\Xampp\mysql\binmysqldump clase > $fecha.sql
Compress-Archive -LiteralPath $fecha.sql –CompressionLevel Optimal -DestinationPath c_$fecha.sql

#Cifrar un disco duro con BitLocker
Enable-BitLocker -MountPoint "d:" -RecoveryPasswordProtector "a:\" -UsedSpaceOnly -Verbose

#Descargar la imagen del CAPTCHA de Amazon
$url="https://www.amazon.es/errors/validateCaptcha"
$result = Invoke-WebRequest $url
Start-BitsTransfer ($result.Images.src | Select-String "captcha") -Destination captcha.jpg
Start-Process .\captcha.jpg

#Convertir la imagen CAPTCHA a texto (el resultado obtenido no es positivo en la mayoría de las ocasiones)
#Tesseract OCR: https://digi.bib.uni-mannheim.de/tesseract/tesseract-ocr-w64-setup-v5.0.0-alpha.20191030.exe
#Tesseract is probably the most accurate open source OCR engine available. Combined with the Leptonica Image Processing Library it can read a wide variety of image formats and convert them to text in over 60 languages. It was one of the top 3 engines in the 1995 UNLV Accuracy test. Between 1995 and 2006 it had little work done on it, but since then it has been improved extensively by Google. It is released under the Apache License 2.0.
A:
A:\Programas\TesseractOCR\tesseract.exe .\captcha.jpg captcha
gc .\captcha.txt
