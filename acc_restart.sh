#!/usr/bin/env bash

source .env

for SERVER in $SERVERS
do
    echo "Stopping GOB containers at $SERVER"
    for (( idx=${#CONTAINERS[@]}-1 ; idx>=0 ; idx-- ))
    do
        DOCKER=${CONTAINERS[idx]}
        echo "Stopping $DOCKER"
        ssh $SERVER sudo docker stop $DOCKER
    done
done

echo "About to start GOB containers..."
sleep 5

for SERVER in $SERVERS
do
    echo "Starting GOB containers at $SERVER"
    for DOCKER in ${CONTAINERS[@]}
    do
        echo "Starting $DOCKER"
        ssh $SERVER sudo docker start $DOCKER
        sleep 5
    done
done
