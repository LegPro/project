# Use official Tomcat base image
FROM tomcat:9.0-jdk17

# Clean default webapps to avoid conflict
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy pre-built WAR file into Tomcat's webapps as ROOT.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
