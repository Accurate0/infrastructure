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
    "../keepalive" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER"

sshpass ssh -t "$REMOTE_USER@$SERVER" "cd ~/keepalive && sudo ./init_keepalive.sh"
