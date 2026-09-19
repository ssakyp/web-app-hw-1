# Web App HW 1 - Docker Containerization

This project is a small Spring Boot web application. It exposes a simple HTTP endpoint at `/hello` and can be run in Docker.

## What was added

### `Dockerfile`
Builds the application in a multi-stage image:
- **Build stage** uses Maven and Java 21 to compile the app and create the JAR file.
- **Run stage** uses a smaller Java 21 JRE image to run the compiled JAR.

This keeps the final image smaller and cleaner than shipping the full build environment.

### `.dockerignore`
Excludes files that should not be copied into the Docker build context, such as:
- `target/`
- IDE files
- Git metadata

This helps keep builds faster and avoids unnecessary files in the image.

### `src/main/resources/application.properties`
Adds:
```properties
server.port=${PORT:8080}
```
This means the app uses the `PORT` environment variable if it is provided, otherwise it falls back to port `8080`.

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

## Files added for Docker

- `Dockerfile` - builds and runs the app in a container.
- `.dockerignore` - keeps the build context small.
- `README.md` - explains how containerization works and how to use Docker commands.

