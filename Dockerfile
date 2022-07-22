FROM debezium/connect

ENV KAFKA_HEAP_OPTS="-Xms1024M -Xmx1024M"

ENV GROUP_ID=debezium
ENV CONFIG_STORAGE_TOPIC=debezium_config
ENV OFFSET_STORAGE_TOPIC=debezium_offset
ENV STATUS_STORAGE_TOPIC=debezium_status
ENV BOOTSTRAP_SERVERS=kafka-tilli-1-tilli-1570.aivencloud.com:13372

# https://github.com/LoObp4ck/kafka-connect-healthchecks
COPY libs/kafka-connect-healthcheck-extension-1.0.0.jar /kafka/connect
ENV CONNECT_REST_EXTENSION_CLASSES=com.loobpack.data.kafka.connect.healthcheck.extension.HealthCheckConnectRestExtension