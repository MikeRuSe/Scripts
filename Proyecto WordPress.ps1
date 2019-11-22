## Preguntar el tipo de Instalación:
echo "XAMPP: 1"
echo "Lo otro valor DOCKER"
$juas = Read-Host "¿Como lo instalamos?"
    if($juas -eq 1)
    {
        echo "codigo de XAMPP"
    }
    else
    {
        echo "codigo de DOCKER"
    }

   

##Extraer información de una web
$url0='https://www.amazon.es/gp/new-releases/electronics'
$result0 = Invoke-WebRequest $url0
$datos= ($result0.AllElements | Where Class -eq “zg-item-immersion” | %{$_.innerText})
Start-Sleep -Milliseconds 10



## Descargar imagenes y guardarlas en una carpeta especifica
cd A:
cd A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads
mkdir Images
$url1 = "https://www.amazon.es/gp/new-releases/electronics"
$result1 = iwr -Uri $url1
$Images = ($result1).Images.src
foreach ($Image in $Images) 
    {
        Start-BitsTransfer -Source $Image -Destination A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\ -TransferType Download
    }



## Renombrar los archivos descargados con Poweshell y con CMD:
    # Powershell
        cd A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\ | Get-ChildItem *.jpg | Rename-Item -NewName { $_.Name -Replace '*.jpg','1???.jpg'}
    # CMD
        A:
        cd A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\
        ren *.jpg ???-wp.*



## Crear un HTML en el que se encuentren las imagenes
mkdir 1
cd 1
"<!DOCTYPE html>
<html>
  <head>
    <meta charset=utf-8>
        <title>Imágenes</title>
  </head>
  <body>" > Index.html
    
cd A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\ 
dir | select Name > A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\1\hola.txt
cd A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\1\
$Imagen = Get-Content hola.txt
cd A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\1 
    foreach ($img in $Imagen)
        {
        "<img src=../$img />" >> Index.html
        }

    "</body>
</html>" >> Index.html



## PLUGIN DE FORMULARIO
 # Comando:
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install ninja-forms --activate 
 # Capturas:
    https://gyazo.com/0bec8ac77d7d894d221bd8049007e05d
    https://gyazo.com/9bece875a019b74d37b0f92f1fdcafae



### Crear wordpress con plugins (XAMMP)
$var = "wp100"
$var2= "ninja-forms", "wordpress-seo", "google-sitemap-generator", "google-analytics-for-wordpress", "wp-smushit", "w3-total-cache", "wp-optimize", "bj-lazy-load", "vaultpress", "redirection", "user-registration", "mailchimp-for-wp", "woocommerce", "social-icons", "jetpack", "nivo-slider-lite"
A:
cd A:\Programas\Xampp\htdocs\
mkdir wp
cd A:\Programas\Xampp\htdocs\wp
foreach($usuarios in $var)
{
    $usuarios
    New-Item -ItemType Directory -Name $usuarios -Force
    cd A:\Programas\Xampp\htdocs\wp\$usuarios
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar core download
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar config create --dbuser=root --dbname=wptest$usuarios
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar db create
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar core install --url=localhost/wp/$usuarios --title="WordPress $usuarios" --admin_user=admin --admin_password=Andel2019 --admin_email=admin@$usuarios.com
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install wp-super-cache --activate 
    php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install wordpress-importer --activate
    foreach($plugin in $var2)
        {
        php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install $plugin --activate
        Start-Sleep -Seconds 5
        }
    A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar post create --post_title="$var" --post_content="$datos" --post_type="post"
    Start-Sleep -Seconds 5
    cd..
}
cd C:\Users\user1



### Crear un Wordpress en docker mediante un Stack de docker o un Docker-Compose con un archivo YML:
## Código (los nombres de usuario y contraseña son orientativos, ¡CAMBIADLOS!):
# Inicio
version: "2"
services:

  wordpress:
    image: wordpress
    ports:
      - 10001:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: juan
      WORDPRESS_DB_PASSWORD: asdfgh
      WORDPRESS_DB_NAME: wp100
    volumes:
      - /home/usuario/Wordpress/:/var/www/html

  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: wp100
      MYSQL_USER: pedro
      MYSQL_PASSWORD: asdfgh
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - /home/usuario/DataBase:/var/lib/mysql
# Fin

# Levantar el Yaml:
docker-compose -f {compose file name} up

## Subir los archivos al servidor mediante scp y un puerto distinto al 22
# Codigo simplificado
scp -P 7483 -pr A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\ usuario@dominio.duckdns.org:/home/usuario/Wordpress/wp-content/uploads/2019 -Credential (Get-Credential)
# Poweshell
Set-SCPFile –ComputerName dominio.duckdns.org –Port 7483  –RemotePath /home/usuario/Wordpress/wp-content/uploads/2019 –LocalFile A:\Programas\Xampp\htdocs\wp\wp100\wp-content\uploads\Images\hola.txt

## Verificar que los archivos se encuntran en el servidor
New-SSHSession -Port 7483 -ComputerName dominio.duckdns.org -Credential (Get-Credential)
cd /home/usuario/Wordpress/wp-content/uploads/2019
ls

## Investigacion sobre hosting, he encontrado dominios .tk y .ml gratuitos por 12 meses y he subido una prueba a: 
    www.dominio.ml
    # Obtener dominio gratuito en: https://my.freenom.com
## Con redirect a DNS para no tener que estar introduciendo la IP en el proveedor de domino cada vez que la IP cambie en caso de no ser estática:
    dominio.duckdns.org:10001
## Scripts opensource .sh para Linux para actualizar la IP del dominio en: https://www.duckdns.org/
## Plugin de SEO
php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install wordpress-seo --activate 
## Plugin wordpress responsive 
php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install wptouch --activate
## Plugin botones redes sociales
php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install simple-share-buttons-adder --activate 
## URL amigables 
# No requiere plugin, en Ajustes > Enlaces permanentes podemos elegir uno simple o personalizarlo