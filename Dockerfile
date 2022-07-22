FROM debezium/connect

ENV GROUP_ID=debezium
ENV CONFIG_STORAGE_TOPIC=debezium_config
ENV OFFSET_STORAGE_TOPIC=debezium_offset
ENV STATUS_STORAGE_TOPIC=debezium_status
ENV BOOTSTRAP_SERVERS=kafka-tilli-1-tilli-1570.aivencloud.com:13372