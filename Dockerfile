# Étape 1: Build de l'application avec Maven + JDK 11 (Eclipse Temurin)
FROM eclipse-temurin:11-jdk AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean install -DskipTests

# Étape 2: Image finale avec JRE 11
FROM openjdk:11-jre AS runner

WORKDIR /app

COPY --from=builder /app/target/school-1.0.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
