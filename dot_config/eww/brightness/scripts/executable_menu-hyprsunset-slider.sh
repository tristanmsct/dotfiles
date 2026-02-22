#!/usr/bin/env bash
#  _                                               _         _ _     _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_   ___| (_) __| | ___ _ __
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __| / __| | |/ _` |/ _ \ '__|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ |_  \__ \ | | (_| |  __/ |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__| |___/_|_|\__,_|\___|_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
new_value=$1

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

CONFIG_FILE=$HOME/.local/state/desktop/state.json
manual_filter_on=$(jq '.hyprsunset.filter_on' $CONFIG_FILE)

jq '.hyprsunset.temperature ='$new_value $CONFIG_FILE | sponge $CONFIG_FILE

if [[ ($manual_filter_on = "true") ]]; then
    hyprctl hyprsunset temperature $new_value
fi
