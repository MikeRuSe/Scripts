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
		$token = htmlspecialchars($_GET['token']); 
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

		}
		elseif ($enviar == "leer") {
			$resultado = "";
			$con = "";
			$registros = "";
			$resultado = "";

			$con = $php->prepare("SELECT port from firewall where id='6';");
			$con->execute();
			$registros = $con->fetch(PDO::FETCH_NUM);	
			$resultado = $registros[0];
			$salida = shell_exec("powershell [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('$resultado'))");
			// FUNCION ENCRIPTADO DESENCRIPTADO	
				function encrypt_decrypt($action, $string) {
					$output = false;
				
					$encrypt_method = "AES-256-CBC";
					$secret_key = 'This is my secre';
					$secret_iv = 'This is my secre';
						
					// hash
					$key = hash('sha256', $secret_key);
						
					//iv - encrypt method AES-256-CBC expects 16 bytes - else you will get a warning
					$iv = substr(hash('sha256', $secret_iv), 0, 16);
    
					if ( $action == 'encrypt' ) {
					$output = openssl_encrypt($string, $encrypt_method, $key, 0, $iv);
					$output = base64_encode($output);
					} else if( $action == 'decrypt' ) {
					$output = openssl_decrypt(base64_decode($string), $encrypt_method, $key, 0, $iv);
					}
				
				return $output;
				}
			$salida1= encrypt_decrypt('decrypt', $salida); 			
			
		}
		elseif ($enviar == "firewall")
		{
			$resultado = "";
			$con = "";
			$registros = "";
			$resultado = "";

			$con = $php->prepare("INSERT INTO firewall VALUES (DEFAULT,:tex);");
			$con->bindParam(':tex',$token);
			$con->execute();
			//$salida = shell_exec("powershell [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($token))");			
			
		}
		else {
			$mensaje = "Ejecute print, connection o firewall";
		}
	?>
		<h1 class="lol1">
			<?php 
			echo "$resultado";
  			  ?>
			 	
		</h1>
		<h1 class="lol2">
			<?php 
			echo $salida;
  			  ?>
			 	
		</h1>
		<h1 class="lol3">
			<?php 
			echo $salida1;
  			  ?>
			 	
		</h1>
		<h2>
			<?php 
			 echo "$mensaje"; 
			 ?>
		</h2>
</body>

</html>
