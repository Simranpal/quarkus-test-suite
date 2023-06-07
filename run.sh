#!/bin/bash

oc login ${OCP_API_URL} --username=${OCP_CRED_USR} --password=${OCP_CRED_PSW} --insecure-skip-tls-verify=true --kubeconfig=/tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig

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