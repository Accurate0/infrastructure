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
    reflector -c Australia -f 5 --latest 5 --save /etc/pacman.d/mirrorlist --verbose --protocol http

    pacman -Syu --noconfirm --needed docker docker-compose rsync wget jre11-openjdk-headless git base-devel reflector

    systemctl enable --now docker

    # pod2man fix for lemonbar ?
    ln -sf /usr/bin/core_perl/pod2man "/usr/bin/pod2man"
EOF
}

for server in $SERVERS; do
    provision "$server" &
done

wait
