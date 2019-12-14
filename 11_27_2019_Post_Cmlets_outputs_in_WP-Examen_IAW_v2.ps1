### Hacer ping y postearlo en un wordpress
"examen" > web.txt

## Crear un WordPress
$web= Get-Content web.txt
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
    
    ## Plugin de SEO
    php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install wordpress-seo --activate 

    ## Plugin wordpress responsive 
    php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install wptouch --activate

    ## Plugin botones redes sociales
    php.exe A:\Programas\Xampp\php\wp-cli.phar plugin install simple-share-buttons-adder --activate 

    ## URL amigables 
    # No requiere plugin, en Ajustes > Enlaces permanentes podemos elegir uno simple o personalizarlo 
    
    # Ping
    echo "Introduce una dirección IP o el dominio:"
    $ping= Read-Host
    $publicar= ping $ping 
    $publicar  
    php.exe A:\Programas\Xampp\php\wp-cli.phar post create --post_type=page --post_title="Ping a $ping" --post_content="$publicar" --post_status=publish

}

####################################
### Crear dominios para cada web ###
####################################

## Guardar en HOST cada wordpress
cd C:\Windows\System32\drivers\etc
Copy-Item –Path C:\Windows\System32\drivers\etc\hosts –Destination 'C:\Windows\System32\drivers\etc\hosts_copy_ps'
rm hosts -Force
cd C:\Users\mike\
$hosts= Get-Content web.txt
"# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host

# localhost name resolution is handled within DNS itself.
#	127.0.0.1       localhost
#	::1             localhost

# 127.0.0.1       localhost
# 127.0.0.1       anecdonet.com
127.0.0.1       mike.com
" > host.txt
foreach ($hosts in $hosts)
{ 
    
    "127.0.0.1       $hosts.com"| Out-File -FilePath C:\Users\mike\host.txt -Append
    }    
Copy-Item –Path C:\Users\mike\host.txt –Destination 'C:\Windows\System32\drivers\etc\hosts' -Force
#
#
#
## Establecer los VHOST
cd A:\Programas\Xampp\apache\conf\extra
Copy-Item –Path A:\Programas\Xampp\apache\conf\extra\httpd-vhosts.conf –Destination 'A:\Programas\Xampp\apache\conf\extra\httpd-vhosts_copia_ps.conf'
rm httpd-vhosts.conf -Force
cd C:\Users\mike\
$hosts= Get-Content web.txt
'# Virtual Hosts
#
# Required modules: mod_log_config
#
# Use name-based virtual hosting.
#
NameVirtualHost *:80
#
# VirtualHost example:
# Almost any Apache directive may go into a VirtualHost container.
# The first VirtualHost section is used for all requests that do not
# match a ##ServerName or ##ServerAlias in any <VirtualHost> block.
#
#<VirtualHost *:80>
   ##ServerAdmin webmaster@dummy-host.example.com
   ##DocumentRoot "A:\Programas\Xampp\htdocs\wp\wp100"
   ##ServerName cervezaim.es
   ##ServerAlias www.cervezaim.es
   ##ErrorLog "logs/dummy-host.example.com-error.log"
   ##CustomLog "logs/dummy-host.example.com-access.log" common
#</VirtualHost>

#<VirtualHost *:80>
   ##ServerAdmin webmaster@dummy-host2.example.com
   ##DocumentRoot "C:/xampp/htdocs/dummy-host2.example.com"
   ##ServerName dummy-host2.example.com
   ##ErrorLog "logs/dummy-host2.example.com-error.log"
   ##CustomLog "logs/dummy-host2.example.com-access.log" common

##</VirtualHost>
' > httpd-vhosts.conf
foreach ($hosts in $hosts)
{ 
    
    "<VirtualHost *:80>
        ##ServerAdmin webmaster@dummy-host.example.com
        DocumentRoot A:\Programas\Xampp\htdocs\wp\$hosts
        ServerName $hosts.com
        ServerAlias www.$hosts.com
        ##ErrorLog 
        ##CustomLog 
    </VirtualHost>
"| Out-File -FilePath C:\Users\mike\httpd-vhosts.conf -Append
    }    
Copy-Item –Path C:\Users\mike\httpd-vhosts.conf –Destination 'A:\Programas\Xampp\apache\conf\extra\' -Force
