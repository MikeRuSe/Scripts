<!DOCTYPE html>
<html>

<head>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
	<title>P003</title>
</head>

<body>
	<?php
		$base = parse_ini_file("./ini/datos.ini");		
		$php = new PDO($base["baseDeDatos"],$base["usuario"],$base["password"]);
		$sql = "SELECT image from images where id=7";
		$con = $php->prepare("$sql");
		$con->execute();
		$registros = $con->fetchAll(PDO::FETCH_NUM);
		$php = null;
		$n = count($registros);
		$lel= $registros[0][0];
		//$vars= var_dump($registros);
		//$varsa= substr($vars, strpos($vars, "\n"));
	?>
	<section>
		<img alt="La imagen no se puede mostrar" src="<?php echo "$lel"; ?>" width="100" height="100"" />
	</section>
	<p><?php echo "$lel"; ?></p>
</body>

</html>
