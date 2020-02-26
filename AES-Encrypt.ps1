## CODIGO SIN TERMINAR
$dentro= Read-Host "texto"
$contraseña= Read-Host "pass"
$caracteres= $contraseña.Length
if ($caracteres.Trim() -eq "16"){
    $unencryptedString = "$dentro"

    # Cifrar
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($unencryptedString)

    $aesManaged = New-Object "System.Security.Cryptography.AesManaged"
    $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::ECB
    $aesManaged.BlockSize = 128
    $aesManaged.Key = [System.Text.Encoding]::UTF8.GetBytes($contraseña)

    $encryptor = $aesManaged.CreateEncryptor()
    $encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);

    $encrypted = [System.Convert]::ToBase64String($encryptedData)
    $encrypted
    }
elseif($caracteres -lt "16"){
    $contraseñaadd= (16 - $contraseña.Length)
    ## SE AÑADEN X CARACTERES
    }
elseif($caracteres -gt "16"){
    $contraseñaadd= ($contraseña.Length - "16")
    ## BORRAR X CARACTERES
    }

# Descifrar

$bytes = [System.Convert]::FromBase64String($encrypted)

$decryptor = $aesManaged.CreateDecryptor();
$unencryptedData = $decryptor.TransformFinalBlock($bytes, 0, $bytes.Length);

[System.Text.Encoding]::UTF8.GetString($unencryptedData).Trim([char]0)
