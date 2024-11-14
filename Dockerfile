FROM gradle:7.6.4-jdk11 AS builder
COPY --chown=gradle:gradle . /app
WORKDIR /app
RUN gradle build -x test

FROM openjdk:18-ea-11-alpine3.15
EXPOSE 8080
VOLUME /tmp
ARG LIBS=app/build/libs
COPY --from=builder ${LIBS}/ /app/lib
ENTRYPOINT ["java","-jar","./app/lib/bah-mcc-data-0.0.1-SNAPSHOT.jar"]
