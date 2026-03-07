#!/bin/bash

# Get active VPN connections
VPNS=$(nmcli -t -f NAME,TYPE connection show --active | awk -F: '$2=="vpn"{print $1}')

if [ -n "$VPNS" ]; then
    TEXT="󰦝 "
    while read -r VPN; do
        TEXT+="$VPN  "
    done <<< "$VPNS"

    echo "{\"text\":\"$TEXT\",\"class\":\"connected\"}"
else
    echo '{"text":"󰦞 VPN","class":"disconnected"}'
fi

