"nombre,operacion" > operar.csv
"juan,0" >> operar.csv
"pedro,1" >> operar.csv
notepad operar.csv

foreach($operacion in Import-Csv .\operar.csv)
{
    switch($operacion.operacion)
    {
        0{$operacion.nombre}
        1{$operacion.nombre}
    }
}