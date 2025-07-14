# Usa la imagen oficial de OpenJDK 17
FROM eclipse-temurin:17-jdk-alpine

# Crea el directorio para la app
WORKDIR /app

# Copia el jar a la imagen
COPY target/autores-0.0.1.jar app.jar

# Expone el puerto que usará la app
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["java", "-jar", "app.jar"]
