ARG BASE_IMG=arm32v7/openjdk:11-jre-slim
FROM $BASE_IMG

ENV ACTIVEMQ_VERSION=5.15.9

COPY qemu-arm-static /usr/bin

RUN set -x && \
    apk --update add --virtual build-dependencies curl && \
    curl -s https://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/apache-activemq-$ACTIVEMQ_VERSION-bin.tar.gz | tar -xzf - -C /opt && \
    mv /opt/apache-activemq-$ACTIVEMQ_VERSION /opt/activemq && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

WORKDIR /opt/activemq

COPY activemq.xml /opt/activemq/conf

ENTRYPOINT ["/opt/activemq/bin/activemq",  "console"]