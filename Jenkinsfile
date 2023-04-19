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
                 // Access parameter values and set as environment variables
                  script {
                            env.Env = params.Env
                            env.Version = params.Version
                          } 

                // Call PowerShell script with parameters
                // bat "powershell -ExecutionPolicy Bypass -File path/to/your/script.ps1 -param1Value $param1Value -param2Value $param2Value"
                echo ${env.Env}
                echo ${env.Version}
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
