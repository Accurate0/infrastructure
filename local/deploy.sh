#!/usr/bin/env bash
set -x

if [ -z "$1" ]; then
    echo "$0 [ip address]"
    exit 1
fi

REMOTE_USER=arch
SERVER="$1"

if [ "$2" = "all" ]; then
    (cd jenkins && ./deploy.sh "$SERVER")
    (cd cloudflared && ./deploy.sh "$SERVER")
fi

rsync \
    -avzr \
    --progress \
    ".env" \
    "./nginx" \
    "./docker-compose.yml" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER/docker"

ssh "$REMOTE_USER@$SERVER" "bash -s" << EOF
set -x
cd docker
docker-compose up -d --build --remove-orphans
docker ps
EOF
