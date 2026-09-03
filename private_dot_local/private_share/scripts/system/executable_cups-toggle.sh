#!/usr/bin/env bash
#                             _                    _
#   ___ _   _ _ __  ___      | |_ ___   __ _  __ _| | ___
#  / __| | | | '_ \/ __|_____| __/ _ \ / _` |/ _` | |/ _ \
# | (__| |_| | |_) \__ \_____| || (_) | (_| | (_| | |  __/
#  \___|\__,_| .__/|___/      \__\___/ \__, |\__, |_|\___|
#            |_|                       |___/ |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

script_name=$(basename "$0")

if systemctl is-active --quiet cups.service; then
    if [ -z "$1" ]; then
        logger -t cups -p user.info "[$script_name] Stopping cups service"
        systemctl stop cups.service
        # Update waybar icon config.
        pkill -RTMIN+9 waybar
    elif [ "$1" = "status" ]; then
        echo '{"class": "cups_on"}'
    fi
else
    if [ -z "$1" ]; then
        logger -t cups -p user.info "[$script_name] Starting cups service"
        systemctl start cups.service
        # Update waybar icon config.
        pkill -RTMIN+9 waybar
    elif [ "$1" = "status" ]; then
        echo '{"class": "cups_off"}'
    fi
fi
