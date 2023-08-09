#!/bin/bash

for metric in ReplicasCount InSyncReplicasCount CaughtUpReplicasCount ObserversInIsrCount
do

  echo -e "\n\n==> JMX metric: $metric \n"

  for topic in t1-obs
  do

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-west-1"))" = "0" \
      && BW1=$(docker-compose exec broker-west-1 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://broker-west-1:8091/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BW1=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-west-2"))" = "0" \
      && BW2=$(docker-compose exec broker-west-2 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://broker-west-2:8092/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BW2=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-west-3"))" = "0" \
      && BW3=$(docker-compose exec broker-west-3 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://broker-west-3:8095/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BW3=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-east-1"))" = "0" \
      && BE1=$(docker-compose exec broker-east-1 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://broker-east-1:8093/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BE1=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-east-2"))" = "0" \
      && BE2=$(docker-compose exec broker-east-2 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://broker-east-2:8094/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BE2=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-east-3"))" = "0" \
      && BE3=$(docker-compose exec broker-east-3 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://broker-east-3:8096/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BE3=0

    REPLICAS=$((BW1 + BW2 + BW3 + BE1 + BE2 + BE3))
    echo "$topic: $REPLICAS"
  done

done

echo
