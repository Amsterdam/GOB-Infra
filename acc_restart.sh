#!/usr/bin/env bash

source .env

for (( idx=${#CONTAINERS[@]}-1 ; idx>=0 ; idx-- ))
do
    for SERVER in $SERVERS
    do
        DOCKER=${CONTAINERS[idx]}
        echo -n "Stopping ${DOCKER} @ ${SERVER}..."
        ssh $SERVER sudo docker stop $DOCKER
    done
done

echo "About to start GOB containers..."
sleep 5

for DOCKER in ${CONTAINERS[@]}
do
    for SERVER in $SERVERS
    do
        echo -n "Starting ${DOCKER} @ ${SERVER}..."
        ssh $SERVER sudo docker start $DOCKER
        sleep 5
    done
done
