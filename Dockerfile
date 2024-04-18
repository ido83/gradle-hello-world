FROM openjdk:11-jre-slim
COPY build/libs/*.jar /app/helloworld.jar
WORKDIR /app
RUN useradd -m myuser
USER myuser
CMD ["java", "-jar", "helloworld.jar"]
