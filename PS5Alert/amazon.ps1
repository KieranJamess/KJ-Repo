$notinstock = 0
while ($notinstock = 1) {
    $amazonps5 = "https://www.amazon.co.uk/dp/B08H95Y452/ref=as_sl_pc_qf_sp_asin_til"
    wget $amazonps5 -outfile ".\amazon.txt"
    $status = Get-Content -Path ".\amazon.txt"
    if ($status -match "Currently unavailable") {
        Write-host "Amazon PS5 Still unavaiable!"
        Start-Sleep -Seconds 2
    }
    else {
        $notinstock = 1  
    }
}
write-host "PS5 Is available!"
Start-Process -FilePath ".\ps5.jpg"
$notinstock = 1
exit