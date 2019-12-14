# ¿Está la web online?
echo "Introduce la URL:"
$url = Read-Host

$web1 = [System.Net.WebRequest]::Create("http://$url")
$web2 = $web1.GetResponse()
$web3 = [int]$web2.StatusCode

If ($web3 -eq 200) {
    Write-Host "La web está online"
    
}
Else {
    Write-Host "La web está offline"
    
}
