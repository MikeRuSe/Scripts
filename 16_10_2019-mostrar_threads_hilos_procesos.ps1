# Mostrar threads
(Get-Process | select name,Threads).Threads.id

# Nombre del proceso que tiene un identificador
Get-Process -id 5708

# No funciona porque no se puede enlazar el parámetro Id con processhandle
Get-WmiObject -Class Win32_Thread | select handle,processhandle,(Get-Process -id processhandle)

# Listar hilos de cada proceso
# Relación entre procesos e hilos
# Mostrar los hilos de cada proceso utilizando WMI y el cmdlet Get-Process
Get-WmiObject Win32_Thread | %{
    $_.Handle,$_.ProcessHandle,(Get-Process -Id $_.ProcessHandle).ProcessName
}

# Mostrar información sobre los hilos de todos los procesos que se están ejecutando (qué proceso ejecuta el hilo)
# Relación entre procesos e hilos (otro método) (HILOS -> PROCESOS)
Get-WmiObject -Class Win32_Thread | select handle,processhandle, @{Name="Name Process"; Expression = {((Get-Process -Id $_.processhandle).name)}}

# Mostrar los hilos del proceso Notepad (PROCESOS -> HILOS)
Get-Process -name notepad | select Name,Threads

(Get-WmiObject -Class Win32_Thread -Filter "ProcessHandle = $((gps -name notepad).id)") | %{
    $_.Handle, $_.ProcessHandle, (Get-Process -Id $_.ProcessHandle).ProcessName
}

# Mostrar todos los hilos que ejecutan los procesos (PROCESOS -> HILOS)
Get-Process | select Name,Threads | %{
    $_.Name,($_.Threads).id
}

# Almacenar en un fichero los nombres de los procesos y el número de hilos que tienen
Get-Process | select Name,Threads | %{
    $_.Name + "->" + ($_.Threads).id.count | Out-File monitorizar.txt -Append
}

# Almacenar en un fichero los nombres de los procesos y el número de hilos que tienen (de forma continuada)
for(1)
{
    Get-Process | select Name,Threads | %{
        $_.Name + "->" + ($_.Threads).id.count | Out-File monitorizar.txt -Append
    }
    Start-Sleep -Seconds 10
}

# Almacenar en un fichero los nombres de los procesos y el número de hilos que tienen (de forma continuada junto con la fecha)
for(1)
{
    "----------------------------------------------" | Out-File monitorizar.txt -Append
    Get-Date | Out-File monitorizar.txt -Append
    Get-Process | select Name,Threads | %{
        $_.Name + "->" + ($_.Threads).id.count | Out-File monitorizar.txt -Append
    }
    Start-Sleep -Seconds 10
}

# Almacenar en un fichero los nombres de los procesos y el número de hilos que tienen mediante una función (de forma continuada junto con la fecha)
for(1)
{
    "----------------------------------------------" | Out-File monitorizar.txt -Append
    Get-Date | Out-File monitorizar.txt -Append
    Get-Process | select Name,Threads | %{
        $_.Name + "->" + (contarhilos($_.Threads)) | Out-File monitorizar.txt -Append
    }
    Start-Sleep -Seconds 10
}

function contarhilos($Threads)
{
    $Threads.count
}

# Relación entre servicios y procesos
# Ayuda de servicios con procesos
# Ayuda de procesos WMI con procesos

# Servicios y relación con procesos

# Procesos y ruta de ejecución del proceso