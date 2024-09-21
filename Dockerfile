FROM openjdk:17-alpine
WORKDIR /app
COPY build/libs/gradle-hello-world-all.jar app.jar
USER 1000:1000
CMD ["java", "-jar", "app.jar"]
