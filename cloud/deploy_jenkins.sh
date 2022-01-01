#!/usr/bin/env bash
# manual deployment, please dont hurt me
set -eo pipefail

KEY="./terraform/instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

REMOTE_USER=root
PRIVATE_KEY="$KEY"
PUBLIC_IP_JENKINS="linode2.anurag.sh"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

set -x

REMOTE_USER=root
rsync \
    -e "$SSH_COMMAND" \
    -avzr \
    --progress \
    "../services/jenkins" \
    "$REMOTE_USER@$PUBLIC_IP_JENKINS:/srv"

$SSH_COMMAND "$REMOTE_USER@$PUBLIC_IP_JENKINS" "bash -s" << EOF
set -x
cd /srv/jenkins
docker-compose up --build -d
docker ps
EOF
