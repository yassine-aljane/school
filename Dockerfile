# -----------------------------
# Étape 1: Build
# -----------------------------
# Maven + JDK 11 valide
FROM maven:3.9.0-eclipse-temurin-11 AS builder

WORKDIR /app

# Copier pom.xml et télécharger les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le code source
COPY src ./src

# Compiler le projet et créer le JAR
RUN mvn clean install -DskipTests

# -----------------------------
# Étape 2: Image finale
# -----------------------------
# JRE 11 valide pour exécution
FROM openjdk:11-jre-slim-bullseye

WORKDIR /app

# Copier le JAR depuis l’étape builder
COPY --from=builder /app/target/school-1.0.0.jar app.jar

# Exposer le port Spring Boot
EXPOSE 8080

# Lancer l’application
ENTRYPOINT ["java", "-jar", "app.jar"]
