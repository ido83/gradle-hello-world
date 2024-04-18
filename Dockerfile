FROM openjdk:11-jre-slim
COPY build/libs/*.jar /app/helloworld.jar
WORKDIR /app
RUN useradd -m mskalt
USER mskalt
CMD ["java", "-jar", "helloworld.jar"]
