#!/usr/bin/env bash
#             _        _
#   __ _  ___| |_     (_) ___ ___  _ __
#  / _` |/ _ \ __|____| |/ __/ _ \| '_ \
# | (_| |  __/ ||_____| | (_| (_) | | | |
#  \__, |\___|\__|    |_|\___\___/|_| |_|
#  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

output=$(amixer sget Master | grep "Front Left:")
volume=$(echo "$output" | grep -oP '\[\K\d+%')
volume=${volume//%/}
status=$(echo "$output" | grep -oP '\[on\]|\[off\]' | tr -d '[]')

if [ "$status" = "off" ]; then
    echo " "
else
    if [ "$volume" -ge 50 ]; then
        echo " "
    elif [ "$volume" -gt 0 ]; then
        echo " "
    else
        echo " "
    fi
fi
