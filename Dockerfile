# Étape 1: Construction de l'application
FROM maven:3.9.0-eclipse-temurin-11 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean install -DskipTests

# Étape 2: Image finale
FROM openjdk:11-jre-slim-bullseye
WORKDIR /app
COPY --from=builder /app/target/school-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
