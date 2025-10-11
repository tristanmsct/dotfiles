#!/usr/bin/env bash
#                                 _            _        _
# __   ___ __  _ __     __ _  ___| |_      ___| |_ __ _| |_ _   _ ___
# \ \ / / '_ \| '_ \   / _` |/ _ \ __|____/ __| __/ _` | __| | | / __|
#  \ V /| |_) | | | | | (_| |  __/ ||_____\__ \ || (_| | |_| |_| \__ \
#   \_/ | .__/|_| |_|  \__, |\___|\__|    |___/\__\__,_|\__|\__,_|___/
#       |_|            |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

# Read the VPN status file.
CONFIG_FILE=$XDG_STATE_HOME/desktop/state.json
STATUS=$(jq '.vpn.connected' $CONFIG_FILE)

if [[ "$STATUS" = "false" ]]; then
    echo "{\"text\": \"\", \"alt\": \"off\"}"
else
    INTERFACE=$(jq '.vpn.interface' $CONFIG_FILE)
    echo "{\"text\": \" 󰒃  \", \"tooltip\": $INTERFACE, \"alt\": \"connected\"}"
fi
