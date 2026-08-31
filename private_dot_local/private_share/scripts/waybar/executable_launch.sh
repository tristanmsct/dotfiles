#!/usr/bin/env bash
#                      _                  _                        _
# __      ____ _ _   _| |__   __ _ _ __  | | __ _ _   _ _ __   ___| |__
# \ \ /\ / / _` | | | | '_ \ / _` | '__| | |/ _` | | | | '_ \ / __| '_ \
#  \ V  V / (_| | |_| | |_) | (_| | |    | | (_| | |_| | | | | (__| | | |
#   \_/\_/ \__,_|\__, |_.__/ \__,_|_|    |_|\__,_|\__,_|_| |_|\___|_| |_|
#                |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
"$DESKTOP_SCRIPTS/system/setup-state.sh"

STATE_FILE=$XDG_STATE_HOME/desktop/state.json
WAYBAR_STATUS=$(jq '.waybar.enabled' "$STATE_FILE")

# Restart waybar.
if [ "$WAYBAR_STATUS" = "true" ] ;then
    # Quit all running waybar instances as a precaution.
    pkill waybar
    sleep 0.5

    waybar -c "$XDG_CONFIG_HOME/waybar/config.jsonc" -s "$XDG_CONFIG_HOME/waybar/style.css" &
fi
