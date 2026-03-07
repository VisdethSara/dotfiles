#!/bin/bash

# Get active vpn connections
active=$(nmcli -f NAME,TYPE connection show --active | awk '{if ($2=="vpn" || $2=="wireguard") print $1}')
activeCount=$(echo "$active" | wc -l)
all=$(nmcli -f NAME,TYPE,STATE connection show | awk '{if ($2=="vpn" || $2=="wireguard") print $1 " " $3}' | awk '{if ($2=="activated") print $1 " 󰦝"}{if ($2=="--") print $1 " 󰦞"}')

if [ $activeCount -gt 1 ]; then
    text="Multiple Connected 󰦝"
    class="connected"
elif [ $activeCount -eq 1 ]; then
    text="$active 󰦝"
    class="connected"
else
    text="None Connected 󰦞"
    class="disconnected"
fi

echo "{\"text\":\"$text\",\"class\":\"$class\"}"


