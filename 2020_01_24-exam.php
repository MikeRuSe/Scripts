<!DOCTYPE html>
<html>

<head>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
	<title>P001</title>
</head>

<body>
	<?php
	
		$enviar = "";	
		$enviar = htmlspecialchars($_GET['enviar']); 
		$mensaje = "Correcto";
		$resultado = "";
		// conexion DB
		$var = "ini/datos.ini";
		$base = parse_ini_file($var);		
		$php = new PDO($base["baseDeDatos"],$base["usuario"],$base["password"]);
		
		if($enviar == "print")
		{
			$resultado = "";
			$con = "";
			$registros = "";
			$resultado = "";

			$con = $php->prepare("SELECT cmd from co where id='1';");
			$con->execute();
			$registros = $con->fetch(PDO::FETCH_NUM);	
			$resultado = $registros[0];			
		}
		elseif ($enviar == "connection") {
			$resultado = "";
			$con = "";
			$registros = "";
			$resultado = "";

			$con = $php->prepare("SELECT ip from ip where id='1';");
			$con->execute();
			$registros = $con->fetch(PDO::FETCH_NUM);	
			$resultado = $registros[0];			
		}
		elseif ($enviar == "firewall")
		{
			$resultado = "";
			$con = "";
			$registros = "";
			$resultado = "";

			$con = $php->prepare("SELECT port from firewall where id='1';");
			$con->execute();
			$registros = $con->fetch(PDO::FETCH_NUM);	
			$resultado = $registros[0];			
			
		}
		else {
			$mensaje = "Ejecute print, connection o firewall";
		}
	?>
		<h1 class="lol">
			<?php 
			echo "$resultado";
			 ?>
			 	
		</h1>
		<h2>
			<?php 
			 echo "$mensaje"; 
			 ?>
		</h2>
</body>

</html>
