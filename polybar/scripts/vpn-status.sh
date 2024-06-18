#!/bin/sh

json=$( curl -s https://am.i.mullvad.net/json )
server=$(echo "$json" | jq --raw-output '.mullvad_exit_ip_hostname')

if [ "$server" = "null" ]; then
    ip=$(echo "$json" | jq --raw-output '.ip')
    echo "  $ip"
else
    echo "  $server"
fi
