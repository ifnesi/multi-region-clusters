#!/bin/bash

docker-compose stop zookeeper-central
sleep 3
./scripts/zookeeper-status.sh
