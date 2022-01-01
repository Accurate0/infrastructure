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

echo \$JENKINS_EXEC_SECRET > jenkins_secret
wget https://jenkins.anurag.sh/jnlpJars/agent.jar -O agent.jar
java -jar agent.jar -jnlpUrl https://jenkins.anurag.sh/computer/linode1/jenkins-agent.jnlp -secret @jenkins_secret -workDir "/var/jenkins"
EOF
