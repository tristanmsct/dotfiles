#!/usr/bin/env bash
#      _            _                  _                    _
#   __| | ___   ___| | _____ _ __     | |_ ___   __ _  __ _| | ___
#  / _` |/ _ \ / __| |/ / _ \ '__|____| __/ _ \ / _` |/ _` | |/ _ \
# | (_| | (_) | (__|   <  __/ | |_____| || (_) | (_| | (_| | |  __/
#  \__,_|\___/ \___|_|\_\___|_|        \__\___/ \__, |\__, |_|\___|
#                                               |___/ |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

if systemctl is-active --quiet docker.service; then
    if [ -z "$1" ]; then
        systemctl stop docker.service
    elif [ $1 = "status" ]; then
        echo '{"class": "docker_on"}'
    fi
else
    if [ -z "$1" ]; then
        systemctl start docker.service
    elif [ $1 = "status" ]; then
        echo '{"class": "docker_off"}'
    fi
fi

# Update waybar icon config.
pkill -RTMIN+8 waybar
