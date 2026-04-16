# gradle-hello-world
### Java Hello World using the Gradle Wrapper and the Kotlin DSL

This project demonstrates a standard Java build lifecycle using Gradle, Docker, and GitHub Actions. It is designed to be environment-agnostic, secure, and fully automated.

---

## Prerequisites
* **Docker Hub Account**: You must be logged into Docker (locally or via Docker Desktop) to build and push images.
* **GitHub Secrets**: For the CI/CD pipeline to function, ensure `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` (Read/Write) are configured in your GitHub repository settings under **Secrets and variables > Actions**.

---

## Tasks
* **build**: Compiles the Java code and creates JAR files.
  * `gradle-hello-world-all.jar`: A "Fat JAR" containing all dependencies (use this for execution).
  * `gradle-hello-world.jar`: A regular JAR containing only project classes.

---

## Quick Start Commands

### 1. Building with Docker (Recommended)
Since this project requires JDK 17, use Docker to build the image without worrying about your local Java version. This utilizes a multi-stage build process.
```bash
docker build -t kepler-signal .
```

### 2. Running the Container
After building the Docker image, run it to verify the "Signal" output:
```bash
docker run --rm kepler-signal
```

### 3. Native Build (Requires local JDK 17)
If you have JDK 17 installed on your host machine, you can build the JAR directly using the Gradle Wrapper:
```bash
# Windows (PowerShell/CMD)
.\gradlew build

# Linux/Mac
./gradlew build
```