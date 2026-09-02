#!/usr/bin/env bash
#                                      _       _                 _        _
# __   ___ __  _ __    _   _ _ __   __| | __ _| |_ ___       ___| |_ __ _| |_ _   _ ___
# \ \ / / '_ \| '_ \  | | | | '_ \ / _` |/ _` | __/ _ \_____/ __| __/ _` | __| | | / __|
#  \ V /| |_) | | | | | |_| | |_) | (_| | (_| | ||  __/_____\__ \ || (_| | |_| |_| \__ \
#   \_/ | .__/|_| |_|  \__,_| .__/ \__,_|\__,_|\__\___|     |___/\__\__,_|\__|\__,_|___/
#       |_|                 |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)

if [[ $INTERFACE == "" ]]; then
    state_set ".vpn.connected" false
    state_del ".vpn.interface"
else
    # Usually there should be an argument there because we should always set-up the VPN using the menu
    # But if the VPN is set up using CLI, then the state can still be updated.
    # ProtonVPN cli being not so good, there is no way at this point to get the real location so the
    # interface will just be some default name like "proton0".
    if [[ -n "$*" ]]; then
        INTERFACE="$*"
    fi
    state_set ".vpn.connected" true
    state_set ".vpn.interface" $INTERFACE
fi
