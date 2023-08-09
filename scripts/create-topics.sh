#!/bin/bash

TOPICNAME="t1"
echo -e "\n==> Creating topic ${TOPICNAME}"
docker-compose exec broker-west-1 kafka-topics --create \
	--if-not-exists \
	--bootstrap-server broker-west-1:19091,broker-west-2:19092,broker-west-3:19095,broker-east-1:19093,broker-east-2:19094,broker-east-3:19096 \
	--topic ${TOPICNAME} \
	--partitions 1 \
	--replica-placement /etc/kafka/demo/placement-t1.json \
	--config min.insync.replicas=3

TOPICNAME="t1-obs"
echo -e "\n==> Creating topic ${TOPICNAME}"
docker-compose exec broker-west-1 kafka-topics --create \
	--if-not-exists \
	--bootstrap-server broker-west-1:19091,broker-west-2:19092,broker-west-3:19095,broker-east-1:19093,broker-east-2:19094,broker-east-3:19096 \
	--topic ${TOPICNAME} \
	--partitions 1 \
	--replica-placement /etc/kafka/demo/placement-t1-obs.json \
	--config min.insync.replicas=3

echo
