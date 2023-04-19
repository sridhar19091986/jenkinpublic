# PowerShell script.ps1
 Import-Module Microsoft.Graph.Applications
          
          # Define parameters
          $env = "${params.Env}"
          $version = "${params.Version}"
          $appName = "${params.AppName}"
          
          # Call New-MgApplication cmdlet with parameters
          New-MgApplication -Env $env -Version $version -AppName $appName
