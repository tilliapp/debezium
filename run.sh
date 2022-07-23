#!/bin/bash

export GROUP_ID=debezium
export CONFIG_STORAGE_TOPIC=debezium_config
export OFFSET_STORAGE_TOPIC=debezium_offset
export STATUS_STORAGE_TOPIC=debezium_status
export BOOTSTRAP_SERVERS=kafka-tilli-1-tilli-1570.aivencloud.com:13372

export CONNECT_REST_EXTENSION_CLASSES=com.loobpack.data.kafka.connect.healthcheck.extension.HealthCheckConnectRestExtension

# https://stackoverflow.com/questions/45250575/securing-access-to-rest-api-of-kafka-connect
echo "rest.extension.classes=org.apache.kafka.connect.rest.basic.auth.extension.BasicAuthSecurityRestExtension" >>/kafka/config/connect-distributed.properties
echo "$CONNECT_REST_USERNAME: $CONNECT_REST_PASSWORD" >>/kafka/connect/connect.password
echo 'KafkaConnect { org.apache.kafka.connect.rest.basic.auth.extension.PropertyFileLoginModule required file="/kafka/config/connect.password"; };' >>/kafka/config/connect-jaas.properties
export KAFKA_OPTS="-Djava.security.auth.login.config=/kafka/config/connect-jaas.properties"

export KAFKA_HEAP_OPTS="-Xms1536M -Xmx1536M"

{
  echo "security.protocol=SSL"
  echo "ssl.keystore.type=PKCS12"
  echo "ssl.keystore.location=/tmp/client.keystore.p12"
  echo "ssl.keystore.password=$KEYSTORE_PASSWORD"
  echo "ssl.truststore.location=/tmp/client.truststore.jks"
  echo "ssl.truststore.password=$TRUSTSTORE_PASSWORD"
  echo "ssl.key.password=$TRUSTSTORE_PASSWORD"
  echo "producer.security.protocol=SSL"
  echo "producer.ssl.keystore.type=PKCS12"
  echo "producer.ssl.keystore.location=/tmp/client.keystore.p12"
  echo "producer.ssl.keystore.password=$KEYSTORE_PASSWORD"
  echo "producer.ssl.truststore.location=/tmp/client.truststore.jks"
  echo "producer.ssl.truststore.password=$TRUSTSTORE_PASSWORD"
  echo "producer.ssl.key.password=$TRUSTSTORE_PASSWORD"
  echo "consumer.security.protocol=SSL"
  echo "consumer.ssl.keystore.type=PKCS12"
  echo "consumer.ssl.keystore.location=/tmp/client.keystore.p12"
  echo "consumer.ssl.keystore.password=$KEYSTORE_PASSWORD"
  echo "consumer.ssl.truststore.location=/tmp/client.truststore.jks"
  echo "consumer.ssl.truststore.password=$TRUSTSTORE_PASSWORD"
  echo "consumer.ssl.key.password=$TRUSTSTORE_PASSWORD"
} >>/kafka/config/connect-distributed.properties

exec /docker-entrypoint.sh "start" "$@"