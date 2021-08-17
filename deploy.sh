#!/bin/bash

docker system prune -a -f

DOCKER_APP_NAME=nextjsproject

EXIST_BLUE=$(/usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml ps | grep Up)



if [ -z "$EXIST_BLUE" ]; then

    echo "blue up"
    /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml up -d --build

    sleep 10

    RES_CODE_BLUE=$(curl -o /dev/null -w "%{http_code}" "http://localhost:3001")

    if [ $RES_CODE_BLUE -eq 200 ]; then
        echo "green down"
        /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-green -f docker-compose.green.yml down
    else
        echo "blue down"
        /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml down
    fi
else

    echo "green up"
    /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-green -f docker-compose.green.yml up -d --build

    sleep 10

    RES_CODE_GREEN=$(curl -o /dev/null -w "%{http_code}" "http://localhost:3002")

    if [ $RES_CODE_GREEN -eq 200 ]; then
        echo "blue down"
        /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-blue -f docker-compose.blue.yml down
    else
        echo "green down"
        /usr/local/bin/docker-compose -p ${DOCKER_APP_NAME}-green -f docker-compose.green.yml down
    fi
    
fi
