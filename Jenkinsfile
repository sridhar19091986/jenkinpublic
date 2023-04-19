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
        stage('Build') {
            steps {
            // Call PowerShell script with build parameters
        powershell '''
          // Access build parameters from Jenkinsfile
          def envValue = "${params.Env}"
          def versionValue = "${params.Version}"
          def appNameValue = "${params.AppName}"

          // Call PowerShell script with build parameters
          bat """
            .\\adb2conboardingscript.ps1 -Env $envValue -Version $versionValue -AppName $appNameValue
          """
        '''
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
