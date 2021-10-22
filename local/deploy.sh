#!/usr/bin/env bash
set -x

REMOTE_USER=arch

if [ -z "$1" ]; then
    echo "$0 [ip address]"
    exit 1
fi

# 10.130.146.225
SERVER="$1"
rsync \
    -avzr \
    --progress \
    "./nginx" \
    "./docker-compose.yml" \
    "./Dockerfile.archbuild" \
    "./jenkins" \
    "./postgres" \
    "keepalive.sh" \
    "keepalive.service" \
    "$REMOTE_USER@$SERVER:/home/$REMOTE_USER/docker"

# sudo cp keepalive.sh /usr/local/bin/
# sudo cp keepalive.service /etc/systemd/system/
# systemctl daemon-reload
# systemctl enable --now keepalive.service

ssh "$REMOTE_USER@$SERVER" "bash -s" << EOF
set -x
cd docker
docker build -f Dockerfile.archbuild -t localhost:5000/archbuild:latest .
docker push localhost:5000/archbuild
docker-compose up -d --build --remove-orphans
docker ps
jenkins-jobs --conf ~/docker/jenkins/config.ini update --workers 0 --delete-old ~/docker/jenkins
EOF

# copy my kernel module info for the jenkins job
modprobed-db list | ssh "$REMOTE_USER@$SERVER" "cat - > /data/file/modules"

ssh "$REMOTE_USER@$SERVER" "cat - > /data/file/config" << EOF
scripts/config --enable CONFIG_SATA_AHCI
scripts/config --enable CONFIG_BLK_DEV_NVME
scripts/config --enable CONFIG_NVME_FC
scripts/config --enable CONFIG_NVME_TCP
scripts/config --enable CONFIG_NVME_TARGET
scripts/config --enable CONFIG_FAT_FS
scripts/config --enable CONFIG_NLS_ASCII
scripts/config --enable CONFIG_FAT_DEFAULT_UTF8
scripts/config --enable CONFIG_AUTOFS4_FS
scripts/config --enable CONFIG_AUTOFS_FS
scripts/config --enable CONFIG_OVERLAY_FS
scripts/config --enable CONFIG_TASK_DELAY_ACCT

scripts/config --set-str CONFIG_FAT_DEFAULT_IOCHARSET ascii
scripts/config --set-val CONFIG_FAT_DEFAULT_CODEPAGE 437
EOF
