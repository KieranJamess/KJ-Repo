DO {
    Write-host "Checking Site..." -ForegroundColor Magenta
    $amazonps5 = "https://www.amazon.co.uk/dp/B08H95Y452/ref=as_sl_pc_qf_sp_asin_til"
    wget $amazonps5 -outfile ".\amazon.txt"
    $status = Get-Content -Path ".\amazon.txt"
    if ($status -match "Currently unavailable") {
        Write-host "Amazon PS5 Still unavaiable!" -ForegroundColor Red
        Start-Sleep -Seconds 120
    }
    else {
        $notinstock = 1  
    }
} until ($notinstock -eq 1)
$minutesran = $minutesran / 2
write-host "PS5 Is available!" -ForegroundColor Green
Write-host "Script ran for $minutesran minutes"-ForegroundColor Green
Start-Process -FilePath ".\ps5.jpg"
exit