# Saber el tiempo que lleva alguien en Facebook

Get-Process | Select-Object name,Id,TotalProcessorTime
Get-WmiObject win32_process | select commandline | Format-Custom

$Proceso=Get-Process -Name notepad
$NombreF=(($Proceso).name)+'.dmp'
$Fichero = New-Object IO.FileStream($NombreF,[IO.FileMode]::Create)
(([PSObject].Assembly.GetType('System.Management.Automation.WindowsErrorReporting')).GetNestedType('NativeMethods', 'NonPublic')).GetMethod('MiniDumpWriteDump',[Reflection.BindingFlags] 'NonPublic, Static').Invoke($null, @($Proceso.Handle,$Proceso.Id,$Fichero.SafeFileHandle,[UInt32] 2,[IntPtr]::Zero,[IntPtr]::Zero,[IntPtr]::Zero))
$Fichero.Close()

############################################

# Utilizar dos cmdlets a la vez para conocer qué proceso padre crea a otro proceso hijo

Get-WmiObject win32_process | Select-Object name,ParentProcessId,ProcessId

Get-WmiObject win32_process | %{
    "Al proceso " + $_.name + " le ejecuta el proceso " + (Get-Process -id  $_.ParentProcessId).Name
}

#############################################

# Mostrar un mensaje emergente cuando la carga del procesador supera 10

## Carga del procesador
Get-WmiObject Win32_Processor | select LoadPercentage

## Crear un mensaje emergente
[System.Windows.MessageBox]::Show('Hash encontrado','Warning')
$balloon = New-Object System.Windows.Forms.NotifyIcon 

#Configurar notificación
#Icono
$balloon.Icon  = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Process -Name notepad).Path) 
$balloon.BalloonTipIcon  = [string]$Icon = 'Info'
#Mensaje
$balloon.BalloonTipText  = "Mensaje"
#Título
$balloon.BalloonTipTitle  = "Hash encontrado"+$modulo.FileName
 
$balloon.Visible  = $true
$balloon.ShowBalloonTip(5000)

# Crear el código que muestra mensaje si supera el consumo

$carga = Get-WmiObject Win32_Processor | select LoadPercentage
if($carga.LoadPercentage -gt 5)
{
    [System.Windows.MessageBox]::Show('Carga en exceso','Warning')

    $balloon = New-Object System.Windows.Forms.NotifyIcon
    #Configurar notificación
    #Icono
    $balloon.Icon  = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Process -Name notepad).Path) 
    $balloon.BalloonTipIcon  = [string]$Icon = 'Info'
    #Mensaje
    $balloon.BalloonTipText  = "Mensaje"
    #Título
    $balloon.BalloonTipTitle  = "Carga en exceso"+$carga.LoadPercentage
 
    $balloon.Visible  = $true
    $balloon.ShowBalloonTip(5000)
}

#############################################

#Ejecutar PowerShell como administrador
while(1)
{
Get-Event | Remove-Event -ErrorAction SilentlyContinue
#Registrar el evento de ejecutar notepad
Register-WmiEvent -Query "SELECT * FROM Win32_ProcessStartTrace WHERE ProcessName='notepad.exe'"
Wait-Event -OutVariable Event | Out-Null
$Event.sourceargs.newevent | select-Object ProcessName,TIME_CREATED
}

#############################################

# REGISTRAR UN EVENTO Y MOSTRAR UN MENSAJE EMERGENTE EN POWERSHELL CUANDO SE EJECUTA UN PROGRAMA

## REGISTRAR UN EVENTO Y MOSTRAR UN MENSAJE EN POWERSHELL CUANDO SE EJECUTA UN PROGRAMA
while(1)
{
Get-Event | Remove-Event -ErrorAction SilentlyContinue
#Registrar el evento de ejecutar notepad
Register-WmiEvent -Query "SELECT * FROM Win32_ProcessStartTrace WHERE ProcessName='notepad.exe'"
Wait-Event -OutVariable Event | Out-Null
$Event.sourceargs.newevent | select-Object ProcessName,TIME_CREATED
}

## Crear un mensaje emergente
[System.Windows.MessageBox]::Show('Hash encontrado','Warning')
$balloon = New-Object System.Windows.Forms.NotifyIcon 

#Configurar notificación
#Icono
$balloon.Icon  = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Process -Name notepad).Path) 
$balloon.BalloonTipIcon  = [string]$Icon = 'Info'
#Mensaje
$balloon.BalloonTipText  = "Mensaje"
#Título
$balloon.BalloonTipTitle  = "Hash encontrado"+$modulo.FileName
 
$balloon.Visible  = $true
$balloon.ShowBalloonTip(5000)

#############################################

https://www.jesusninoc.com/06/25/utilizar-zonas-de-memoria-compartida-en-linux-mediante-wsl-desde-powershell/

#############################################
