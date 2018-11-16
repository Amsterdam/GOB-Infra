#!/usr/bin/env bash

if [ "$1" = "stop" ]; then
    ACTIONS="stop"
elif [ "$1" = "reset" ]; then
    ACTIONS="stop rm"
elif [ "$1" = "start" ] || [ "$1" = "restart" ]; then
    ACTIONS="stop start"
else
    echo "Usage: $0 [start|stop|restart|reset]"
    exit 1
fi

DOCKERS="rabbitmq management_database storage"

for ACTION in ${ACTIONS}; do
    echo "${ACTION} GOB dockers"
    if [ "${ACTION}" = "start" ]; then
        # Always last command, start dockers in background
        docker-compose up > /dev/null 2>&1 &
    else
        docker ${ACTION} ${DOCKERS} > /dev/null 2>&1
    fi
done
