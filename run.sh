#!/bin/bash
set -eux
mvn -B -V clean verify -fae \
    -s settings.xml \
    -Dquarkus.platform.group-id=$QUARKUS_PLATFORM_GROUP_ID \
    -Dquarkus.platform.artifact-id=$QUARKUS_PLATFORM_ARTIFACT_ID \
    -Dquarkus.platform.version=$QUARKUS_VERSION \
    -Dquarkus-plugin.version=$QUARKUS_VERSION \
    -Proot-modules,http-modules,sql-db-modules,monitoring-modules \
    -Dopenshift \
    -pl $PROJECTS
