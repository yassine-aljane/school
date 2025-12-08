# Image finale avec JRE 17 Alpine
FROM eclipse-temurin:17-jre-alpine

# Définir le répertoire de travail
WORKDIR /lapp

# Copier le JAR depuis le répertoire target
COPY yassinealj/school-1.0.0.jar app.jar

# Exposer le port de l'application
EXPOSE 8089

# Commande pour exécuter le JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
