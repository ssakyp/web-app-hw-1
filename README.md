# Web App HW 1 - Docker Containerization

This project contains a Spring Boot Java web application containerized using Docker.

---

## 1. Project Configuration Files

* **`Dockerfile`**: Defines the multi-stage build process. It first uses a Maven image to compile the application JAR file and then copies the output into a lightweight Java 21 runtime image.
* **`.dockerignore`**: Prevents build artifacts (like `target/`), Git metadata (`.git`), and IDE configs from being included in the Docker build context.
* **`src/main/resources/application.properties`**: Uses `server.port=${PORT:8080}` to bind the HTTP server dynamically to the `PORT` environment variable passed into the container.

---

## 2. Dockerfile Breakdown

```dockerfile
# Stage 1: Compile the source code
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn -q -DskipTests package

# Stage 2: Create runtime container
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

```
## How to build the image


From the project root:

```bash
docker build -t web-app-hw-1 .
```

## How to run the container

```bash
docker run --rm -p 8080:8080 -e PORT=8080 web-app-hw-1
```

If you want to use a different host port, you can still map it to the container port:

```bash
docker run --rm -p 8081:8080 -e PORT=8080 web-app-hw-1
```

## Check that it works

Open in a browser or use curl:

```bash
curl http://localhost:8080/hello
```

Expected response:

```text
Hello, World!
```

## Useful Docker commands

### List images
```bash
docker images
```

### List running containers
```bash
docker ps
```

### Stop a running container
```bash
docker stop <container_id>
```

### Remove an unused image
```bash
docker rmi web-app-hw-1
```

### View container logs
```bash
docker logs <container_id>
```