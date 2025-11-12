FROM eclipse-temurin:17-jdk-jammy

ENV SERVER_PORT=${PORT}

# Instalar LibreOffice y utilidades
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-java-common \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Descargar directamente el JAR ejecutable de JODConverter Spring Boot
RUN curl -L -o jodconverter-spring-boot-4.4.11.jar \
    https://repo1.maven.org/maven2/org/jodconverter/jodconverter-spring-boot/4.4.11/jodconverter-spring-boot-4.4.11.jar

# Exponer puerto
EXPOSE 8080

# Ejecutar el servidor
ENTRYPOINT ["java", "-jar", "jodconverter-spring-boot-4.4.11.jar"]
