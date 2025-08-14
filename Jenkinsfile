pipeline{
    agent any
    stages{
        stage("Checkout"){
            steps{
                checkout scm
            }
        }

        stage("maven build"){
            steps{

                sh "mvn clean install"
            }
        }
    }
}