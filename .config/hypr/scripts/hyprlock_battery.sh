#!/bin/bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity)

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT1/status)

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate index (0–8)
INDEX=$(( PERCENT * (${#ICONS[@]} - 1) / 100 ))

ICON="${ICONS[$INDEX]}"


# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	ICON="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_percentage% $ICON"
