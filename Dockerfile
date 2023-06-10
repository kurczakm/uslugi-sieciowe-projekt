FROM ubuntu:latest AS builder
RUN apt-get update && apt-get install openjdk-17-jdk -y
COPY . .
RUN ./gradlew bootJar --no-daemon

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=builder /build/libs/rest-api-1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
