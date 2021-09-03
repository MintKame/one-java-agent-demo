#!/bin/sh

nohup sh /usr/tracedemo/rocketmq-all-4.9.0/bin/mqnamesrv &
nohup sh /usr/tracedemo/rocketmq-all-4.9.0/bin/mqbroker -n localhost:9876 autoCreateTopicEnable=true