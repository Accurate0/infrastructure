#!/usr/bin/env bash
# manual deployment, please dont hurt me

_cleanup() {
    rm -f "$RAW_IMAGE" "$RAW_IMAGE.zst"
}

trap _cleanup EXIT SIGINT SIGTERM
set -eo pipefail

KEY="./terraform/instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

export DOCKER_BUILDKIT=1
RAW_IMAGE=image.tar
REMOTE_USER=ubuntu
PRIVATE_KEY="$KEY"
PUBLIC_IP_PASTE="oracle1.anurag.sh"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

set -x

transfer_paste() {
    rsync \
        --delete \
        -avz \
        -e "$SSH_COMMAND" \
        --progress \
        ./$RAW_IMAGE.zst \
        "../servers/oracle1/docker-compose.yml" \
        "$REMOTE_USER@$PUBLIC_IP_PASTE:/home/$REMOTE_USER/app"
}

transfer_paste
