# Build stage
FROM openjdk:11-jdk-slim as build
WORKDIR /workspace/app

COPY gradlew .
COPY gradle gradle
RUN chmod +x ./gradlew

# Copy the correct build script file
COPY build.gradle.kts .
COPY src src

RUN ./gradlew clean build

# Package stage
FROM openjdk:11-jre-slim
WORKDIR /app

COPY --from=build /workspace/app/build/libs/*.jar app.jar

RUN useradd -m myuser
USER myuser

CMD ["java", "-jar", "app.jar"]
