#!/usr/bin/env bash
# manual deployment, please dont hurt me

_cleanup() {
    rm -f image.tar image.tar.zst
}

trap _cleanup EXIT SIGINT SIGTERM
set -x

export DOCKER_BUILDKIT=1
PROJ=oracle
REMOTE_USER=ubuntu
PRIVATE_KEY="./tf/instance_key"
PUBLIC_IP=$(cd tf && terraform output -raw public-ip)
SSH_COMMAND="ssh -i $PRIVATE_KEY"

docker-compose -p $PROJ build
docker save -o image.tar ${PROJ}_frontend ${PROJ}_paste ${PROJ}_redis

tar --zstd -cf image.tar.zst image.tar

rsync \
    -avz \
    -e "$SSH_COMMAND" \
    --progress \
    ./image.tar.zst \
    ./docker-compose.yml \
    "$REMOTE_USER@$PUBLIC_IP:/home/$REMOTE_USER/app"

$SSH_COMMAND "$REMOTE_USER@$PUBLIC_IP" "bash -s" << EOF
cd app \
&& tar -xf image.tar.zst \
&& docker load -i image.tar \
&& docker-compose -p $PROJ up -d --no-build \
&& docker ps
EOF
