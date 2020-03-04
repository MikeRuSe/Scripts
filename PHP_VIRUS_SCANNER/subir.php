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

    <form method="post" action="subido.php" enctype="multipart/form-data">
			<label>Nombre de Usuario</label>
				<input type="text" name="usuario" autocomplete="off" required/>
       <label> Archivo </label>
       <input type="file" name="archivo" required/>
       <input type="submit" value="Subir" />
			<form id="form_99051" class="appnitro" method="post" action="subido.php">
					<div class="form_description">
    </form>
 </body>
</html>