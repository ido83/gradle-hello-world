# Stage 1: Build stage
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /workspace

# העתקת קבצי מעטפת ה-Gradle תחילה לטובת ניצול מטמון שכבות (Layer Caching)
COPY gradlew .
COPY gradle gradle
COPY build.gradle.kts settings.gradle* ./
RUN chmod +x ./gradlew

# העתקת קוד המקור ובניית ה-Fat JAR
COPY src src
ARG APP_VERSION=1.0.0
RUN ./gradlew shadowJar -Pversion=${APP_VERSION} --no-daemon

# Stage 2: Minimal Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# אבטחה: יצירת משתמש וקבוצה שאינם Root (Least Privilege)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# העתקת ה-Fat JAR שנוצר משלב הבנייה עם הרשאות ריצה למשתמש הלא-פריבילגי
COPY --from=builder --chown=appuser:appgroup /workspace/build/libs/*all.jar app.jar

USER appuser

ENTRYPOINT ["java", "-jar", "app.jar"]
