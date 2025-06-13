##############################################
# Étape 1 : build de l'application Spring boot
##############################################
# Build avec Gradle
FROM gradle:8.4-jdk21 AS builder

# Définit le répertoire de travail pour l'étape de build
WORKDIR /app

# Copie des fichiers nécessaires pour le build
COPY build.gradle settings.gradle /app/
COPY gradlew /app/
COPY gradle /app/gradle
COPY src /app/src

# Donner les permissions au script gradlew
RUN chmod +x gradlew

# Compiler et construire le JAR (sans exécuter les tests)
RUN /app/gradlew clean build -x test --no-daemon


################################
# Étape 2 : exécution de l'image
################################
# Image finale minimaliste
FROM openjdk:21-jdk-slim

# Créer un dossier pour l'application
WORKDIR /app

# Copier le JAR depuis le builder
COPY --from=builder /app/build/libs/*.jar /app/spring-mysql-demo.jar

# Port exposé
EXPOSE 8080

# Commande pour lancer l'application
CMD ["java", "-jar", "spring-mysql-demo.jar"]
