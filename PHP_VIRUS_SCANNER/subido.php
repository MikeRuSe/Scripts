<?php 
  session_start(); 
  if(isset($_SESSION['contador'])) 
  { 
    $_SESSION['contador'] = $_SESSION['contador'] + 1; 
    $mensaje = $_SESSION['contador']; 
  } 
  else 
  { 
    $_SESSION['contador'] = 1; 
    $mensaje = $_SESSION['contador']; 
  } 
$cookie= session_id();
$archivo = (isset($_FILES['archivo'])) ? $_FILES['archivo'] : null;
if ($archivo) {
   $ruta_destino_archivo = "../archivos/{$archivo['name']}";
   $archivo_ok = move_uploaded_file($archivo['tmp_name'], $ruta_destino_archivo);
   $_COOKIE['ruta'] =$ruta_destino_archivo;
}
$_SESSION['archivo']= $ruta_destino_archivo;

if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    		$ip = $_SERVER['HTTP_CLIENT_IP'];
	} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    		$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	} else {
    		$ip = $_SERVER['REMOTE_ADDR'];
	}
	//insert vars
		$nombre = $_POST['usuario']; 
		$archivodb = $archivo['name']; 
		$navegador = $_SERVER['HTTP_USER_AGENT'];
		$var = "ini/datos.ini";
		$base = parse_ini_file($var);		
		$php = new PDO($base["baseDeDatos"],$base["usuario"],$base["password"]);
	
			$con = $php->prepare("INSERT INTO logs VALUES (DEFAULT, :user, :file, :ip, :navegador, :visita, :cookie);");
			$con->bindParam(':user',$nombre);
			$con->bindParam(':file',$archivodb);
			$con->bindParam(':ip',$ip);	
			$con->bindParam(':navegador',$navegador);	
			$con->bindParam(':visita',$mensaje);					
			$con->bindParam(':cookie',$cookie);									
			$con->execute();
session_destroy();
header("Location: analizar.php?varname=$ruta_destino_archivo");
die();
?>
