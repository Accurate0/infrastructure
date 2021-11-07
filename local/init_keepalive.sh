#!/usr/bin/env bash

set -x
cp keepalive.sh /usr/local/bin/
cp keepalive.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now keepalive.service
