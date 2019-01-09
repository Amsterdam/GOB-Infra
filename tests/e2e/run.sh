#!/bin/bash

set -u # crash on missing env
set -e # stop on any error

# Start from directory where this script is located
SCRIPTDIR="$( cd "$( dirname "$0" )" >/dev/null && pwd )"

docker-compose -f ../../docker-compose.yml up rabbitmq database management_database &

# Wait for infra to be started and initialised
sleep 60

docker-compose up gobworkflow gobimport gobupload gobapi &

bash e2e.sh
