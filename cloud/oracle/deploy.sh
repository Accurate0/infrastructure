#!/usr/bin/env bash
# manual deployment, please dont hurt me

_cleanup() {
    rm -f "$RAW_IMAGE" "$RAW_IMAGE.zst"
}

trap _cleanup EXIT SIGINT SIGTERM
set -eo pipefail

export DOCKER_BUILDKIT=1
RAW_IMAGE=image.tar
PROJ=oracle
REMOTE_USER=ubuntu
PRIVATE_KEY="./tf/instance_key"
PUBLIC_IP=$(cd tf && terraform output -raw public-ip)
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

set -x

docker-compose -p "$PROJ" build
docker save -o "$RAW_IMAGE" "${PROJ}_frontend" "${PROJ}_paste" "${PROJ}_redis"

zstd -T0 -20 --ultra --rsyncable "$RAW_IMAGE" -o "$RAW_IMAGE.zst"

rsync \
    -avz \
    -e "$SSH_COMMAND" \
    --progress \
    ./$RAW_IMAGE.zst \
    ./docker-compose.yml \
    "$REMOTE_USER@$PUBLIC_IP:/home/$REMOTE_USER/app"

$SSH_COMMAND "$REMOTE_USER@$PUBLIC_IP" "bash -s" << EOF
set -x
cd app
zstd -f -d -T0 "$RAW_IMAGE".zst -o "$RAW_IMAGE"
docker load -i "$RAW_IMAGE"
docker-compose -p "$PROJ" up -d --no-build
docker ps
EOF
