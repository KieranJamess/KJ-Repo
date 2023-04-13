## This script queries the CEX API. First using your latitude and longitude, it will sort all the CEX stores by distance order. 
## Then it will check each store for the stock of the specified SKU. 2 properties will be added for each store, HasStock (being true or false and Stock (being the amount of stock).
## Once it has checked all stores, it will output a CSV with this information to use.

param(
    [Parameter()]
    [int]
    $localLatitude = 51.240799,

    [Parameter()]
    [int]
    $localLongitude = -0.170090,

    [Parameter()]
    [string]
    $productSKU = "SDV2GARE002", # Garfield 1 SKU

    [Parameter()]
    [string]
    $CSVOutputPath = $pwd
)

function Convert-DegreesToRadians($degrees) {
    return $degrees * ([math]::PI / 180)
}

# Calculate distance between two points using Haversine formula
function Get-Distance($lat1, $lon1, $lat2, $lon2) {
    $R = 6371 # Radius of Earth in kilometers
    $dLat = Convert-DegreesToRadians ($lat2 - $lat1)
    $dLon = Convert-DegreesToRadians ($lon2 - $lon1)
    $a = [math]::Sin($dLat/2) * [math]::Sin($dLat/2) + [math]::Sin($dLon/2) * [math]::Sin($dLon/2) * [math]::Cos((Convert-DegreesToRadians $lat1) * [math]::Cos((Convert-DegreesToRadians $lat2)))
    $c = 2 * [math]::Atan2([math]::Sqrt($a), [math]::Sqrt(1 - $a))
    $d = $R * $c
    $d = [math]::round($d,2)
    return $d
}

$uri = "https://wss2.cex.uk.webuy.io/v3"

$allstores = (invoke-webrequest -Uri "$uri/stores" -Method Get | ConvertFrom-Json).response.data.stores

# Loop through each store, calculate distance, and add it as a property to the store object
$allstores | ForEach-Object {
    $store = $_
    $distance = Get-Distance $localLatitude $localLongitude $store.Latitude $store.Longitude
    $store | Add-Member -NotePropertyName "Distance" -NotePropertyValue $distance
}

# Sort the stores by distance in ascending order (closest to furthest)
$allstores = $allstores | Sort-Object Distance

$allstores | ForEach-Object {
    $store = $_
    $currentStoreId = $store.storeId
    $stock = ((Invoke-WebRequest -Uri "$uri/boxes/$productSKU/neareststores?latitude=$($store.latitude)&longitude=$($store.longitude)").content | ConvertFrom-Json).response.data.nearestStores | Where-Object {$_.storeId -eq $currentStoreId}
    if ($stock.quantityOnHand -gt 0) {
        $store | Add-Member -NotePropertyName "HasStock" -NotePropertyValue "True"
        $store | Add-Member -NotePropertyName "Stock" -NotePropertyValue $stock.quantityOnHand
    }
    else {
        $store | Add-Member -NotePropertyName "HasStock" -NotePropertyValue "False"
        $store | Add-Member -NotePropertyName "Stock" -NotePropertyValue 0
    }
}

$filename = "CEX-$productSKU-stocklevels"
$allstores | Select-Object storeName,Distance,HasStock,Stock | Export-Csv -Path "$CSVOutputPath\$filename.csv" -NoTypeInformation

