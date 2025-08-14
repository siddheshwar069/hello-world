pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Deploy to Tomcat') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'deployer', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASS')]) {
                    script {
                        def warPath = 'target/webapp-1.0-SNAPSHOT.war'
                        def contextPath = 'webapp-1.0-SNAPSHOT.war'

                        sh """
                        curl -u $TOMCAT_USER:$TOMCAT_PASS \
                             --upload-file ${warPath} \
                             "http://192.168.255.132:9090//manager/text/deploy?path=/${contextPath}&update=true"
                        """
                    }
                }
            }
        }
    }
}
