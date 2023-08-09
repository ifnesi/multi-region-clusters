#!/bin/bash

TOPICNAME="t1-obs"

trap "kill 0; rm -f ${TOPICNAME}.dat" SIGINT
trap "kill 0; rm -f ${TOPICNAME}.dat" EXIT

rm -f ${TOPICNAME}.dat
(
	while true
	do
		uuidgen
		sleep 2
	done
) > ${TOPICNAME}.dat &

# Just make sure the file is there - avoid spurious error messages
sleep 1

echo ">>> Producing to ${TOPICNAME}"
tail -f ${TOPICNAME}.dat | docker-compose exec -T broker-east-1 kafka-console-producer --bootstrap-server broker-east-1:19093 --topic ${TOPICNAME} --request-required-acks all --message-send-max-retries 10
