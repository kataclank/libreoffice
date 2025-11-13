FROM eclipse-temurin:17-jdk-jammy

RUN apt-get update && \
    apt-get install -y libreoffice libreoffice-java-common fonts-dejavu-core fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY jodconverter-spring-boot-4.4.11.jar ./jodconverter-spring-boot.jar

ENV JODCONVERTER_OFFICE_HOME=/usr/lib/libreoffice
ENV JODCONVERTER_OFFICE_PORT_NUMBERS=2002
ENV JODCONVERTER_TASK_EXECUTION_TIMEOUT=300000
ENV JODCONVERTER_TASK_QUEUE_TIMEOUT=60000
ENV SERVER_PORT=${PORT}

EXPOSE 8080

ENTRYPOINT ["java","-jar","jodconverter-spring-boot.jar"]



