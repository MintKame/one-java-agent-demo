#! /bin/sh

agent=/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar 
cpath=/usr/tracedemo/demo/target/trace-dubbo-demo.jar 
provider=org.apache.dubbo.samples.rest.RestProvider 

java -javaagent:$agent -cp $cpath $provider