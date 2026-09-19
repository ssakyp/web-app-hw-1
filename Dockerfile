# Stage 1: Build the Java application
# specify the base image with Maven and JDK 21
FROM maven:3.9.9-eclipse-temurin-21 AS build
# Set the working directory inside the container
WORKDIR /app
# Copy the pom.xml and source code into the container
COPY . .
# Build the application and package it into a JAR file
RUN mvn -q -DskipTests package

# Stage 2: Run the lightweight JAR image
# Use a lightweight base image with JRE 21
FROM eclipse-temurin:21-jre
# Set the working directory inside the container
WORKDIR /app
# Copy the JAR file from the build stage into the runtime image
COPY --from=build /app/target/*.jar app.jar
# Sets the default executable command that runs automatically when the container starts.
ENTRYPOINT ["java", "-jar", "app.jar"]