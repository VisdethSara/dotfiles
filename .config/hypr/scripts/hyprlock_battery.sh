#!/bin/bash
# --- SCRIPT IS A MODIFIED VERSION OF https://github.com/ashish-kus/dotfiles/blob/main/hypr/.config/hypr/bin/infonlock.sh
# Get the current battery percentage
BATT_PERCENT=$(cat /sys/class/power_supply/BAT1/capacity)

# Get the battery status (Charging or Discharging)
BATT_STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Define the battery icons for each 10% segment
ICONS=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate index (0–8)
INDEX=$(( BATT_PERCENT * (${#ICONS[@]} - 1) / 100 ))

ICON="${ICONS[$INDEX]}"

# Check if the battery is charging
if [ "$BATT_STATUS" = "Charging" ]; then
	ICON="$charging_icon"
fi

# Output the battery percentage and icon
echo "$BATT_PERCENT% $ICON"
