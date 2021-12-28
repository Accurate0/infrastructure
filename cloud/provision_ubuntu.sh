#!/usr/bin/env bash
set -x

KEY="./instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

PRIVATE_KEY="$KEY"

SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

SERVERS="oracle1.anurag.sh oracle2.anurag.sh"

provision() {
$SSH_COMMAND "ubuntu@$1" "bash -s" << EOF
    set -x
    sudo apt-get update -y
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --no-tty --dearmor --batch -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=\$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    \$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io rsync python3-pip zstd

    sudo systemctl daemon-reload
    sudo systemctl enable --now --no-block docker.service
    sudo usermod -a -G docker ubuntu
    sudo pip install docker-compose
EOF
}

for server in $SERVERS; do
    provision "$server" &
done

wait
