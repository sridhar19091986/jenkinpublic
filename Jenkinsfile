pipeline {
    agent any
    parameters {
    choice(
      name: 'Env',
      choices: ['DEV', 'QA', 'UAT', 'PROD'],
      description: 'Passing the Environment'
     )
    }
    stages {
        stage('Build') {
            steps {
                echo 'Hello Build'
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
