#!/usr/bin/env bash
REMOTE_USER=arch

if [ -z "$1" ]; then
    echo "$0 [ip address]"
    exit 1
fi

# 10.130.146.225
SERVER="$1"
rsync \
    -avz \
    --progress \
    "./nginx" \
    "./docker-compose.yml" \
    "./Dockerfile.archbuild" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER/docker"

ssh "$REMOTE_USER@$SERVER" "bash -s" << EOF
set -x
cd docker
docker build -f Dockerfile.archbuild -t localhost:5000/archbuild:latest .
docker push localhost:5000/archbuild
docker-compose up -d --build
docker ps
EOF
