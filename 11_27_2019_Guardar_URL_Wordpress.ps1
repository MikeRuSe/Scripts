## Crear un WordPress
$web= "Wordpress_Links"
cd A:\Programas\Xampp\htdocs\wp\
foreach($user in $web)
{
    ## Crear los WordPress
    New-Item -ItemType Directory -Name $user -Force
    cd A:\Programas\Xampp\htdocs\wp\$user
    php.exe A:\Programas\Xampp\php\wp-cli.phar core download
    php.exe A:\Programas\Xampp\php\wp-cli.phar config create --dbname=$user --dbuser=root

    ## Creación de la DB
    php.exe A:\Programas\Xampp\php\wp-cli.phar db create
    php.exe A:\Programas\Xampp\php\wp-cli.phar core install --url=localhost/wp/$user --title="Estás en la web de $user" --admin_user=admin --admin_password=C0NTR4SEN4! --admin_email=admin@email.com 
}

# Guardar links en Worpress
echo "Introduce la URL:"
$url1 = Read-Host
$url2 = Read-Host
$url3 = Read-Host
php.exe A:\Programas\Xampp\php\wp-cli.phar post create --post_type=page --post_title="LINKS" --post_content="$url1 ----- $url2 ----- $url3" --post_status=publish

