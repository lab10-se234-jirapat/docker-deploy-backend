# Use OpenJDK 16 on Alpine Linux
FROM openjdk:16-jdk-alpine

# Create a new user and group for running the Spring Boot application
RUN addgroup -S spring && adduser -S spring -G spring

# Expose port 8080 for the application
EXPOSE 8080

# Set environment variables
ENV JAVA_PROFILE=prod

# Define the dependency target directory
ARG DEPENDENCY=target/dependency

# Copy application dependencies and classes
COPY ${DEPENDENCY}/BOOT-INF/lib/ app/lib/
COPY ${DEPENDENCY}/META-INF/ app/META-INF/
COPY ${DEPENDENCY}/BOOT-INF/classes/ app/

# Set the entry point to run the Spring Boot application
ENTRYPOINT ["java", "-Dspring.profiles.active=${JAVA_PROFILE}", "-cp", "app:app/lib/*", "camt.se234.lab10.Lab10Application"]
