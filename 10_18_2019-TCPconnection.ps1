Get-NetTCPConnection | select LocalPort | where {$_.LocalPort -EQ 80}
