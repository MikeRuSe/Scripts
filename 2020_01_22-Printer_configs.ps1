"hola  ajajajajaja ajajajaja" | Out-Printer "Brother Color Leg Type1 Class Driver"
## Remove-PrintJob -ID 1 -PrinterName "Brother Color Leg Type1 Class Driver"
## $cola =(Get-PrintJob -PrinterName "Brother Color Leg Type1 Class Driver" | select id, size)
foreach($impresora in Get-Printer){ 
    foreach ($cola in (Get-PrintJob -PrinterName $impresora.Name)){
     if ($cola.size -gt 43KB){
      if($cola.UserName -eq "administrador"){
        Remove-PrintJob -ID $cola.id -PrinterName "Brother Color Leg Type1 Class Driver"
     }
    }
    else{}
    }
}
Get-PrintJob "Brother Color Leg Type1 Class Driver"
