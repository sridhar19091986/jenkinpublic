
param (
  [string]$Env,
  [string]$Version,
  [string]$AppName
)

Write-Host "Parameter 1: $Env"
Write-Host "Parameter 2: $Version"
Write-Host "Parameter 3: $AppName" 

Import-Module Microsoft.Graph.Applications

$params = @{
	displayName = $AppName
}
Connect-MgGraph -ClientCredential $env:GRAPH_CLIENT_ID -ClientSecret $env:GRAPH_CLIENT_SECRET -TenantId $env:GRAPH_TENANT_ID
New-MgApplication -BodyParameter $params
