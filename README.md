+ [one-java-agent-trace](https://github.com/MintKame/one-java-agent/tree/trace)的示例

# 使用步骤



## 1. 创建镜像 

```bash
docker build -t yz1458/one-java-agent-demo .
```

也可以直接从[docker hub](https://registry.hub.docker.com/repository/docker/yz1458/one-java-agent-demo)获取镜像

```
docker pull yz1458/one-java-agent-demo
```

## 2. 启动jaeger

```bash
docker run -d --name jaeger -p 16686:16686 -p 14250:14250 jaegertracing/all-in-one:1.16
```

## 3. 启动容器

```bash
docker run -it --link jaeger -e JAEGER_AGENT_HOST="jaeger" --name one-java-agent-demo yz1458/one-java-agent-demo
```

## 4. 运行demo


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

2. 启动broker

```bash
nohup sh /usr/tracedemo/rocketmq/bin/mqbroker -n localhost:9876 autoCreateTopicEnable=true &
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

4. 停止Consumer

### dubbo

1. 运行Producer

```bash
java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
	-cp /usr/tracedemo/demo/trace-dubbo-demo/target/trace-dubbo-demo.jar \
	org.apache.dubbo.samples.rest.RestProvider &
```

2. 再打开一个终端

```
docker exec -it one-java-agent-demo sh
```

3. 运行Consumer

```bash
java -javaagent:/usr/tracedemo/oneagent/core/oneagent@0.0.2-SNAPSHOT/one-java-agent.jar \
	-cp /usr/tracedemo/demo/trace-dubbo-demo/target/trace-dubbo-demo.jar \
	org.apache.dubbo.samples.rest.RestConsumer
```

4. 停止Producer和Consumer

## 5. 查看数据

http://localhost:16686

