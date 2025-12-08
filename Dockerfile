# -----------------------------
# Étape 1: Construction de l'application
# -----------------------------
# Utilise une image Maven avec JDK 11 pour compiler le projet
FROM maven:3.9.0-eclipse-temurin-11 AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier pom.xml et télécharger les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le reste du code source
COPY src ./src

# Compiler le projet et créer le JAR (sans exécuter les tests)
RUN mvn clean install -DskipTests

# -----------------------------
# Étape 2: Création de l'image finale
# -----------------------------
# Utilise une image JRE 11 minimale pour exécuter l'application
FROM openjdk:11-jre-slim-bullseye

# Définir le répertoire de travail
WORKDIR /app

# Copier le JAR construit depuis l'étape builder
COPY --from=builder /app/target/school-1.0.0.jar app.jar

# Exposer le port par défaut de Spring Boot
EXPOSE 8080

# Commande pour exécuter l'application
ENTRYPOINT ["java", "-jar", "app.jar"]

ENTRYPOINT ["java", "-jar", "app.jar"]
