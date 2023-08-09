#!/bin/bash

trap "kill 0" SIGINT
trap "kill 0" EXIT

TOPICNAME="t1-stretched"

echo ">>> Consuming ${TOPICNAME}"
docker-compose exec broker-east-3 kafka-console-consumer --bootstrap-server broker-west-1:19091,broker-west-2:19092,broker-west-3:19095,broker-east-1:19093,broker-east-2:19094,broker-east-3:19096 --topic ${TOPICNAME} --property print.offset=true


