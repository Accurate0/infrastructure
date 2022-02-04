#!/usr/bin/env bash
set -eo pipefail

KEY="./terraform/instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

REMOTE_USER=alarm
IP="rpi.anurag.sh"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $KEY"

set -x

rsync \
    -e "$SSH_COMMAND" \
    -avzr \
    --progress \
    "../servers/rpi" \
    "$REMOTE_USER@$IP:/home/$REMOTE_USER/"

$SSH_COMMAND "$REMOTE_USER@$IP" "bash -s" << EOF
set -x
cd \$HOME/rpi
docker-compose up --build -d --remove-orphans
docker ps
EOF
