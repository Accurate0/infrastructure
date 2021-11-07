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
    "../jenkins" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER"

ssh "$REMOTE_USER@$SERVER" "bash -s" << EOF
set -x
cd jenkins
docker build -f Dockerfile.archbuild -t localhost:5000/archbuild:latest .
docker push localhost:5000/archbuild
jenkins-jobs --conf ./config.ini update --workers 0 --delete-old ./
EOF

source kernel_config.sh
