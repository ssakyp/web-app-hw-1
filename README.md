# Web App HW 1 - Docker Containerization

This project contains a Spring Boot Java web application containerized using Docker.

---

## 1. Files Added for Docker

* **`Dockerfile`**: A multi-stage build script that first compiles the app with Maven and then runs the resulting JAR file on a lightweight Java JRE runtime.
* **`.dockerignore`**: Prevents unnecessary files (like `target/`, `.git`, or IDE configs) from being copied into the Docker build context, speeding up build times.
* **`src/main/resources/application.properties`**: Configured with `server.port=${PORT:8080}` to allow dynamic port binding via the `PORT` environment variable.

---

## 2. Dockerfile Explained

```dockerfile
# Stage 1: Build the Application
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn -q -DskipTests package

# Stage 2: Runtime Environment
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]