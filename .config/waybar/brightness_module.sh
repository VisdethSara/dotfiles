#!/bin/bash

# Path to your persistent brightness file
STATE_FILE="$HOME/.cache/gamma_brightness"

# Icon array (low → high)
ICONS=("" "" "" "" "" "" "" "" "")

# Fallback if file missing
if [ ! -f "$STATE_FILE" ]; then
    echo "1.0" > "$STATE_FILE"
fi

# Read brightness
BRIGHTNESS=$(cat "$STATE_FILE")

# Clamp (safety)
if ! [[ $BRIGHTNESS =~ ^[0-9]*\.?[0-9]+$ ]]; then
    BRIGHTNESS=1.0
fi

# Convert to percentage
PERCENT=$(awk "BEGIN{printf \"%d\", $BRIGHTNESS*100}")

# Calculate index (0–8)
INDEX=$(( PERCENT * (${#ICONS[@]} - 1) / 100 ))

ICON="${ICONS[$INDEX]}"

# Output for Waybar (JSON or plain text)
# Plain text example:
echo "$ICON $PERCENT%"

