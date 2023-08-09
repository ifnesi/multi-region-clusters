#!/bin/bash

echo

for TOPICNAME in t1 t1-obs
do
  echo -e "==> Describing topic: ${TOPICNAME}"
  docker-compose exec broker-east-1 kafka-topics --describe \
    --bootstrap-server broker-east-1:19093 \
    --topic ${TOPICNAME}
  echo
done
