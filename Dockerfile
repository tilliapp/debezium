FROM debezium/connect

# https://github.com/LoObp4ck/kafka-connect-healthchecks
COPY libs/kafka-connect-healthcheck-extension-1.0.0.jar /kafka/connect

USER root
COPY data/* /tmp/
COPY run.sh /usr/local/run.sh
RUN chmod +x /usr/local/run.sh

ENTRYPOINT ["/usr/local/run.sh"]
