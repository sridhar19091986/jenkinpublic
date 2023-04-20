
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

# $params = @{
# 	displayName = $AppName
#         IdentifierUris = "https://myb2capp" 
# 	ReplyUrls = "https://myb2capp/replyurl"  
#        }
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $body = @{grant_type = "client_credentials"; scope = "https://graph.microsoft.com/.default"; client_id = $env:GRAPH_CLIENT_ID; client_secret = $env:GRAPH_CLIENT_SECRET }
    $response = Invoke-RestMethod -Uri https://login.microsoftonline.com/$env:GRAPH_TENANT_ID/oauth2/v2.0/token -Method Post -Body $body
    $token = $response.access_token
Write-Host "Parameter 7: $token"	

Connect-MgGraph -AccessToken $token -ErrorAction Stop

$web = @{
    RedirectUris = "https://localhost:5001/signin-oidc"
    ImplicitGrantSettings = @{ EnableIdTokenIssuance = $true }
}

$createAppParams = @{
    DisplayName = "AspNetWebApp"
    Web = $web
    RequiredResourceAccess = @{
        ResourceAppId = "00000003-0000-0000-c000-000000000000"
        ResourceAccess = @(
            @{
                Id = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"
                Type = "Scope"
            }
	      @{
                Id = "37f7f235-527c-4136-accd-4a02d197296e"
                Type = "Scope"
            }
        )
    }
}
    
# Connect-MgGraph -ClientCredential $env:GRAPH_CLIENT_ID -ClientSecret $env:GRAPH_CLIENT_SECRET -TenantId $env:GRAPH_TENANT_ID
$newApplication = New-MgApplication $createAppParams
# Add a scope to the application
New-MgApplicationScope -ApplicationId $newApplication.AppId `
                       -DisplayName "read" `
                       -AdminConsentDisplayName "read" `
                       -UserConsentDisplayName "read" `
                       -IsEnabled $true `
                       -Type "Admin" ` 
