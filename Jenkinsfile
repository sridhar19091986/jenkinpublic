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
          stage('Install PowerShell Core') {
     steps {
        // Install PowerShell Core
        sh 'curl -fsSLO https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb'
        sh 'sudo dpkg -i packages-microsoft-prod.deb' // Use sudo to run dpkg with root privileges
        sh 'sudo apt-get update' // Use sudo to run apt-get with root privileges
        sh 'sudo apt-get install -y powershell' // Use sudo to run apt-get with root privileges
      }
    }
        stage('Build') {
            steps {
            // Call PowerShell script with build parameters
        script {
                            env.Env = params.Env
                            env.Version = params.Version
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
