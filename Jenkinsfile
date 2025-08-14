pipeline{
    agent any 

    stages{
        stage("Checkout"){
            steps{
                checkout scm
            }
        }
    stage("Maven Build"){
            steps{
                sh "mvn clean install"
            }
    }
}