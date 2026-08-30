#!/usr/bin/env bash
#                      _                  _                    _
# __      ____ _ _   _| |__   __ _ _ __  | |_ ___   __ _  __ _| | ___
# \ \ /\ / / _` | | | | '_ \ / _` | '__| | __/ _ \ / _` |/ _` | |/ _ \
#  \ V  V / (_| | |_| | |_) | (_| | |    | || (_) | (_| | (_| | |  __/
#   \_/\_/ \__,_|\__, |_.__/ \__,_|_|     \__\___/ \__, |\__, |_|\___|
#                |___/                             |___/ |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$DESKTOP_SCRIPTS/system/setup-state.sh

STATE_FILE=$XDG_STATE_HOME/desktop/state.json
WAYBAR_STATUS=$(jq '.waybar.enabled' $STATE_FILE)

if [ $WAYBAR_STATUS = "true" ] ;then
    jq '.waybar.enabled = false' $STATE_FILE | sponge $STATE_FILE
else
    jq '.waybar.enabled = true' $STATE_FILE | sponge $STATE_FILE
fi

$DESKTOP_SCRIPTS/waybar/launch.sh &
