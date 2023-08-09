#!/bin/bash

echo

for port in 2181 2182 2183
do
    echo "==> Zookeeper " $port
    zk_status=$(echo stat | nc localhost $port)
    zk_count=$(echo "$zk_status" | wc -l)
    if [[ zk_count -eq 1 ]]; then
        if [[ $zk_status ]]; then
            echo "$zk_status"
        else
            echo "OFFLINE!"
        fi
    else
        echo "$zk_status" | grep 'Latency\|Mode'
    fi
    echo
done
