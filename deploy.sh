#!/bin/bash

DOCKER_APP_NAME=nextjs

EXIST_BLUE=$(/usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml ps | grep Up)

if [ -z "$EXIST_BLUE" ]; then
    echo "blue up"
    /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml up -d --build

    sleep 10

    /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-green -f docker-compose.green.yml down
else
    echo "green up"
    /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-green -f docker-compose.green.yml up -d --build

    sleep 10

    /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml down
fi