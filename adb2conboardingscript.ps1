
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
# https://www.powershellgallery.com/packages/AzureADB2C/1.7.282/Content/AzureADB2C.psm1
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

# Generate GUIDs for permission scopes
$readPermissionScopeId = [System.Guid]::NewGuid().ToString()
$writePermissionScopeId = [System.Guid]::NewGuid().ToString()
$apiPermissionScopes = @(
    @{
        adminConsentDisplayName = "Read Data"
        adminConsentDescription = "Allows the app to read data from the API"
        userConsentDisplayName = "Read Data"
        userConsentDescription = "Allows the app to read data from the API"
        id = $readPermissionScopeId
        type = "Admin"
        value = "read"
    },
    @{
        adminConsentDisplayName = "Write Data"
        adminConsentDescription = "Allows the app to write data to the API"
        userConsentDisplayName = "Write Data"
        userConsentDescription = "Allows the app to write data to the API"
        id = $writePermissionScopeId
        type = "Admin"
        value = "write"
    }
)


$createAPIParams = @{
    DisplayName = "AspNetWebAPI2"
    IdentifierUris = "https://$env:TenantURL/AspNetWebAPI2"
    Api = @{
    Oauth2PermissionScopes = $apiPermissionScopes
    } 
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
$newAPI = New-MgApplication @createAPIParams  
Write-Host "API Clientid: $newAPI.AppId" 
$newAPI | Format-List

$web = @{
     RedirectUris = @("https://localhost:5001/signin-oidc", "https://localhost:5001/" )
    ImplicitGrantSettings = @{ `
                EnableAccessTokenIssuance = $true; `
                EnableIdTokenIssuance = $true; `
             } `
}
$spa = @{
     RedirectUris = @("https://localhost:5003/signin-oidc", "https://localhost:5003/" ) 
}

$createAppParams = @{
    DisplayName = "AspNetWebApp1"  
    Web = $web
    spa = $spa
    RequiredResourceAccess = @{
        ResourceAppId = $newAPI.AppId
        ResourceAccess = @(
            @{
                Id = $readPermissionScopeId
                Type = "Scope"
            }
	     @{
                Id = $writePermissionScopeId
                Type = "Scope"
            }
        )
    }
}
$newApp = New-MgApplication @createAppParams    
Write-Host "App Clientid $newApp.AppId" 
$newApp | Format-List

$startDate = (Get-Date).Date
$endDate = $startDate.AddMonths(12)
$passwordCred = @{
   displayName = "Valid from $startDate and $endDate"
   startDateTime = $startDate
   endDateTime = $endDate
}
$secret = Add-MgApplicationPassword -applicationId $newApp.Id  -PasswordCredential $passwordCred
$secret | Format-List

$appServicePrincipalID=@{
  "AppId" = $newApp.AppId
  }
$appservicePrincipal = New-MgServicePrincipal -BodyParameter $appServicePrincipalID

$apiServicePrincipalID=@{
  "AppId" = $newAPI.AppId
  }
$apiservicePrincipal = New-MgServicePrincipal -BodyParameter $apiServicePrincipalID

# $Oauth2PermissionreadGrantRequestBody=@{
#   ConsentType = "AllPrincipals"
#   ClientId = $appservicePrincipal.Id
#   ResourceId =  $apiservicePrincipal.Id
#   Scope = "read"  
#   }
  
# New-MgOauth2PermissionGrant -BodyParameter $Oauth2PermissionreadGrantRequestBody

# $Oauth2PermissionwriteGrantRequestBody=@{
#   ConsentType = "AllPrincipals"
#   ClientId = $appservicePrincipal.Id
#   ResourceId =  $apiservicePrincipal.Id
#   Scope = "write"  
#   }
  
# New-MgOauth2PermissionGrant -BodyParameter $Oauth2PermissionwriteGrantRequestBody

# Define the scopes as an array of strings
$scopes = @("write", "read")

# Loop through each scope and create the OAuth 2.0 permission grant
foreach ($scope in $scopes) {
    New-MgOauth2PermissionGrant -ResourceId  $apiservicePrincipal.Id`
                                -Scope $scope `
                                -ClientId $appservicePrincipal.Id`
                                -ConsentType "AllPrincipals" `
}


# Connect-MgGraph -ClientCredential $env:GRAPH_CLIENT_ID -ClientSecret $env:GRAPH_CLIENT_SECRET -TenantId $env:GRAPH_TENANT_ID
# $newApplication = New-MgApplication $createAppParams
# # Add a scope to the application
# New-MgApplicationScope -ApplicationId $newApplication.AppId `
#                        -DisplayName "read" `
#                        -AdminConsentDisplayName "read" `
#                        -UserConsentDisplayName "read" `
#                        -IsEnabled $true `
#                        -Type "Admin" ` 
# Display the newly created application object
# $newApp | Format-Table
