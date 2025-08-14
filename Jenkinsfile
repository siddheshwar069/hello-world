pipeline{
    agent any
     environment {
        TOMCAT_URL = 'http://192.168.255.132:9090/'
        WAR_FILE = '**/*.war'  
        CREDENTIALS_ID = 'deployer'  
    }
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
        stage("deploy to tomcat"){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: env.CREDENTIALS_ID, usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASS')]){
                        sh '''
                        curl -v --user "$TOMCAT_USER:$TOMCAT_PASS" \
                        --upload-file "$WAR_FILE" \
                        "$TOMCAT_URL/deploy?path=/app&update=true"
                        '''

                    }
                }
            }
        }
    }
}