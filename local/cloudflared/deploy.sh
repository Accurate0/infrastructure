#!/usr/bin/env bash
REMOTE_USER=arch
CLOUDFLARED_LOCAL="$HOME/.cloudflared"

if [ -z "$1" ]; then
    echo "$0 [ip address]"
    exit 1
fi

# 10.130.146.225
SERVER="$1"
rsync \
    -avz \
    --progress \
    "$CLOUDFLARED_LOCAL" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER"

rsync \
    -avz \
    --progress \
    --rsync-path "sudo rsync" \
    "./config.yml" \
    "$REMOTE_USER@$SERVER:/etc/cloudflared"

sshpass ssh -t "$REMOTE_USER@$SERVER" "systemctl restart cloudflared"
