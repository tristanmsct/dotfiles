#!/usr/bin/env bash
#                                 _            _        _
# __   ___ __  _ __     __ _  ___| |_      ___| |_ __ _| |_ _   _ ___
# \ \ / / '_ \| '_ \   / _` |/ _ \ __|____/ __| __/ _` | __| | | / __|
#  \ V /| |_) | | | | | (_| |  __/ ||_____\__ \ || (_| | |_| |_| \__ \
#   \_/ | .__/|_| |_|  \__, |\___|\__|    |___/\__\__,_|\__|\__,_|___/
#       |_|            |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Read the VPN status file.
source "$DESKTOP_SCRIPTS/system/state-utils"
STATUS=$(state_get ".vpn.connected")

if [[ "$STATUS" = "false" ]]; then
    echo "{\"text\": \"\", \"alt\": \"off\"}"
else
    INTERFACE=$(state_get ".vpn.interface")
    echo "{\"text\": \" 󰒃  \", \"tooltip\": \"$INTERFACE\", \"alt\": \"connected\"}"
fi
