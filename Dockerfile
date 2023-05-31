FROM registry.access.redhat.com/ubi8/ubi

ENV LANGUAGE='en_US:en'
WORKDIR /tmp

# ubi8 repos contain maven 3.5 and jdk 1.8; we need something newer
RUN dnf install -y wget git zip unzip --setopt=install_weak_deps=False
RUN wget -O sdkman.sh https://get.sdkman.io && /bin/bash sdkman.sh
RUN source "/root/.sdkman/bin/sdkman-init.sh" && sdk install java 22.3.2.r17-mandrel && sdk install maven 3.8.7

# these versions should be updated for every release
ENV QUARKUS_BRANCH=2.13
ENV QUARKUS_VERSION=2.13.7.Final-redhat-00003
ENV QUARKUS_PLATFORM_GROUP_ID=com.redhat.quarkus.platform
ENV QUARKUS_PLATFORM_ARTIFACT_ID=quarkus-bom

## List of projects to include in smoke test
ENV PROJECTS=config,lifecycle-application,http/http-minimum,http/http-minimum-reactive,sql-db/sql-app,monitoring/microprofile-opentracing

RUN git clone --depth=1 -b ${QUARKUS_BRANCH} https://github.com/quarkus-qe/quarkus-test-suite.git tests
WORKDIR /tmp/tests

# maven settings for repository
ADD settings.xml /tmp/tests/

ADD --chmod=755 run.sh /tmp/tests/

# test results are in $PROJECT/target/failsafe-reports/*.xml for every PROJECT in $PROJECTS.
CMD source "/root/.sdkman/bin/sdkman-init.sh" && ./run.sh
