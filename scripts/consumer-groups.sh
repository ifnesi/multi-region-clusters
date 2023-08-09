#!/bin/bash

for CG in $(docker-compose exec broker-east-1 kafka-consumer-groups --bootstrap-server broker-east-1:19093 --list)
do
	CG=$(echo ${CG} | tr -d "\r")
	echo
	echo "${CG}"
	docker-compose exec broker-east-1 kafka-consumer-groups \
		--bootstrap-server broker-east-1:19093 \
		--group "${CG}" --describe
done
