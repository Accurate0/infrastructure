#!/usr/bin/env bash
# manual deployment, please dont hurt me
set -eo pipefail

KEY="./terraform/instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

REMOTE_USER=root
PRIVATE_KEY="$KEY"
PUBLIC_IP_JENKINS="linode1.anurag.sh"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

set -x
$SSH_COMMAND "$REMOTE_USER@$PUBLIC_IP_JENKINS" "bash -s" << EOF
mkdir -p /srv/buildmachine
cd /srv/buildmachine

useradd -m jenkins || exit 0
su jenkins

echo $JENKINS_EXEC_SECRET > jenkins_secret
pkill -f -9 agent.jar
nohup java -jar agent.jar -jnlpUrl https://jenkins.anurag.sh/computer/linode1/jenkins-agent.jnlp -secret @jenkins_secret -workDir "/var/jenkins" &
EOF
