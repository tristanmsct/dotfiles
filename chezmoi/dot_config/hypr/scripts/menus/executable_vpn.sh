#!/usr/bin/env bash
# __   ___ __  _ __        _ __ ___   ___ _ __  _   _
# \ \ / / '_ \| '_ \ _____| '_ ` _ \ / _ \ '_ \| | | |
#  \ V /| |_) | | | |_____| | | | | |  __/ | | | |_| |
#   \_/ | .__/|_| |_|     |_| |_| |_|\___|_| |_|\__,_|
#       |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# List of interfaces.
# Just add a country here.
LST_INTERFACES='󰒃   Mullvad-FR'
LST_INTERFACES+=$'\n''󰒃   Mullvad-NL'
LST_INTERFACES+=$'\n''󰒃   Mullvad-UK'
LST_INTERFACES+=$'\n''󰒃   Mullvad-DE'
LST_INTERFACES+=$'\n''󰒃   Mullvad-US'
LST_INTERFACES+=$'\n''   Raspberrypi-VPN'

INITIAL_INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)

# If a wireguard connection is already running, we add an option to down it.
if [[ $INITIAL_INTERFACE != "" ]]; then
    LST_INTERFACES+=$'\n   Deactivate'
fi


# Displaying rofi menu.

NB_INTERFACE=$(echo "$LST_INTERFACES" | wc -l)
NB_INTERFACE=$((NB_INTERFACE>=8 ? 8 : NB_INTERFACE))

SELECTION=$(echo -e "$LST_INTERFACES" | rofi -dmenu -font "Fira Sans,Fira Sans Medium 14" -config ~/.config/rofi/config-simple.rasi -markup-rows -l $NB_INTERFACE -p "Select:")
CLEAN_SELECTION=$(echo "$SELECTION" | sed 's/^[^ ]* //')

# VPN Logic.

# If there is already a VPN running we disconnect.
# If we want a new VPN connection, then we need to disconnect, if we just chose disconnect, then we need to diconnect too.
if [[ $INITIAL_INTERFACE != "" ]]; then
    nmcli connection down Raspberrypi-VPN
    mullvad disconnect
fi

# Start Raspberrypi VPN or Mullvad if we chose one of them. If we clicked Disconnect, we do nothing.
if [[ $CLEAN_SELECTION == *"Raspberrypi-VPN"* ]]; then
    nmcli connection up $CLEAN_SELECTION
elif [[ $CLEAN_SELECTION == *"Mullvad"* ]]; then
    COUNTRY_LOWER="${CLEAN_SELECTION##*-}"
    COUNTRY_LOWER="${COUNTRY_LOWER,,}"
    mullvad relay set location $COUNTRY_LOWER
    mullvad connect
fi
