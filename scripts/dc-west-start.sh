#!/bin/bash

docker-compose start zookeeper-west broker-west-1 broker-west-2 broker-west-3
sleep 3
echo "Done!"
echo
