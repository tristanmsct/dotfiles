#!/usr/bin/env bash
# __   ___ __  _ __        _ __ ___   ___ _ __  _   _
# \ \ / / '_ \| '_ \ _____| '_ ` _ \ / _ \ '_ \| | | |
#  \ V /| |_) | | | |_____| | | | | |  __/ | | | |_| |
#   \_/ | .__/|_| |_|     |_| |_| |_|\___|_| |_|\__,_|
#       |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Map country codes to server IDs. --------------------------------------------------------------------------------------------------------
declare -A SERVER_MAP=(
    ["FR"]="FR#13"
    ["DE"]="DE#191"
    ["NL"]="NL#231"
    ["CH"]="CH#253"
    ["UK"]="UK#276"
    ["US"]="US-NY#193"
)

# Creating the list to be displayed. ------------------------------------------------------------------------------------------------------

LST_INTERFACES=""
for country in "${!SERVER_MAP[@]}"; do
     LST_INTERFACES+="󰒃   Proton-$country"
     LST_INTERFACES+=$'\n'
done
LST_INTERFACES+=$'   Raspberrypi-VPN'

# If a wireguard connection is already running, we add an option to down it.
INITIAL_INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)
if [[ $INITIAL_INTERFACE != "" ]]; then
    LST_INTERFACES+=$'\n   Deactivate'
fi

# Displaying rofi menu. -------------------------------------------------------------------------------------------------------------------

NB_INTERFACE=$(echo "$LST_INTERFACES" | wc -l)
NB_INTERFACE=$((NB_INTERFACE>=8 ? 8 : NB_INTERFACE))

SELECTION=$(echo -e "$LST_INTERFACES" | rofi -dmenu -font "Fira Sans,Fira Sans Medium 14" -config ~/.config/rofi/config-simple.rasi -markup-rows -l $NB_INTERFACE -p "Select:")
CLEAN_SELECTION=$(echo "$SELECTION" | sed 's/^[^ ]* //')

# VPN Logic. ------------------------------------------------------------------------------------------------------------------------------

# If there is already a VPN running we disconnect.
# If we want a new VPN connection, then we need to disconnect, if we just chose disconnect, then we need to diconnect too.
if [[ $INITIAL_INTERFACE != "" ]]; then
	if [[ $INITIAL_INTERFACE == *"Raspberrypi-VPN"* ]]; then
    	nmcli connection down Raspberrypi-VPN
    fi
    protonvpn disconnect
    $HOME/.config/hypr/scripts/vpn/update-status.sh
fi

# Start Raspberrypi VPN or Mullvad if we chose one of them. If we clicked Disconnect, we do nothing.
if [[ $CLEAN_SELECTION == *"Raspberrypi-VPN"* ]]; then
     docker ps | grep -q qbittorrent && docker compose --file $HOME/Nextcloud/07-Servarr/compose.yaml down
    nmcli connection up $CLEAN_SELECTION
    $HOME/.config/hypr/scripts/vpn/update-status.sh $CLEAN_SELECTION
elif [[ $CLEAN_SELECTION == *"Proton"* ]]; then
     docker ps | grep -q qbittorrent && docker compose --file $HOME/Nextcloud/07-Servarr/compose.yaml down
    # Extract country code (e.g., "Proton-FR" -> "FR").
    COUNTRY=$(echo "$CLEAN_SELECTION" | sed 's/Proton-//' | xargs)
    SERVER="${SERVER_MAP[$COUNTRY]}"

    # Connect and capture output.
    OUTPUT=$(protonvpn connect "$SERVER" 2>&1)
    # Extract location from "Connected to X in (location)." line.
    if echo "$OUTPUT" | grep -q "Connected to"; then
        LOCATION=$(echo "$OUTPUT" | grep "Connected to" | sed -n 's/.*in \(.*\)\. Your.*/\1/p')

        $HOME/.config/hypr/scripts/vpn/update-status.sh $LOCATION
    fi
fi
