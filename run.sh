#!/bin/bash

CONSOLE_URL=$(cat $SHARED_DIR/console.url)
OCP_API_URL="https://api.${CONSOLE_URL#"https://console-openshift-console.apps."}:6443"
OCP_CRED_USR="kubeadmin"
OCP_CRED_PSW="$(cat ${SHARED_DIR}/kubeadmin-password)"

oc login ${OCP_API_URL} --username=${OCP_CRED_USR} --password=${OCP_CRED_PSW} --insecure-skip-tls-verify=true

set -eux
mvn -B -V clean verify -fae \
    -s settings.xml \
    -Dmaven.repo.local=$PWD/local-repo \
    -Dquarkus.platform.group-id=$QUARKUS_PLATFORM_GROUP_ID \
    -Dquarkus.platform.artifact-id=$QUARKUS_PLATFORM_ARTIFACT_ID \
    -Dquarkus.platform.version=$QUARKUS_VERSION \
    -Dquarkus-plugin.version=$QUARKUS_VERSION \
    -Proot-modules,http-modules,sql-db-modules,monitoring-modules \
    -Dopenshift \
    -pl $PROJECTS