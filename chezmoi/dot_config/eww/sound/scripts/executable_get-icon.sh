#!/usr/bin/env bash
#                            _       _ _     _
#  ___  ___  _   _ _ __   __| |  ___| (_) __| | ___ _ __
# / __|/ _ \| | | | '_ \ / _` | / __| | |/ _` |/ _ \ '__|
# \__ \ (_) | |_| | | | | (_| | \__ \ | | (_| |  __/ |
# |___/\___/ \__,_|_| |_|\__,_| |___/_|_|\__,_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

output=$(amixer sget Master | grep "Front Left:")
volume=$(echo "$output" | grep -oP '\[\K\d+%')
volume=$(echo $volume | sed 's/%//g')
status=$(echo "$output" | grep -oP '\[on\]|\[off\]' | tr -d '[]')

if [ $status = "off" ]; then
    echo " "
else
    if [ $volume -ge 50 ]; then
        echo " "
    elif [ $volume -gt 0 ]; then
        echo " "
    else
        echo " "
    fi
fi
