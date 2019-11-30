#Open file
(Get-Content C:\FicheroURLwebs.txt) | %{
$_
#Use youtube-dl
#Youtube-dl is a small command-line program to download videos from YouTube.com and a few more sites. It requires the Python interpreter (2.6, 2.7, or 3.3+), and it is not platform specific. We also provide a Windows executable that includes Python. youtube-dl should work in your Unix box, in Windows or in Mac OS X. It is released to the public domain, which means you can modify it, redistribute it or use it however you like.
C:\exa\youtube-dl.exe $_
}

Invoke-WebRequest "http://10.202.0.14:8000/SoundHelix-Song-1.mp3"

$ErrorActionPreference = "SilentlyContinue"

##################################
###########################
##################################
###########################
##################################

$ErrorActionPreference = "SilentlyContinue"

Invoke-WebRequest "http://www.goosgle.es" -ErrorVariable ErrorWeb

If ($ErrorWeb) {
    ####### Something went wrong
    "No existe la web"
}


# SilentlyContinue: se suprimen los mensajes de error y la ejecución continúa
# Stop: se detiene la ejecución
# Continue: es la opción por defecto. Se muestra el error y la ejecución continúa
# Inquire: pregunta al usuario como proceder
# Ignore: el error es ignorado y no se registra ni muestra.


####################################
####################################
####################################

# Fichero URLS
## https://www.youtube.com/watch?v=6DeDzsCGbsQ
## https://www.youtube.com/watch?v=6DeDzsCGbsQ
## https://www.youtube.com/watch?v=6DeDzsCGbsQadsfdsfdasfdas
## https://www.youtu444be.com/watch?v=6DeDzsCGbsQ
## https://www.youtube.com/watch?v=6DeDzsCGbsQ

$ErrorActionPreference = "SilentlyContinue"

foreach($urls in gc urls.txt)
{
    $web = Invoke-WebRequest $urls -ErrorVariable ErrorWeb

    if ($ErrorWeb)
    {
        ####### Something went wrong
        "No existe la web"
    }
    else
    {
        "Sí existe la web"
    }
}