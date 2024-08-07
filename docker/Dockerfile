FROM tomcat:8
ENV NEXUS_URL=http://13.250.210.184:8081/repository/web-application/in/javahome/myweb/0.0.5/myweb-0.0.5.war
RUN apt-get update && apt-get install -y wget
RUN wget -O /usr/local/tomcat/webapps/myweb.war ${NEXUS_URL}
EXPOSE 8080
ENTRYPOINT ["catalina.sh", "run"]