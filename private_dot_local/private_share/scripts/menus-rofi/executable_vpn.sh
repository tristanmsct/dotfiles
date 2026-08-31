#!/usr/bin/env bash
# __   ___ __  _ __        _ __ ___   ___ _ __  _   _
# \ \ / / '_ \| '_ \ _____| '_ ` _ \ / _ \ '_ \| | | |
#  \ V /| |_) | | | |_____| | | | | |  __/ | | | |_| |
#   \_/ | .__/|_| |_|     |_| |_| |_|\___|_| |_|\__,_|
#       |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# List of quick connect countries. --------------------------------------------------------------------------------------------------------
LST_COUNTRIES=(
    "FR"
    "UK"
    "US"
    "AU"
)

# Creating the list to be displayed. ------------------------------------------------------------------------------------------------------

LST_INTERFACES=""
for country in "${LST_COUNTRIES[@]}"; do
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

THEME_VPN="window { font: 'Noto Sans Bold 14'; width: 20%;} element { margin: 0% 0% 1.5% 0%;} listview {cycle: true;}"

SELECTION=$(
    echo -e "$LST_INTERFACES" | rofi -disable-history -dmenu \
        -config "$XDG_CONFIG_HOME/rofi/config-simple.rasi" -theme-str "${THEME_VPN}" \
        -markup-rows -l $NB_INTERFACE -p "Select:"
    )
CLEAN_SELECTION="${SELECTION#* }"
CLEAN_SELECTION="${CLEAN_SELECTION#"${CLEAN_SELECTION%%[![:space:]]*}"}"

# Allow to exit when pressing esc on the menu.
if [[ $CLEAN_SELECTION == "" ]]; then
    exit
fi

# VPN Logic. ------------------------------------------------------------------------------------------------------------------------------

# If there is already a VPN running we disconnect.
# If we want a new VPN connection, then we need to disconnect, if we just chose disconnect, then we need to diconnect too.
if [[ $INITIAL_INTERFACE != "" ]]; then
	if [[ $INITIAL_INTERFACE == *"Raspberrypi-VPN"* ]]; then
    	nmcli connection down Raspberrypi-VPN
    fi
    protonvpn disconnect
    "$DESKTOP_SCRIPTS/vpn/update-status.sh"
fi

# Start Raspberrypi VPN or Mullvad if we chose one of them. If we clicked Disconnect, we do nothing.
if [[ $CLEAN_SELECTION == *"Raspberrypi-VPN"* ]]; then
    docker ps | grep -q gluetun && docker compose --file "$HOME/Nextcloud/07-Servarr/compose.yaml" down qbittorrent gluetun
    nmcli connection up "$CLEAN_SELECTION"
    "$DESKTOP_SCRIPTS/vpn/update-status.sh" "$CLEAN_SELECTION"
elif [[ $CLEAN_SELECTION != *"Deactivate"* ]]; then
    docker ps | grep -q gluetun && docker compose --file "$HOME/Nextcloud/07-Servarr/compose.yaml" down qbittorrent gluetun
    # Extract country code (e.g., "Proton-FR" -> "FR").
    COUNTRY="${CLEAN_SELECTION#Proton-}"
    COUNTRY="${COUNTRY%%[[:space:]]*}"

    # Connect and capture output.
    OUTPUT=$(protonvpn connect --country "$COUNTRY" 2>&1)
    # Extract location from "Connected to X in (location)." line.
    if echo "$OUTPUT" | grep -q "Connected to"; then
        LOCATION=$(echo "$OUTPUT" | grep -oP '(?<=in )[\w\s,]+(?=\. )')
        printf '%s\n' "$LOCATION"

        "$DESKTOP_SCRIPTS/vpn/update-status.sh" "$LOCATION"
    elif echo "$OUTPUT" | grep -q "Invalid country name"; then
        dunstify "Invalid country name"
    fi
fi
