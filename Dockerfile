# 1. Tomcat 10.1 use karein (Jakarta EE support)
FROM tomcat:10.1-jdk17-openjdk-slim


RUN rm -rf /usr/local/tomcat/webapps/*


COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

#
COPY WEB-INF/ /usr/local/tomcat/webapps/ROOT/WEB-INF/

COPY bin/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Port setup
EXPOSE 8080

# Tomcat start karne ka command
CMD ["catalina.sh", "run"]