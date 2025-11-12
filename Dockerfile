# Usa una imagen base de Java ligera
FROM eclipse-temurin:17-jdk-jammy

# Versión de JODConverter
ENV JOD_VERSION=4.4.8
ENV SERVER_PORT=8080

# Instalar LibreOffice y utilidades necesarias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-java-common \
    curl \
    unzip && \
    rm -rf /var/lib/apt/lists/*

# Directorio de la app
WORKDIR /app

# Descargar y preparar JODConverter
RUN curl -L -o jodconverter.zip https://github.com/sbraconnier/jodconverter/releases/download/v${JOD_VERSION}/jodconverter-spring-boot-${JOD_VERSION}.zip && \
    unzip jodconverter.zip && \
    mv jodconverter-spring-boot-${JOD_VERSION}/* /app && \
    rm -rf jodconverter.zip jodconverter-spring-boot-${JOD_VERSION}

# Exponer el puerto
EXPOSE 8080

# Comando de arranque
ENTRYPOINT ["java", "-jar", "jodconverter-spring-boot-4.4.8.jar"]
