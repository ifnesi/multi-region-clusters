#!/bin/bash


for CONTAINERNAME in broker-west-1 broker-west-2 broker-west-3 broker-east-1 broker-east-2 broker-east-3
do
	IPADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CONTAINERNAME})
	echo ${IPADDR} ${CONTAINERNAME}
done
