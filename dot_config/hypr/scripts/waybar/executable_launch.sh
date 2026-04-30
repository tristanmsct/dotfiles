#!/usr/bin/env bash
#  _                           _      __        __          _
# | |    __ _ _   _ _ __   ___| |__   \ \      / /_ _ _   _| |__   __ _ _ __
# | |   / _` | | | | '_ \ / __| '_ \   \ \ /\ / / _` | | | | '_ \ / _` | '__|
# | |__| (_| | |_| | | | | (__| | | |   \ V  V / (_| | |_| | |_) | (_| | |
# |_____\__,_|\__,_|_| |_|\___|_| |_|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#                                                     |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

STATE_FILE=$HOME/.local/state/desktop/state.json
WAYBAR_STATUS=$(jq '.waybar.enabled' $STATE_FILE)

# Quit all running waybar instances.
pkill waybar
sleep 0.5

# Restart waybar
if [ $WAYBAR_STATUS = "true" ] ;then
    waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css" &
fi
