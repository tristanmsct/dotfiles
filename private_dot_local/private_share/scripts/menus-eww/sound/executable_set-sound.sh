#!/usr/bin/env bash
#           _                                  _
#  ___  ___| |_      ___  ___  _   _ _ __   __| |
# / __|/ _ \ __|____/ __|/ _ \| | | | '_ \ / _` |
# \__ \  __/ ||_____\__ \ (_) | |_| | | | | (_| |
# |___/\___|\__|    |___/\___/ \__,_|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
new_value=$1

output=$(amixer sget Master | grep "Front Left:")
volume=$(echo "$output" | grep -oP '\[\K\d+%')
volume=${volume//%/}
status=$(echo "$output" | grep -oP '\[on\]|\[off\]' | tr -d '[]')

if [ "$new_value" = "mute" ]; then
    if [ "$status" = "off" ]; then
        amixer set -q Master on
    else
        amixer set -q Master off
    fi
else
    amixer set -q Master "${new_value}%"
fi
