# -----------------------------
# Étape 1: Construction de l'application
# -----------------------------
# Utilise une image Maven avec JDK 11 pour compiler le projet
FROM maven:3.9.0-eclipse-temurin-11 AS builder

WORKDIR /app

# Copier le fichier pom.xml et télécharger les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le code source
COPY src ./src

# Compiler le projet et créer le JAR (tests skipped)
RUN mvn clean install -DskipTests

# -----------------------------
# Étape 2: Image finale
# -----------------------------
# Utilise une image JRE 11 existante
FROM openjdk:11-jre-slim-bullseye

WORKDIR /app

# Copier le JAR depuis l'étape builder
COPY --from=builder /app/target/school-1.0.0.jar app.jar

# Exposer le port Spring Boot
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
