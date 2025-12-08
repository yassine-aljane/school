# -----------------------------
# Étape 1: Build
# -----------------------------
# Maven + Eclipse Temurin JDK 11
FROM maven:3.9.0-eclipse-temurin-11 AS builder

WORKDIR /app

# Copier pom.xml et télécharger les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le code source
COPY src ./src

# Compiler le projet et créer le JAR (skip tests)
RUN mvn clean install -DskipTests

# -----------------------------
# Étape 2: Image finale
# -----------------------------
# JRE 11 valide pour exécution
FROM eclipse-temurin:11-jre AS runner

WORKDIR /app

# Copier le JAR depuis l’étape builder
COPY --from=builder /app/target/school-1.0.0.jar app.jar

# Exposer le port Spring Boot
EXPOSE 8080

# Lancer l’application
ENTRYPOINT ["java", "-jar", "app.jar"]
