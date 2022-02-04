#!/usr/bin/env bash
# manual deployment, please dont hurt me
set -eo pipefail

KEY="./terraform/instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

export DOCKER_BUILDKIT=1
REMOTE_USER=ubuntu
PRIVATE_KEY="$KEY"
PUBLIC_IP_FILES="oracle2.anurag.sh"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

set -x

transfer_files() {
    rsync \
        --delete \
        -avz \
        -e "$SSH_COMMAND" \
        --progress \
        "../servers/files" \
        "$REMOTE_USER@$PUBLIC_IP_FILES:/home/$REMOTE_USER/servers"

    $SSH_COMMAND "$REMOTE_USER@$PUBLIC_IP_FILES" "bash -s" << EOF
    set -x
    cd servers/files

    pushd certbot
    sudo cp certbot-renewal.* /etc/systemd/system/
    sudo sh -c 'systemctl daemon-reload && systemctl enable --now certbot-renewal.timer'
    popd

    docker network prune -f
    docker-compose up --build -d
    docker ps
EOF
}

transfer_files
