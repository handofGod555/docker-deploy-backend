# Use OpenJDK 16 on Alpine Linux as the base image
FROM openjdk:16-jdk-alpine

# Create a 'spring' user and group
RUN addgroup -S spring && adduser -S spring -G spring

# Expose port 8080 for the backend application
EXPOSE 8080

# Set the Java profile to 'prod' by default
ENV JAVA_PROFILE prod

# Define the dependency path
ARG DEPENDENCY=target/dependency

# Copy dependencies to the container
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

# Define the entry point to run the Spring Boot application
ENTRYPOINT ["java", 
  "-Dspring.profiles.active=${JAVA_PROFILE}",
  "-cp", "app:app/lib/*",
  "camt.se234.lab10.Lab10Application"
]
