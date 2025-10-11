#!/usr/bin/env bash
#  _           _   _                                              _ _
# | |__   __ _| |_| |_ ___ _ __ _   _       _ __ ___   ___  _ __ (_) |_ ___  _ __
# | '_ \ / _` | __| __/ _ \ '__| | | |_____| '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|
# | |_) | (_| | |_| ||  __/ |  | |_| |_____| | | | | | (_) | | | | | || (_) | |
# |_.__/ \__,_|\__|\__\___|_|   \__, |     |_| |_| |_|\___/|_| |_|_|\__\___/|_|
#                               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

battery_level=$(cat /sys/class/power_supply/BAT1/capacity)
file_cache_level=$HOME/.cache/battery-level


if [ -f $file_cache_level ]; then
    previous_level=$(cat $file_cache_level)
else
    previous_level=$battery_level
fi

if [ "$battery_level" -gt "$previous_level" ]; then
    if [ $battery_level = 100 ]; then
        dunstify "Battery fully charged"
    fi
elif [ "$previous_level" -gt "$battery_level" ]; then
    if [ $battery_level = 50 ]; then
        dunstify "Battery at 50% level"
    elif [ $battery_level = 20 ]; then
        dunstify "Battery at 20% level"
    elif [ $battery_level = 10 ]; then
        dunstify -u critical "Battery at critical 10% level"
    elif [ $battery_level = 5 ]; then
        dunstify -u critical "Battery at critical 5% level, shutting down soon"
    fi
fi

echo $battery_level > $file_cache_level
