# Build stage
FROM openjdk:11-jdk-slim as build
WORKDIR /workspace/app

# Copy gradle executable and batch file, and grant execution permissions
COPY gradlew .
COPY gradle gradle
RUN chmod +x ./gradlew

# Copy build script and source code
COPY build.gradle .
COPY src src

# Execute Gradle Wrapper to build the JAR
RUN ./gradlew clean build

# Package stage
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy JAR from build stage
COPY --from=build /workspace/app/build/libs/*.jar app.jar

# Non-root user setup
RUN useradd -m maxskalt
USER maxskalt


CMD ["java", "-jar", "app.jar"]
