#!/usr/bin/env bash
set -x

while :; do
    # if ping fails restart iwd
    if ! ping -c 4 www.google.com; then
        systemctl restart iwd
        sleep 15s
    fi

    IP_ADDRESS=$(ip addr show dev wlan0)

    cat > /data/ip/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Internal IP Address</title>
</head>
<body>
    <pre>$IP_ADDRESS</pre>
</body>
</html>
EOF

    sleep 3m
done
