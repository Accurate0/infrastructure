#!/usr/bin/env bash
KEY="./instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

PRIVATE_KEY="$KEY"

SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

SERVERS="rpi.anurag.sh"

set -x

provision() {
$SSH_COMMAND "alarm@$1" "bash -s" << EOF
    set -x

    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm archlinux-keyring
    sudo pacman -S --noconfirm --needed docker docker-compose rsync wget

    sudo systemctl enable --now docker
EOF
}

for server in $SERVERS; do
    provision "$server" &
done

wait
