# Étape 1 : Utiliser Maven pour construire l'application
FROM maven:3.8.4-openjdk-17 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier tout le contenu du répertoire de l'application dans le conteneur
COPY . .

# Construire l'application avec Maven, en ignorant les tests
RUN mvn clean package -DskipTests

# Étape 2 : Utiliser une image Java allégée pour l'exécution
FROM openjdk:17-jdk-slim

# Définir le répertoire de travail pour l'étape de production
WORKDIR /app

# Copier l'application construite depuis l'étape précédente (build)
COPY --from=build /app/target/spring-petclinic-*.jar app.jar

# Exposer le port 8080 (le port sur lequel l'application Spring Boot écoute)
EXPOSE 8080

# Spécifier la commande à exécuter lorsque le conteneur démarre
ENTRYPOINT ["java", "-jar", "app.jar"]

