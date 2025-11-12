# =========================
# Base: Java 17 ligera
# =========================
FROM eclipse-temurin:17-jdk-jammy

# Puerto asignado por Render
ENV SERVER_PORT=${PORT}

# Instalar LibreOffice y utilidades
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-java-common \
    curl \
    unzip \
    fonts-dejavu-core fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# Directorio de la aplicación
WORKDIR /app

# Descargar JODConverter Spring Boot 4.4.11 directamente desde GitHub
RUN curl -L -o jodconverter.zip https://github.com/jodconverter/jodconverter/releases/download/v4.4.11/jodconverter-spring-boot-starter-4.4.11.zip && \
    unzip jodconverter.zip && \
    mv jodconverter-spring-boot-starter-4.4.11/* /app && \
    rm -rf jodconverter.zip jodconverter-spring-boot-starter-4.4.11

# Exponer el puerto
EXPOSE 8080

# Configuración JODConverter:
# 1 instancia de LibreOffice, tareas en cola
ENV JODCONVERTER_OFFICE_HOME=/usr/lib/libreoffice
ENV JODCONVERTER_OFFICE_PORT_NUMBERS=2002
ENV JODCONVERTER_TASK_EXECUTION_TIMEOUT=300000
ENV JODCONVERTER_TASK_QUEUE_TIMEOUT=60000
ENV SPRING_PROFILES_ACTIVE=prod

# Arranque del servidor REST
ENTRYPOINT ["java","-jar","jodconverter-spring-boot.jar"]

