# Etapa 1: Build del proyecto
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app
COPY . .

# Agrega permiso de ejecución al wrapper
RUN chmod +x mvnw

# Compila el proyecto sin tests
RUN ./mvnw clean package -DskipTests

# Etapa 2: Runtime final
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copia el JAR generado
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
