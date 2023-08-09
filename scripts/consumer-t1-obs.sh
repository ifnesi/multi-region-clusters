#!/bin/bash

trap "kill 0" SIGINT
trap "kill 0" EXIT

TOPICNAME="t1-obs"

echo ">>> Consuming ${TOPICNAME}"
docker-compose exec broker-east-1 kafka-console-consumer --bootstrap-server broker-east-1:19093 --topic ${TOPICNAME} --property print.offset=true


