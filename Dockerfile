# Stage 1: Build stage
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /workspace

COPY gradlew .
COPY gradle gradle
COPY build.gradle.kts settings.gradle* ./
RUN chmod +x ./gradlew

COPY src src
ARG APP_VERSION=1.0.0
RUN ./gradlew shadowJar -Pversion=${APP_VERSION} --no-daemon

# Stage 2: Minimal Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder --chown=appuser:appgroup /workspace/build/libs/*all.jar app.jar

USER appuser

ENTRYPOINT ["java", "-jar", "app.jar"]
