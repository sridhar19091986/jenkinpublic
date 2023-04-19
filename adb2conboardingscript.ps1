# PowerShell script.ps1
Install-Module -Name Microsoft.Graph.Applications -Force
Import-Module Microsoft.Graph.Applications
param (
  [string]$Env,
  [string]$Version,
  [string]$AppName
)

Write-Host "Parameter 1: $Env"
Write-Host "Parameter 2: $Version"
Write-Host "Parameter 3: $AppName" 



$params = @{
	displayName = $AppName
}

New-MgApplication -BodyParameter $params
