# Etapa 1: Construcción del JAR
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app
COPY . .

# Compila el proyecto y genera el JAR
RUN ./mvnw clean package -DskipTests

# Etapa 2: Imagen final con solo el JAR
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copia el JAR desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Expone el puerto por defecto (puedes cambiarlo si usas otro)
EXPOSE 8080

# Comando de inicio
ENTRYPOINT ["java", "-jar", "app.jar"]
