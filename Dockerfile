FROM apache/nifi:1.9.2

LABEL description="NIFI Container image to be used by developers"
LABEL maintainer="João Miguel Marques Silva <joao@miguel.ms>"
LABEL site="https://github.com/MiguelTVMS/docker-developer-nifi"
LABEL repo="https://github.com/MiguelTVMS/docker-developer-nifi.git"

ENV NIFI_FLOW_CONFIGURATION_FOLDER="${NIFI_HOME}/flow_conf"
ENV NIFI_FLOW_CONFIGURATION_FILE="${NIFI_FLOW_CONFIGURATION_FOLDER}/flow.xml.gz"
ENV NIFI_FLOW_CONFIGURATION_ARCHIVE_DIR="${NIFI_FLOW_CONFIGURATION_FOLDER}/archive/"
ENV NIFI_FLOWSERVICE_WRITEDELAY_INTERVAL="1 sec"

USER root

ADD sh/ ${NIFI_BASE_DIR}/scripts/

RUN chown -R nifi:nifi ${NIFI_BASE_DIR} \
    && chmod +x ${NIFI_BASE_DIR}/scripts/*.sh

USER nifi

RUN mkdir -p ${NIFI_FLOW_CONFIGURATION_FOLDER}

VOLUME ${NIFI_FLOW_CONFIGURATION_FOLDER}