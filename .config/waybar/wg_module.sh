#!/bin/bash

# Get active WireGuard interfaces
INTERFACES=$(wg show interfaces 2>/dev/null)

if [ -n "$INTERFACES" ]; then
    # Convert space-separated list into comma-separated
    DISPLAY=$(echo "$INTERFACES" | tr ' ' ', ')
    echo "{\"text\":\"󰦝  $DISPLAY\",\"tooltip\":\"$DISPLAY\",\"class\":\"connected\"}"
else
    echo '{"text":"󰦞","tooltip":"WireGuard disconnected","class":"disconnected"}'
fi

