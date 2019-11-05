### LOGS ###
mkdir (Get-Process).id -Force

(Get-Process -Id 4).Threads.id

foreach($procesos in (Get-Process).id)
{
    cd $procesos
    (Get-Process -id $procesos).Threads >> info.txt
    cd ..
}


##############################

if(Get-Process -Name notepad)
{
    "se ejecuta"
}
else
{
    "no se ejecuta"
    Start-Process notepad
}

##############################

Start-Process notepad
$data=(Get-FileHash (gps notepad -Module).FileName)
Start-Process notepad
Start-Process notepad
$data2=(Get-FileHash (gps notepad -Module).FileName)

Compare-Object -ReferenceObject $data -DifferenceObject $data2 -Property Hash -PassThru | Sort-Object -Property Hash | Select-Object -Property hash, SideIndicator


$data=Get-Process
Start-Process notepad
$data2=Get-Process

Compare-Object -ReferenceObject $data -DifferenceObject $data2 -Property ProcessName -PassThru | Sort-Object -Property ProcessName | Select-Object -Property ProcessName, Id, SideIndicator

###################
#### MODO MIKE ####
###################

mkdir "PROCESOS"
cd "PROCESOS"

foreach($procesos in (Get-Process).Id)
{
    cd $procesos
    (Get-Process -id $procesos).Threads.Id > info.txt
    cd..
    }
