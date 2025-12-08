# Étape 1: Construction de l'application
# Utilise une image Maven avec JDK 11 pour la construction
FROM maven:3.9.0-eclipse-temurin-11 AS builder


# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier pom.xml pour télécharger les dépendances en premier
COPY pom.xml .

# Télécharger les dépendances (cette étape est mise en cache si le pom.xml ne change pas)
RUN mvn dependency:go-offline

# Copier le reste du code source
COPY src ./src

# Construire l'application et créer le JAR
RUN mvn clean install -DskipTests

# Étape 2: Création de l'image finale
# Utilise une image JRE 11 minimale pour l'exécution
FROM openjdk:11-jre-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier le JAR construit depuis l'étape 'builder'
# Le nom du JAR est school-1.0.0.jar basé sur le pom.xml
COPY --from=builder /app/target/school-1.0.0.jar app.jar

# Exposer le port par défaut de Spring Boot
EXPOSE 8080

# Commande pour exécuter l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
