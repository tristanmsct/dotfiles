#!/usr/bin/env bash
#             _        _
#   __ _  ___| |_     (_) ___ ___  _ __
#  / _` |/ _ \ __|____| |/ __/ _ \| '_ \
# | (_| |  __/ ||_____| | (_| (_) | | | |
#  \__, |\___|\__|    |_|\___\___/|_| |_|
#  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Use wpctl to get the default sink volume and mute status
output_vol=$(wpctl get-volume @DEFAULT_SINK@ 2>/dev/null || true)
volume=$(echo "$output_vol" | grep -oP '\d+(\.\d+)?' | head -n1)
volume=$(awk -v v="$volume" 'BEGIN{printf("%d", v*100)}')
status=$(echo "$output_vol" | grep -oP '\[MUTED\]')

if [ "$status" = "[MUTED]" ]; then
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
