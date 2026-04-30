#!/usr/bin/env bash
#  _____                 _       __        __          _
# |_   _|__   __ _  __ _| | ___  \ \      / /_ _ _   _| |__   __ _ _ __
#   | |/ _ \ / _` |/ _` | |/ _ \  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#   | | (_) | (_| | (_| | |  __/   \ V  V / (_| | |_| | |_) | (_| | |
#   |_|\___/ \__, |\__, |_|\___|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#            |___/ |___/                         |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

STATE_FILE=$HOME/.local/state/desktop/state.json
WAYBAR_STATUS=$(jq '.waybar.enabled' $STATE_FILE)

if [ $WAYBAR_STATUS = "true" ] ;then
    jq '.waybar.enabled = false' $STATE_FILE | sponge $STATE_FILE
else
    jq '.waybar.enabled = true' $STATE_FILE | sponge $STATE_FILE
fi

$HOME/.config/hypr/scripts/waybar/launch.sh &
