#!/usr/bin/env bash

cfcli -d 'anurag.sh' rm linode1 || exit 0
cfcli -d 'anurag.sh' rm linode2 || exit 0

cfcli -d 'anurag.sh' rm oracle1 || exit 0
cfcli -d 'anurag.sh' rm oracle2 || exit 0

cfcli -d 'anurag.sh' rm jenkins || exit 0
cfcli -d 'anurag.sh' rm files || exit 0
cfcli -d 'anurag.sh' rm paste || exit 0

cfcli -t A -d 'anurag.sh' add linode1 "$(terraform output -json linode-public-ips | jq '.[0]' | tr -d '"')"
cfcli -t A -d 'anurag.sh' add linode2 "$(terraform output -json linode-public-ips | jq '.[1]' | tr -d '"')"
cfcli -t A -d 'anurag.sh' add linode3 "$(terraform output -raw linode3-public-ip)"
cfcli -t A -d 'anurag.sh' add oracle1 "$(terraform output -raw public-ip-paste)"
cfcli -t A -d 'anurag.sh' add oracle2 "$(terraform output -raw public-ip-buildkite)"

cfcli -t CNAME -d 'anurag.sh' add files oracle2.anurag.sh || exit 0
cfcli -t CNAME -d 'anurag.sh' -a add paste oracle1.anurag.sh || exit 0
cfcli -t CNAME -d 'anurag.sh' -a add jenkins linode2.anurag.sh || exit 0
