# =========================
# Etapa 1: Build con Maven
# =========================
FROM maven:3.9.1-eclipse-temurin-17 AS build

WORKDIR /build

# Descargar solo el ZIP de Spring Boot starter
RUN curl -L -o springboot.zip https://github.com/jodconverter/jodconverter/releases/download/v4.4.11/jodconverter-spring-boot-starter-4.4.11.zip && \
    unzip springboot.zip && \
    mv jodconverter-spring-boot-starter-4.4.11/* . && \
    rm -f springboot.zip

# Construir el JAR ejecutable
RUN mvn package -DskipTests

# =========================
# Etapa 2: Imagen final ligera
# =========================
FROM eclipse-temurin:17-jdk-jammy

# Instalar LibreOffice y utilidades
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libreoffice libreoffice-java-common curl unzip fonts-dejavu-core fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar el JAR compilado
COPY --from=build /build/target/jodconverter-spring-boot-*.jar ./jodconverter-spring-boot.jar

# Configuración JODConverter
ENV JODCONVERTER_OFFICE_HOME=/usr/lib/libreoffice
ENV JODCONVERTER_OFFICE_PORT_NUMBERS=2002
ENV JODCONVERTER_TASK_EXECUTION_TIMEOUT=300000
ENV JODCONVERTER_TASK_QUEUE_TIMEOUT=60000
ENV SPRING_PROFILES_ACTIVE=prod
ENV SERVER_PORT=${PORT}

EXPOSE 8080

ENTRYPOINT ["java","-jar","jodconverter-spring-boot.jar"]



