#!/bin/bash

STATE_FILE="$HOME/.cache/gamma_brightness"
mkdir -p "$(dirname "$STATE_FILE")"

[ -f "$STATE_FILE" ] || echo "1.0" > "$STATE_FILE"

CURRENT=$(cat "$STATE_FILE")
[[ $CURRENT =~ ^[0-9]*\.?[0-9]+$ ]] || CURRENT=1.0

STEP=0.05
MIN=0.2
MAX=1.0

ARG="$1"

if [[ "$ARG" == "up" ]]; then
    NEW=$(awk "BEGIN {printf \"%.2f\", $CURRENT + $STEP}")
elif [[ "$ARG" == "down" ]]; then
    NEW=$(awk "BEGIN {printf \"%.2f\", $CURRENT - $STEP}")
elif [[ "$ARG" =~ ^[0-9]*\.?[0-9]+$ ]]; then
    NEW=$(awk "BEGIN {printf \"%.2f\", $ARG}")
else
    echo "Usage: $0 up|down|<value>"
    exit 1
fi

# Clamp
NEW=$(awk -v val="$NEW" -v min="$MIN" -v max="$MAX" \
    'BEGIN {
        if(val > max) val = max;
        else if(val < min) val = min;
        printf "%.2f", val
    }')

echo "$NEW" > "$STATE_FILE"

# Apply gamma brightness safely (no daemon)
# Kill any existing gammastep instance
pkill -x gammastep

# Start fresh daemon with new brightness
gammastep -O 6500 -b "$NEW" -P &

# Refresh Waybar module
pkill -RTMIN+10 waybar

PERCENT=$(awk "BEGIN{printf \"%d\", $NEW*100}")

if [[ "$NEW" == "$MAX" ]]; then
    notify-send "Brightness" "Maximum brightness"
elif [[ "$NEW" == "$MIN" ]]; then
    notify-send "Brightness" "Minimum brightness"
else
    notify-send "Brightness" "$PERCENT%"
fi

