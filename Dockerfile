# ---------------------------------
# Base: JODConverter Runtime 0.4.1
FROM ghcr.io/jodconverter/jodconverter-runtime:0.4.1

WORKDIR /app

# Copia tu aplicación REST ya compilada
COPY jodconverter-rest.jar ./app.jar

# Copia entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Variables de entorno
ENV JODCONVERTER_OFFICE_PORT_NUMBERS=2002
ENV JODCONVERTER_TASK_EXECUTION_TIMEOUT=300000
ENV JODCONVERTER_TASK_QUEUE_TIMEOUT=60000
ENV SERVER_PORT=${PORT}

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]




