FROM ubuntu:jammy

WORKDIR /home/build

RUN apt update
RUN apt -y install git

ARG SDE_CORE_GITHUB_PAT
ARG SDE_CORE_COMMIT

RUN git clone https://${SDE_CORE_GITHUB_PAT}@github.com/MauroDataMapper/sde-core.git && cd sde-core && git checkout ${SDE_CORE_COMMIT}

COPY flyway.conf /home/build/sde-core/management-model
COPY migrate-and-run.sh /home/build/sde-core

RUN apt -y install openjdk-17-jdk-headless

WORKDIR /home/build/sde-core

RUN ./gradlew :admin-api:build -x test
RUN ./gradlew :admin-api:shadowJar

RUN ./gradlew :researcher-api:build -x test
RUN ./gradlew :researcher-api:shadowJar

WORKDIR /home

COPY sde-admin-api/layers/classes /home/sde-admin-api/classes
COPY sde-researcher-api/layers/classes /home/sde-researcher-api/classes

RUN cp build/sde-core/management-model/src/main/resources/META-INF/orm.xml /home/sde-admin-api/classes/META-INF/
RUN cp build/sde-core/management-model/src/main/resources/META-INF/orm.xml /home/sde-researcher-api/classes/META-INF/

RUN cp build/sde-core/admin-api/build/libs/admin-api-0.1-all.jar sde-admin-api/
RUN cp build/sde-core/researcher-api/build/libs/researcher-api-0.1-all.jar sde-researcher-api/

WORKDIR /home/build/sde-core
EXPOSE 8081 8082
ENTRYPOINT ["/bin/sh", "migrate-and-run.sh"]

