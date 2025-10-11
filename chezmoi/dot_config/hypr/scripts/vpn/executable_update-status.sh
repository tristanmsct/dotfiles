#!/usr/bin/env bash
#                                      _       _                 _        _
# __   ___ __  _ __    _   _ _ __   __| | __ _| |_ ___       ___| |_ __ _| |_ _   _ ___
# \ \ / / '_ \| '_ \  | | | | '_ \ / _` |/ _` | __/ _ \_____/ __| __/ _` | __| | | / __|
#  \ V /| |_) | | | | | |_| | |_) | (_| | (_| | ||  __/_____\__ \ || (_| | |_| |_| \__ \
#   \_/ | .__/|_| |_|  \__,_| .__/ \__,_|\__,_|\__\___|     |___/\__\__,_|\__|\__,_|___/
#       |_|                 |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

CONFIG_FILE=$XDG_STATE_HOME/desktop/state.json

if [[ $INTERFACE == "" ]]; then
    jq '.vpn.connected = false' $CONFIG_FILE | sponge $CONFIG_FILE
    jq 'del(.vpn.interface)' $CONFIG_FILE | sponge $CONFIG_FILE
else
    INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)
    jq '.vpn.connected = true' $CONFIG_FILE | sponge $CONFIG_FILE
    jq --arg interface $INTERFACE '.vpn.interface = $interface' $CONFIG_FILE | sponge $CONFIG_FILE
fi
