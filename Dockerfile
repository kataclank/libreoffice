# =========================
# Base: Java + LibreOffice
# =========================
FROM eclipse-temurin:17-jdk-jammy

LABEL maintainer="rafa@ejemplo.com"
LABEL description="LibreOffice + JODConverter REST optimizado para Render.com Free"

ENV DEBIAN_FRONTEND=noninteractive

# Instalar LibreOffice headless y dependencias
RUN apt-get update && \
    apt-get install -y libreoffice libreoffice-writer libreoffice-calc libreoffice-impress \
    fonts-dejavu-core fonts-liberation curl unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# =========================
# App: JODConverter
# =========================
WORKDIR /app

# Descargar JODConverter Spring Boot server
ENV JOD_VERSION=4.4.8
RUN curl -L -o jodconverter.zip https://github.com/sbraconnier/jodconverter/releases/download/v${JOD_VERSION}/jodconverter-spring-boot-${JOD_VERSION}.zip && \
    unzip jodconverter.zip && \
    mv jodconverter-spring-boot-${JOD_VERSION}/* /app && \
    rm -rf jodconverter.zip jodconverter-spring-boot-${JOD_VERSION}

# =========================
# Configuración
# =========================
# Render asigna el puerto mediante la variable $PORT
EXPOSE 10000
ENV SERVER_PORT=${PORT}
ENV JODCONVERTER_OFFICE_HOME=/usr/lib/libreoffice
ENV JODCONVERTER_OFFICE_PORT_NUMBERS=2002
ENV JODCONVERTER_TASK_EXECUTION_TIMEOUT=300000
ENV JODCONVERTER_TASK_QUEUE_TIMEOUT=60000
ENV SPRING_PROFILES_ACTIVE=prod

# =========================
# Arranque
# =========================
ENTRYPOINT ["java","-jar","jodconverter-spring-boot.jar"]
