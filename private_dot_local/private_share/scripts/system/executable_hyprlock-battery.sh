#!/usr/bin/env bash
#  _                      _            _         _           _   _
# | |__  _   _ _ __  _ __| | ___   ___| | __    | |__   __ _| |_| |_ ___ _ __ _   _
# | '_ \| | | | '_ \| '__| |/ _ \ / __| |/ /____| '_ \ / _` | __| __/ _ \ '__| | | |
# | | | | |_| | |_) | |  | | (_) | (__|   <_____| |_) | (_| | |_| ||  __/ |  | |_| |
# |_| |_|\__, | .__/|_|  |_|\___/ \___|_|\_\    |_.__/ \__,_|\__|\__\___|_|   \__, |
#        |___/|_|                                                             |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Check if battery device exists
if [ ! -d /sys/class/power_supply/BAT1 ]; then
    exit 0
fi

# Read battery stats
battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity)
battery_status=$(cat /sys/class/power_supply/BAT1/status)

# Define Nerd Font icons for different levels
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
charging_icon="󰂄"

# Select icon based on percentage
icon_index=$((battery_percentage / 10))
battery_icon=${battery_icons[$icon_index]}

# Override icon if charging
if [ "$battery_status" = "Charging" ]; then
    battery_icon="$charging_icon"
fi

# Output the result for Hyprlock
echo "$battery_percentage% $battery_icon"
