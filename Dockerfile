FROM adoptopenjdk:17-jre-alpine
WORKDIR /app
COPY build/libs/*.jar app.jar
USER 1000:1000
CMD ["java", "-jar", "app.jar"]
