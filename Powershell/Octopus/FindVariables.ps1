Param (

    [Parameter()]
    [string]
    $octopusURI,

    [Parameter()]
    [string]
    $defaultSpaceName,

    [Parameter()]
    [string]
    $apikey,

    [Parameter()]
    [string]
    $variable,

    $header =  @{ "X-Octopus-ApiKey" = $apiKey }

)

$ErrorActionPreference = 'silentlycontinue'
$defaultSpaceId = (Invoke-RestMethod -Uri "$octopusURI/api/spaces/all" -Method GET -Headers $header | ConvertFrom-Json -Depth 12 | Where-Object {$_.Name -eq $defaultSpaceName}).id

#Search project vars
Write-Host "Finding $variable in project variables" -ForegroundColor Magenta
$projectsid = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultSpaceId/projects/all" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).id
foreach ($project in $projectsid) {
    $varid = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultSpaceId/projects/$project" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).variablesetid
    $projectvars = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultspaceid/variables/$varid" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).variables
    foreach ($projectvar in $projectvars) {
        if ($variable -eq $projectvar.name) {
            Write-host "Found in"(Invoke-RestMethod -Uri "$octopusURI/api/$defaultSpaceId/projects/$project" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).name"" -ForegroundColor Green
            break
        }
    }
}


#Search library vars
Write-Host "Finding $variable in library sets" -ForegroundColor Magenta
$libs = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultspaceid/libraryvariablesets/all" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).variablesetid
foreach ($libset in $libs) {
    $libsetowner = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultspaceid/variables/$libset" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).ownerid
    $libsetname = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultspaceid/libraryvariablesets/$libsetowner" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).name
    $vars = (Invoke-RestMethod -Uri "$octopusURI/api/$defaultspaceid/variables/$libset" -Method GET -Headers $header | ConvertFrom-Json -Depth 12).variables
    foreach ($var in $vars) {
        if ($variable -eq $var.name) {
            Write-host "Found in $libsetname" -ForegroundColor Green
            break
        }
    }
}

