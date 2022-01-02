#!/usr/bin/env bash
# manual deployment, please dont hurt me
set -eo pipefail

exit 0

KEY="./terraform/instance_key"
[ -f "$KEY" ] || echo "$INSTANCE_KEY" >> "$KEY"
chmod 400 "$KEY"

REMOTE_USER=root
PRIVATE_KEY="$KEY"
PUBLIC_IP_JENKINS="linode3.anurag.sh"
SSH_COMMAND="ssh -q -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i $PRIVATE_KEY"

set -x
$SSH_COMMAND "$REMOTE_USER@$PUBLIC_IP_JENKINS" "bash -s" << EOF
set -x
mkdir -p /var/jenkins
mkdir -p /srv/buildmachine
cd /srv/buildmachine

echo $JENKINS_EXEC_SECRET_LINODE3 > jenkins_secret

useradd -m jenkins
echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
chown -R jenkins:jenkins /var/jenkins
chown -R jenkins:jenkins /srv/buildmachine

pkill -f -9 agent.jar
wget https://jenkins.anurag.sh/jnlpJars/agent.jar -O agent.jar

sudo -u jenkins nohup java -jar agent.jar -jnlpUrl https://jenkins.anurag.sh/computer/linode3/jenkins-agent.jnlp -secret @jenkins_secret -workDir "/var/jenkins" </dev/null >std.out 2>std.err &
EOF
