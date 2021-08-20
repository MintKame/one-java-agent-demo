FROM maven:3.5.2-jdk-8 AS build

WORKDIR /usr/tracedemo

COPY oneagent ./oneagent
COPY trace-rocketMQ-demo ./demo/trace-rocketMQ-demo
COPY trace-dubbo-demo ./demo/trace-dubbo-demo
COPY trace-httpClient-demo ./demo/trace-httpClient-demo
COPY pom.xml ./demo/pom.xml
COPY rocketmq-all-4.9.0 ./rocketmq

RUN mvn -f /usr/tracedemo/demo/pom.xml clean package

FROM openjdk:8-jre-alpine

COPY --from=build /usr/tracedemo/oneagent /usr/tracedemo/oneagent
COPY --from=build /usr/tracedemo/demo /usr/tracedemo/demo
COPY --from=build /usr/tracedemo/rocketmq /usr/tracedemo/rocketmq

CMD sh

