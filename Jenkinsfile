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
          name: 'MULTI-LINE-STRING'
         )
     string(
          defaultValue: 'scriptcrunch', 
          name: 'STRING-PARAMETER', 
          trim: true
        )
    }
    stages {
        stage('Build') {
            steps {
                // Access parameter values
                def param1Value = params.Env
                def param2Value = params.Version

                // Call PowerShell script with parameters
                // bat "powershell -ExecutionPolicy Bypass -File path/to/your/script.ps1 -param1Value $param1Value -param2Value $param2Value"
                echo param1Value 
                echo param2Value 
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
