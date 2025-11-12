# Base: Java 17 ligera
FROM eclipse-temurin:17-jdk-jammy

# Puerto del servicio (Render asigna la variable $PORT)
ENV SERVER_PORT=${PORT}

# Instalar LibreOffice y utilidades necesarias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-java-common \
    curl \
    unzip && \
    rm -rf /var/lib/apt/lists/*

# Directorio de la aplicación
WORKDIR /app

# Descargar y descomprimir JODConverter (versión fija 4.4.11)
RUN curl -L -o jodconverter.zip https://github.com/jodconverter/jodconverter/releases/download/v4.4.11/jodconverter-4.4.11.zip && \
    unzip jodconverter.zip && \
    mv jodconverter-4.4.11/* /app && \
    rm -rf jodconverter.zip jodconverter-4.4.11

# Exponer el puerto
EXPOSE 8080

# Ejecutar el servidor JODConverter
ENTRYPOINT ["java", "-jar", "jodconverter-spring-boot-4.4.11.jar"]
