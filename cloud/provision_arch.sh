#!/usr/bin/env bash
set -x

KEY="./instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

PRIVATE_KEY="$KEY"

SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

SERVERS="linode1.anurag.sh linode2.anurag.sh"

provision() {
$SSH_COMMAND "root@$1" "bash -s" << EOF
    set -x
    pacman -Syu --noconfirm
EOF
}

for server in $SERVERS; do
    provision "$server" &
done

wait
