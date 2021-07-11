#!/usr/bin/env bash
# manual deployment, please dont hurt me
set -x

PROJ=oracle
USER=ubuntu
PRIVATE_KEY="./tf/instance_key"
PUBLIC_IP=$(cd tf && terraform output -raw public-ip)

DOCKER_BUILDKIT=1 docker-compose -p $PROJ build
docker save -o image.tar ${PROJ}_frontend ${PROJ}_paste ${PROJ}_redis

rsync \
    -avz \
    -e "ssh -i $PRIVATE_KEY" \
    --progress \
    ./image.tar \
    ./docker-compose.yml \
    --exclude 'node_modules/' \
    "$USER@$PUBLIC_IP:/home/$USER/app"

ssh -i "$PRIVATE_KEY" "$USER@$PUBLIC_IP" "cd app && sudo docker load -i image.tar"
ssh -i "$PRIVATE_KEY" "$USER@$PUBLIC_IP" "cd app && sudo docker-compose -p $PROJ up -d --no-build"
