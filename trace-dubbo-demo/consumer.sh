#! /bin/sh

agent=/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar 
cpath=/usr/tracedemo/demo/target/trace-dubbo-demo.jar 
consumer=org.apache.dubbo.samples.rest.RestConsumer

sleep 15s

java -javaagent:$agent -cp $cpath $consumer