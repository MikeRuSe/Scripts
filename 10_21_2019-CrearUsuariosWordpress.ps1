while(1)
{
   $usuario = ((Invoke-WebRequest -Uri 'https://randomuser.me/api/?format=json').content | ConvertFrom-JSON)
   $email=$usuario.results.email
   $username=$usuario.results.login.username
   $password=$usuario.results.login.password
   A:\Programas\Xampp\php\php.exe A:\Programas\Xampp\php\wp-cli.phar user create $username $email --role=author  --user_pass=$password
   $username
   $email
   $password
   Start-Sleep -Seconds 5
}
