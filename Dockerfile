# Use the official Tomcat image
FROM tomcat:10-jdk17-openjdk-slim

# Remove the default Tomcat web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your project files into the Tomcat webapps folder
# Assuming your JSP/HTML files are in 'WebContent' or 'src/main/webapp'
COPY ./WebContent /usr/local/tomcat/webapps/ROOT

# If you have compiled .class files (Servlets), they must be in:
# /usr/local/tomcat/webapps/ROOT/WEB-INF/classes