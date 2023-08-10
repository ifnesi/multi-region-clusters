#!/bin/bash

docker-compose stop zookeeper-west
sleep 3
./scripts/zookeeper-status.sh
