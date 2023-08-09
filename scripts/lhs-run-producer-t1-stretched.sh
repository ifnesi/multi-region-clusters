#!/bin/bash

TOPICNAME="t1-stretched"

trap "kill 0; rm -f ${TOPICNAME}.dat" SIGINT
trap "kill 0; rm -f ${TOPICNAME}.dat" EXIT

rm -f ${TOPICNAME}.dat
(
	while true
	do
		echo "${TOPICNAME}: Are you still there ? Yes I'm still here!"
		sleep 3
	done
) > ${TOPICNAME}.dat &

# Just make sure the file is there - avoid spurious error messages
sleep 1

echo ">>> Producing to ${TOPICNAME}"
tail -f ${TOPICNAME}.dat | docker-compose exec -T broker-east-3 kafka-console-producer --bootstrap-server broker-west-1:19091,broker-west-2:19092,broker-west-3:19095,broker-east-1:19093,broker-east-2:19094,broker-east-3:19096 --topic ${TOPICNAME} --request-required-acks all --message-send-max-retries 10


