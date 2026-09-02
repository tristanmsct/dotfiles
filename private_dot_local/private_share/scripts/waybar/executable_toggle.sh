#!/usr/bin/env bash
#                      _                  _                    _
# __      ____ _ _   _| |__   __ _ _ __  | |_ ___   __ _  __ _| | ___
# \ \ /\ / / _` | | | | '_ \ / _` | '__| | __/ _ \ / _` |/ _` | |/ _ \
#  \ V  V / (_| | |_| | |_) | (_| | |    | || (_) | (_| | (_| | |  __/
#   \_/\_/ \__,_|\__, |_.__/ \__,_|_|     \__\___/ \__, |\__, |_|\___|
#                |___/                             |___/ |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
WAYBAR_STATUS=$(state_get ".waybar.enabled")

if [ "$WAYBAR_STATUS" = "true" ] ;then
    state_set ".waybar.enabled" false
else
    state_set ".waybar.enabled" true
fi

"$DESKTOP_SCRIPTS/waybar/launch.sh" &
