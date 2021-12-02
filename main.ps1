Add-Type -AssemblyName System.Web
Set-Location $PSScriptRoot

$config = Get-Content -Raw -Path .\config.json | ConvertFrom-Json
$content = Get-Content "$($config.FileName)" | ForEach-Object {[System.Web.HttpUtility]::UrlEncode($_)}

$Body = @{
    identifiers = @(@{name = "Ascendant Evincar"})
}
$Parameters = @{
    Method = "POST"
    Uri =  "https://api.scryfall.com/cards/collection"
    Body = ($Body | ConvertTo-Json) 
    ContentType = "application/json"
}
Invoke-RestMethod @Parameters| ForEach-Object {$_.data} | Add-Content -Path .\"test.txt"

#"$($config.SitePath)$($content[0])" 
#Invoke-WebRequest -uri "$($SitePath.SitePath)$($content[0])" 