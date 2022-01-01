#!/usr/bin/env bash
# manual deployment, please dont hurt me
set -eo pipefail

KEY="./terraform/instance_key"

[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"

ORIGIN_CERT="../nginx/certs/anurag.sh.key"
[ -f "$ORIGIN_CERT" ] || echo "$ORIGIN_SSL_CERT" >> "$ORIGIN_CERT"

chmod 400 "$KEY"

export DOCKER_BUILDKIT=1
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
docker-compose up -d
EOF
# jenkins-jobs --conf ./config.ini update --workers 0 --delete-old ./
