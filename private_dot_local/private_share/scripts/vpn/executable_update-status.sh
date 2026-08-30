#!/usr/bin/env bash
#                                      _       _                 _        _
# __   ___ __  _ __    _   _ _ __   __| | __ _| |_ ___       ___| |_ __ _| |_ _   _ ___
# \ \ / / '_ \| '_ \  | | | | '_ \ / _` |/ _` | __/ _ \_____/ __| __/ _` | __| | | / __|
#  \ V /| |_) | | | | | |_| | |_) | (_| | (_| | ||  __/_____\__ \ || (_| | |_| |_| \__ \
#   \_/ | .__/|_| |_|  \__,_| .__/ \__,_|\__,_|\__\___|     |___/\__\__,_|\__|\__,_|___/
#       |_|                 |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE=$XDG_STATE_HOME/desktop/state.json
INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)

if [[ $INTERFACE == "" ]]; then
    jq '.vpn.connected = false' $STATE_FILE | sponge $STATE_FILE
    jq 'del(.vpn.interface)' $STATE_FILE | sponge $STATE_FILE
else
    # Usually there should be an argument there because we should always set-up the VPN using the menu
    # But if the VPN is set up using CLI, then the state can still be updated.
    # ProtonVPN cli being not so good, there is no way at this point to get the real location so the
    # interface will just be some default name like "proton0".
    if [[ -n "$*" ]]; then
        INTERFACE="$*"
    fi
    jq '.vpn.connected = true' $STATE_FILE | sponge $STATE_FILE
    jq --arg interface "$INTERFACE" '.vpn.interface = $interface' $STATE_FILE | sponge $STATE_FILE
fi
