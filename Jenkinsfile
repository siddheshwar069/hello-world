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
        /*stage('Deploy-to-Tomcat') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'deployer', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASS')]) {
                    script {
                        def warPath = '/var/lib/jenkins/.m2/repository/com/example/maven-project/webapp/1.0-SNAPSHOT/webapp-1.0-SNAPSHOT.war'
                        def contextPath = 'webapp-1.0-SNAPSHOT'



                        sh """
                        curl -u $TOMCAT_USER:$TOMCAT_PASS \
                             --upload-file ${warPath} \
                             "http://192.168.255.132:9090/manager/text/deploy?path=/${contextPath}&update=true"
                        """
                    }
                }
            }
        }*/
        stage('Prepare WAR file') {
            steps {
                sh '''
                    mkdir -p build
                    cp /var/lib/jenkins/.m2/repository/com/example/maven-project/webapp/1.0-SNAPSHOT/webapp-1.0-SNAPSHOT.war build/
                '''
            }
        }
        stage('Clean Docker') {
            steps {
                sh '''
                    docker rm -f $(docker ps -aq) 2>/dev/null || true && \
                    docker rmi -f $(docker images -aq) 2>/dev/null || true && \
                    docker volume rm $(docker volume ls -q) 2>/dev/null || true
                '''
            }
        }
        stage("buildTomcatImage"){
            steps{
                sh '''
                    docker build -t helloworldwebapp .
                '''
            }
        }
        stage("RunWebapp"){
            steps{
                sh '''
                    docker run -d -p 9090:8080 helloworldwebapp
                '''
            }
        }
        stage('Clean Docker') {
            steps {
                sh '''
                    docker rm -f $(docker ps -aq) 2>/dev/null || true && \
                    docker rmi -f $(docker images -aq) 2>/dev/null || true && \
                    docker volume rm $(docker volume ls -q) 2>/dev/null || true
                '''
            }
        }
    }
}
