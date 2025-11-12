FROM eclipse-temurin:17-jdk-jammy

ENV SERVER_PORT=${PORT}

# Instalar LibreOffice y utilidades
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-java-common \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Descargar y descomprimir JODConverter 4.4.11
RUN curl -fSL -o jodconverter.zip https://github.com/jodconverter/jodconverter/releases/download/v4.4.11/jodconverter-4.4.11.zip && \
    unzip jodconverter.zip && \
    mv jodconverter-4.4.11/* /app && \
    rm -rf jodconverter.zip jodconverter-4.4.11

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "jodconverter-spring-boot-4.4.11.jar"]
