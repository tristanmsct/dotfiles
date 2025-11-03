#!/usr/bin/env bash
#  _           _   _                                              _ _
# | |__   __ _| |_| |_ ___ _ __ _   _       _ __ ___   ___  _ __ (_) |_ ___  _ __
# | '_ \ / _` | __| __/ _ \ '__| | | |_____| '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|
# | |_) | (_| | |_| ||  __/ |  | |_| |_____| | | | | | (_) | | | | | || (_) | |
# |_.__/ \__,_|\__|\__\___|_|   \__, |     |_| |_| |_|\___/|_| |_|_|\__\___/|_|
#                               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

CONFIG_FILE=$HOME/.local/state/desktop/battery.json

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
PREVIOUS_LEVEL=$(jq -r '.battery_level' $CONFIG_FILE)

if [ "$BATTERY_LEVEL" -gt "$PREVIOUS_LEVEL" ]; then
    if [ $BATTERY_LEVEL = 100 ]; then
        dunstify "Battery fully charged"
    fi
elif [ "$PREVIOUS_LEVEL" -gt "$BATTERY_LEVEL" ]; then
    if [ $BATTERY_LEVEL = 50 ]; then
        dunstify "Battery at 50% level"
    elif [ $BATTERY_LEVEL = 20 ]; then
        dunstify "Battery at 20% level"
    elif [ $BATTERY_LEVEL = 10 ]; then
        dunstify -u critical "Battery at critical 10% level"
    elif [ $BATTERY_LEVEL = 5 ]; then
        dunstify -u critical "Battery at critical 5% level, shutting down soon"
    fi
fi

jq --argjson battery_level $BATTERY_LEVEL -r '.battery_level = $battery_level' $CONFIG_FILE | sponge $CONFIG_FILE
