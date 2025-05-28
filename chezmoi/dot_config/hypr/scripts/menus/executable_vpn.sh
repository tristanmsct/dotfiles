#!/bin/bash
# __   ___ __  _ __        _ __ ___   ___ _ __  _   _
# \ \ / / '_ \| '_ \ _____| '_ ` _ \ / _ \ '_ \| | | |
#  \ V /| |_) | | | |_____| | | | | |  __/ | | | |_| |
#   \_/ | .__/|_| |_|     |_| |_| |_|\___|_| |_|\__,_|
#       |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

LST_WG_INTERFACES=$(nmcli -g NAME,TYPE connection show | grep ":wireguard$" | cut -d':' -f1)
INITIAL_INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)

# If a wireguard connection is already running, we add an option to down it.
if [[ $INITIAL_INTERFACE != "" ]]; then
    LST_WG_INTERFACES+=$'\nDeactivate'
fi

NB_INTERFACE=$(echo "$LST_WG_INTERFACES" | wc -l)
NB_INTERFACE=$((NB_INTERFACE>=8 ? 8 : NB_INTERFACE))

SELECTION=$(echo -e "$LST_WG_INTERFACES" | rofi -dmenu -config ~/.config/rofi/config-simple.rasi -markup-rows -l $NB_INTERFACE -p "Select:")

if [[ $SELECTION == "" ]]; then
    # This command "successfully does nothing", allowing for an empty if segment.
    :
elif [[ $SELECTION == "Deactivate" ]]; then
    echo "Deactivating current interface"
    nmcli connection down $INITIAL_INTERFACE
else
    if [[ $INITIAL_INTERFACE != "" ]]; then
        nmcli connection down $INITIAL_INTERFACE
    fi
    nmcli connection up $SELECTION
fi

$HOME/.config/hypr/scripts/vpn/update-status.sh
