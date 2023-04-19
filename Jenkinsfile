pipeline {
    agent any
    parameters {
    choice(
      name: 'Env',
      choices: ['DEV', 'QA', 'UAT', 'PROD'],
      description: 'Passing the Environment'
     )
     choice(
      name: 'Version',
      choices: ['1.0.1', '1.0.2', '1.0.3'],
      description: 'Passing the Environment'
     )
     text(
          name: 'redirectURLS'
         )
     string(
          defaultValue: 'scriptcrunch', 
          name: 'AppName', 
          trim: true
        )
    }
    stages {
        stage('Install Microsoft.Graph Module') {
            steps {
                // Add the PowerShell directory to PATH environment variable
                env.PATH = "${tool 'PowerShell'}/" + env.PATH
                
                // Install Microsoft.Graph module
                powershell(script: 'Install-Module -Name Microsoft.Graph -Force')
            }
        }
         stage('Build') {
            steps {
            // Call PowerShell script with build parameters
        script {
                            env.Env = params.Env
                            env.Version = params.Version
                            env.AppName = params.AppName
                          } 

                // Call PowerShell script with parameters
                // bat "powershell -ExecutionPolicy Bypass -File path/to/your/script.ps1 -param1Value $param1Value -param2Value $param2Value"
                 echo "Env 1: ${env.Env}"
                 echo "Version 2: ${env.Version}"
                 echo "AppName 3: ${env.AppName}"
                sh "pwsh ./adb2conboardingscript.ps1 ${env.Env} ${env.Version} ${env.AppName}"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Hello Deploy'
            }
        }
        stage('Test') {
            steps {
                echo 'Hello Test'
            }
        }
        stage('Release') {
            steps {
                echo 'Hello Release'
            }
        }
    }
}
