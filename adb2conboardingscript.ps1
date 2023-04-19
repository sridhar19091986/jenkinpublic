
param (
  [string]$Env,
  [string]$Version,
  [string]$AppName
)

Write-Host "Parameter 1: $Env"
Write-Host "Parameter 2: $Version"
Write-Host "Parameter 3: $AppName" 
Write-Host "Parameter 4: $env:GRAPH_CLIENT_ID" 
Write-Host "Parameter 5: $env:GRAPH_CLIENT_SECRET" 
Write-Host "Parameter 6: $env:GRAPH_TENANT_ID" 

Import-Module Microsoft.Graph.Applications

$params = @{
	displayName = $AppName
}
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $body = @{grant_type = "client_credentials"; scope = "https://graph.microsoft.com/.default"; client_id = $env:GRAPH_CLIENT_ID; client_secret = $env:GRAPH_CLIENT_SECRET }
    $response = Invoke-RestMethod -Uri https://login.microsoftonline.com/$env:GRAPH_TENANT_ID/oauth2/v2.0/token -Method Post -Body $body
    $token = $response.access_token
Write-Host "Parameter 7: $token"					
    Connect-MgGraph -AccessToken $token -ErrorAction Stop
# Connect-MgGraph -ClientCredential $env:GRAPH_CLIENT_ID -ClientSecret $env:GRAPH_CLIENT_SECRET -TenantId $env:GRAPH_TENANT_ID
New-MgApplication -BodyParameter $params
