#!/usr/bin/env bash

cfcli -d 'anurag.sh' rm linode1 || exit 0
cfcli -d 'anurag.sh' rm linode2 || exit 0

cfcli -d 'anurag.sh' rm oracle1 || exit 0
cfcli -d 'anurag.sh' rm oracle2 || exit 0

cfcli -t A -d 'anurag.sh' add linode1 "$(terraform output -json linode-public-ips | jq '.[0]' | tr -d '"')"
cfcli -t A -d 'anurag.sh' add linode2 "$(terraform output -json linode-public-ips | jq '.[1]' | tr -d '"')"
cfcli -t A -d 'anurag.sh' add oracle1 "$(terraform output -raw public-ip-paste)"
cfcli -t A -d 'anurag.sh' add oracle2 "$(terraform output -raw public-ip-buildkite)"

cfcli -t CNAME -d 'anurag.sh' add jenkins linode2.anurag.sh || exit 0
