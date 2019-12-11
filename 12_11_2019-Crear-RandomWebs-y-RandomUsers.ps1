#Puedes generar nombres y datos aleatorios en: https://next.json-generator.com

## Este link contiene 50 usuarios https://next.json-generator.com/api/json/get/NJ2Xjzqpw
$usuarios = Invoke-WebRequest -Uri https://next.json-generator.com/api/json/get/NJ2Xjzqpw | ConvertFrom-Json

## Menú personalizado
$Titulo = 'RandomUser & RandomPost Generator v1.0 by www.github.com/MikeRuSe'
Clear-Host
    Write-Host "                " -NoNewline; Write-Host "====================== $Titulo ======================" -ForegroundColor Cyan

## Nos ubicamos en la carpeta de instalación de WordPress
    cd A:\Programas\Xampp\htdocs\wp\wp1

## Plugin de Ultimate Member
    php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install ultimate-member --activate

foreach($nombres in $usuarios.name){
    ## Generamos números aleatorios
    $telefono= (Get-Random -Minimum "629100000" -Maximum "629100100")

    ## Obtenemos los nombres y los apellidos
    $nombre= $nombres.first
    $apellido= $nombres.last

    ## Construimos un email con respecto al nombre y el apellido
    $email= "$nombre.$apellido@wp1.com"

    ## Creamos el usuario
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar user create $telefono $email --role=author --display_name="$nombre $apellido" --user_pass=Contraseña --description=$publicar

    ## Generamos contenido random
    $randomFruta='manzana', 'platano', 'pera', 'coco', 'naranja'
    $Fruta= (Get-Random -InputObject $randomFruta)
    $randomUbi='Madrid', 'Barcelona', 'Valencia', 'Galicia', 'Andalucia'
    $Ubi= (Get-Random -InputObject $randomUbi)
    $edad= (Get-Random -Minimum "16" -Maximum "99")
    $dinero1=(Get-Random -Minimum "0" -Maximum "9999")
    $dinero2=(Get-Random -Minimum "0" -Maximum "99")
     $dinero= "$dinero1.$dinero2"

    ## Damos formato y preparamos la publicación
    $publicar= (New-Object -TypeName psobject -Property @{"Ubicación"=$Ubi;"Fruta"=$Fruta;"Edad"=$edad;"Dinero"=$dinero}| ConvertTo-Json)

    ## Subimos el contenido al WordPress
    php.exe A:\Programas\Xampp\php\wp-cli.phar post create --post_author=$telefono --post_type=post --post_title="Perfil de $nombre" --post_content=$publicar --post_status=publish --user=$email
    }

## Menú final
Write-Host "                " -NoNewline; Write-Host "====================== El script finalizó. " -ForegroundColor Green -NoNewline; Write-Host "Made by " -ForegroundColor Yellow -NoNewline; Write-Host "www.github.com/MikeRuSe" -ForegroundColor Magenta -NoNewline; Write-Host " ======================" -ForegroundColor Green
Start-Sleep -Seconds 2
