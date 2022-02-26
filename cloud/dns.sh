#!/usr/bin/env bash
cfcli -d 'anurag.sh' rm oracle1
cfcli -d 'anurag.sh' rm oracle2
cfcli -d 'anurag.sh' rm ww3

cfcli -t A -d 'anurag.sh' add oracle1 "$(terraform output -raw public-ip-paste)"
cfcli -t A -d 'anurag.sh' add oracle2 "$(terraform output -raw public-ip-buildkite)"

cfcli -t CNAME -d 'anurag.sh' -a add ww3 oracle1.anurag.sh
