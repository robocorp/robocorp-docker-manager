#!/bin/bash

DOCKER_COMPOSE_FILE="docker/docker-compose.yaml"
TOKEN_FILE="token.txt"
TOKEN_VAR=$(<"$TOKEN_FILE")

start() {
    replicas=$1
    echo "Executing command: RC_WORKER_LINK_TOKEN=$TOKEN_VAR docker compose -f \"$DOCKER_COMPOSE_FILE\" up -d --scale worker=\"$replicas\""
    RC_WORKER_LINK_TOKEN=$TOKEN_VAR docker compose -f "$DOCKER_COMPOSE_FILE" up -d --scale worker="$replicas"
    echo "Start command done."
}

stop() {
    echo "Executing command: docker compose -f \"$DOCKER_COMPOSE_FILE\" down"
    docker compose -f "$DOCKER_COMPOSE_FILE" down
    echo "Stop command done."
}

status() {
    echo "Executing command: docker compose -f \"$DOCKER_COMPOSE_FILE\" ps"
    docker compose -f "$DOCKER_COMPOSE_FILE" ps
}

build() {
    echo "Executing command: docker compose -f \"$DOCKER_COMPOSE_FILE\" build --no-cache"
    docker compose -f "$DOCKER_COMPOSE_FILE" build --no-cache
    echo "Build command done."
}

logs() {
    echo "Executing command: docker compose -f \"$DOCKER_COMPOSE_FILE\" logs"
    docker compose -f "$DOCKER_COMPOSE_FILE" logs
}

if [ $# -lt 1 ]; then
    echo "Please specify a command: start, stop, status, build or logs."
    exit 1
fi

case $1 in
    start)
        if [ $# -lt 2 ]; then
            start 1
        else
            start "$2"
        fi
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    build)
        build
        ;;
    logs)
        logs
        ;;
    *)
        echo "Invalid command. Please specify: start, stop, or status"
        exit 1
        ;;
esac
