pipeline{
    agent any
     environment {
        TOMCAT_URL = 'http://192.168.255.132:9090/'
        WAR_FILE = '/var/lib/jenkins/.m2/repository/com/example/maven-project/webapp/1.0-SNAPSHOT/webapp-1.0-SNAPSHOT.war'  
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
                        WAR_NAME=$(basename "$WAR_FILE" .war)
                        echo "Deploying $WAR_FILE as context /$WAR_NAME"

                        curl -v --user "$TOMCAT_USER:$TOMCAT_PASS" \
                             --upload-file "$WAR_FILE" \
                             "$TOMCAT_URL/deploy?path=/$WAR_NAME&update=true"
                        '''

                    }
                }
            }
        }
    }
}