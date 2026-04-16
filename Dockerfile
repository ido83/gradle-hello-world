# Stage 1: Build
FROM gradle:7.6-jdk17 AS builder
WORKDIR /home/gradle/src

# Copy everything with the right permissions for the 'gradle' user
COPY --chown=gradle:gradle . .

# Ensure the script is executable (Linux safety measure)
RUN chmod +x gradlew

# Build the fat JAR
RUN ./gradlew build --no-daemon

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Keplerian Safety Protocol: Run as non-root user
# Note: Alpine uses 'adduser' instead of 'useradd'
RUN adduser -D erez
USER erez

# Copy the specific JAR produced by the build
COPY --from=builder /home/gradle/src/build/libs/*-all.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]