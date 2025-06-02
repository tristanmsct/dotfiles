#!/usr/bin/env bash
#                            _       _ _     _
#  ___  ___  _   _ _ __   __| |  ___| (_) __| | ___ _ __
# / __|/ _ \| | | | '_ \ / _` | / __| | |/ _` |/ _ \ '__|
# \__ \ (_) | |_| | | | | (_| | \__ \ | | (_| |  __/ |
# |___/\___/ \__,_|_| |_|\__,_| |___/_|_|\__,_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
new_value=$1

output=$(amixer sget Master | grep "Front Left:")
volume=$(echo "$output" | grep -oP '\[\K\d+%')
volume=$(echo $volume | sed 's/%//g')
status=$(echo "$output" | grep -oP '\[on\]|\[off\]' | tr -d '[]')

set_icon () {
    if [ $1 = "off" ]; then
        echo " " > /tmp/eww_sound_icon
    else
        if [ $2 -ge 50 ]; then
            echo " " > /tmp/eww_sound_icon
        elif [ $2 -gt 0 ]; then
            echo " " > /tmp/eww_sound_icon
        else
            echo " " > /tmp/eww_sound_icon
        fi
    fi
}

if [ $new_value = "mute" ]; then
    if [ $status = "off" ]; then
        amixer set -q Master on
        set_icon on $volume
    else
        amixer set -q Master off
        set_icon off $volume
    fi
else
    amixer set -q Master "${new_value}%"
    set_icon $status $new_value
fi
