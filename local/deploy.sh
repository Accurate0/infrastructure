#!/usr/bin/env bash
set -x

if [ -z "$1" ]; then
    echo "$0 [ip address]"
    exit 1
fi

REMOTE_USER=arch
SERVER="$1"
rsync \
    -avzr \
    --progress \
    "./nginx" \
    "./jenkins" \
    "./keepalive" \
    "./docker-compose.yml" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER/docker"

sshpass ssh -tt "$REMOTE_USER@$SERVER" "cd ~/docker/keepalive && sudo ./init_keepalive.sh"

ssh "$REMOTE_USER@$SERVER" "bash -s" << EOF
set -x
cd docker
docker build -f jenkins/Dockerfile.archbuild -t localhost:5000/archbuild:latest .
docker push localhost:5000/archbuild
docker-compose up -d --build --remove-orphans
docker ps
jenkins-jobs --conf ~/docker/jenkins/config.ini update --workers 0 --delete-old ~/docker/jenkins
EOF

source jenkins/kernel_config.sh
