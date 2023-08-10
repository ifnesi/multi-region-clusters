#!/bin/bash

docker-compose start zookeeper-west zookeeper-central zookeeper-east
sleep 3
./scripts/zookeeper-status.sh
