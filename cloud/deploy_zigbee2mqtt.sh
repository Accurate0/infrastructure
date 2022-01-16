#!/usr/bin/env bash
set -eo pipefail

REMOTE_USER=alarm
IP="$1"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no"

set -x

rsync \
    -e "$SSH_COMMAND" \
    -avzr \
    --progress \
    "../services/zigbee2mqtt" \
    "$REMOTE_USER@$IP:/home/$REMOTE_USER/"

$SSH_COMMAND "$REMOTE_USER@$IP" "bash -s" << EOF
set -x
cd \$HOME/zigbee2mqtt
docker-compose up --build -d
docker ps
EOF
