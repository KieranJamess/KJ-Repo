[CmdletBinding()]
param (
    [Parameter()]
    [int]
    $notinstock = 0,

    [Parameter()]
    [int]
    $totalchecks = 0
)

function Get-UrlStatusCode([string] $Url)
{
    try
    {
        (Invoke-WebRequest -Uri $Url -UseBasicParsing -DisableKeepAlive).StatusCode
    }
    catch [Net.WebException]
    {
        [int]$_.Exception.Response.StatusCode
    }
}

function CheckSite {
    param (
        [Parameter()]
        [string]
        $sitename,

        [Parameter()]
        [string]
        $link,

        [Parameter()]
        [string]
        $textocheck,

        [Parameter()]
        [string]
        $product,

        [Parameter()]
        [int]
        $checkintervals
    )

    Write-host "Checking Site: $sitename for $product" -ForegroundColor Magenta

    DO {
        $sitestatus = Get-UrlStatusCode -Url $link
        if ($sitestatus -eq 200) {
            $totalchecks = $totalchecks + 1
            wget $link -outfile ".\$sitename.txt"
            $status = Get-Content -Path ".\$sitename.txt"
            if ($status -match $textocheck) {
                Write-host "[ $sitestatus ] $sitename : $product unavaiable!" -ForegroundColor Red
                Start-Sleep -Seconds $checkintervals
            }
            else {
                $notinstock = 1  
            }
        }
        else {
            Write-host "[ $sitestatus ] The link for $sitename is returning $sitestatus" -ForegroundColor Red
        }
    } until ($notinstock -eq 1)
    write-host "[$sitestatus]$sitename : $product is available!" -ForegroundColor Green
    Write-host "Total Checks: $totalchecks "-ForegroundColor Green
    Start-Process -FilePath ".\ps5.jpg"
    exit
    
}

CheckSite -sitename "Amazon" -link "https://www.amazon.co.uk/dp/B08H95Y452" -textocheck "Currently unavailable" -product "PS5 Disk Version" -checkintervals 120
