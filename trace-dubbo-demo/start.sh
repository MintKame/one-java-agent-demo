#! /bin/sh

agent=/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar 
cpath=/usr/tracedemo/demo/target/trace-dubbo-demo.jar 
provider=org.apache.dubbo.samples.rest.RestProvider
consumer=org.apache.dubbo.samples.rest.RestConsumer

nohup java -javaagent:$agent -cp $cpath $provider 1>log 2>&1 &

sleep 15s

java -javaagent:$agent -cp $cpath $consumer