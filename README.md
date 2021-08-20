# 步骤

## 1. 运行jaeger

```bash
docker run --rm -d --name jaeger -p 16686:16686 -p 14250:14250 jaegertracing/all-in-one:1.16
```

## 2. 启动容器

```bash
docker build -t oneagent_demo .
```

```bash
docker run --rm -it --link jaeger -e JAEGER_AGENT_HOST="jaeger" --name oneagent_demo oneagent_demo 
```

## 3. 运行demo

### dubbo

```bash
java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
	-cp /usr/tracedemo/demo/trace-dubbo-demo/target/trace-dubbo-demo.jar \
	com.trace.demo.dubbo.DubboDemo
```


### httpClient

```bash
java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
	-cp /usr/tracedemo/demo/trace-httpClient-demo/target/trace-httpClient-demo.jar \
	com.trace.demo.httpclient.HttpClientDemo
```

### rocketMQ

1. 启动namesrv

```bash
nohup sh /usr/tracedemo/rocketmq/bin/mqnamesrv &
```

```bash
tail -f ~/logs/rocketmqlogs/namesrv.log
```

2. 启动broker

```bash
nohup sh /usr/tracedemo/rocketmq/bin/mqbroker -n localhost:9876 autoCreateTopicEnable=true &
```

```bash
tail -f ~/logs/rocketmqlogs/broker.log 
```

3. 运行Producer和Consumer

```bash
java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
	-cp /usr/tracedemo/demo/trace-rocketMQ-demo/target/trace-rocketMQ-demo.jar \
	com.trace.demo.rocketmq.Producer
```

```bash
java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
	-cp /usr/tracedemo/demo/trace-rocketMQ-demo/target/trace-rocketMQ-demo.jar \
	com.trace.demo.rocketmq.Consumer
```



## 4. 查看数据

http://localhost:16686
