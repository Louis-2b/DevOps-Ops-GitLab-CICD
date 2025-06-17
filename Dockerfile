##############################################
# Étape 1 : build de l'application Spring boot
##############################################
# Build avec Gradle
FROM gradle:8.4-jdk21 AS builder

# Définit le répertoire de travail pour l'étape de build
WORKDIR /app

# Copier les fichiers Gradle pour initialiser le Wrapper
COPY gradlew build.gradle settings.gradle /app/
COPY gradle /app/gradle

# Copier le dossier de configuration pour Checkstyle
COPY config /app/config/

# Rendre le script Gradle exécutable
RUN chmod +x gradlew

# Télécharger les dépendances pour mettre en cache
RUN ./gradlew dependencies --no-daemon

# Copier les sources
COPY src /app/src/

# Compiler et construire le JAR (sans exécuter les tests)
RUN ./gradlew clean build -x test --no-daemon --stacktrace


################################
# Étape 2 : exécution de l'image
################################
# Image finale minimaliste
FROM eclipse-temurin:21-jre

# Créer un dossier pour l'application
WORKDIR /app

# Copier le JAR depuis le builder
COPY --from=builder /app/build/libs/*.jar /app/spring-mysql-demo.jar

# Port exposé
EXPOSE 8080

# Commande pour lancer l'application
CMD ["java", "-jar", "spring-mysql-demo.jar"]
