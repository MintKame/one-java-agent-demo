FROM maven:3.5.2-jdk-8 AS build

WORKDIR /usr/tracedemo

COPY oneagent ./oneagent
COPY src ./demo/src
COPY pom.xml ./demo/pom.xml

RUN mvn -f /usr/tracedemo/demo/pom.xml clean package

FROM openjdk:8-jre-alpine

COPY --from=build /usr/tracedemo /usr/tracedemo

ENTRYPOINT java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
        -cp /usr/tracedemo/demo/target/trace-httpClient-demo.jar \
        com.trace.demo.httpclient.HttpClientDemo