#!/bin/bash

source ./.env

echo
echo "Check if docker is running..."
if (! docker stats --no-stream > /dev/null 2>&1); then
    echo "ERROR: Please start Docker Desktop, then run the '$0' script"
    echo ""
    exit 1
fi
echo

echo "Starting up docker compose (Confluent Platform version $CP_VERSION)..."
docker-compose up -d

echo
echo -n "Waiting for Kafka cluster to be ready..."
waiting_counter=0
while [ "$(curl -s -w '%{http_code}' -o /dev/null 'http://localhost:8082/v3/clusters')" -ne 200 ]; do
    echo -n "."
    sleep 2
    waiting_counter=$((waiting_counter+1))
    if [ $waiting_counter -eq 45 ]; then
        echo ""
        echo ""
        echo "ERROR: Unable to start the Kafka cluster!"
        echo ""
        sleep 1
        ./stop.sh
        echo ""
        exit 1
    fi
done

echo
echo
echo "Zookeeper status:"
./scripts/zookeeper-status.sh

echo
TOPICNAME="t1"
echo -e "\n==> Creating topic ${TOPICNAME}"
docker-compose exec broker-west-1 kafka-topics --create \
	--if-not-exists \
	--bootstrap-server broker-west-1:19091,broker-west-2:19092,broker-west-3:19095,broker-east-1:19093,broker-east-2:19094,broker-east-3:19096 \
	--topic ${TOPICNAME} \
	--partitions 1 \
	--replica-placement /etc/kafka/demo/placement-t1.json \
	--config min.insync.replicas=3

echo
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
./scripts/describe-topics.sh
