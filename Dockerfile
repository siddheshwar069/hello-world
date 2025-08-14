FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY build/webapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps

