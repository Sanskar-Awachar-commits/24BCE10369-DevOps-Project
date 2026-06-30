# Use a lightweight, stable OpenJDK image (Java 21 LTS)
FROM eclipse-temurin:21-jdk-alpine

# Set metadata for your assignment
LABEL maintainer="DevOps Student"
LABEL description="Corporate Company Website Deployment"

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled JAR file from the Maven target directory into the container
# (We will configure Jenkins to build this JAR before the Docker build step)
COPY target/employee-portal-1.0.0.jar app.jar

# Expose port 8080 so the browser and Nagios can access the web server
EXPOSE 8080

# Command to execute the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]