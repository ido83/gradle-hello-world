# Build stage
FROM openjdk:11-jdk-slim as build
WORKDIR /workspace/app

COPY gradlew .
COPY gradle gradle
RUN chmod +x ./gradlew

COPY build.gradle.kts .
COPY src src

# Use shadowJar to ensure the fat JAR is built
RUN ./gradlew clean shadowJar

# Package stage
FROM openjdk:11-jre-slim
WORKDIR /app

# Ensure copying the specific shadow JAR
COPY --from=build /workspace/app/build/libs/app.jar /app/app.jar

RUN useradd -m myuser
USER myuser

CMD ["java", "-jar", "app.jar"]
