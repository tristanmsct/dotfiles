#!/usr/bin/env bash
#  _____                 _       __        __          _
# |_   _|__   __ _  __ _| | ___  \ \      / /_ _ _   _| |__   __ _ _ __
#   | |/ _ \ / _` |/ _` | |/ _ \  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#   | | (_) | (_| | (_| | |  __/   \ V  V / (_| | |_| | |_) | (_| | |
#   |_|\___/ \__, |\__, |_|\___|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#            |___/ |___/                         |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

CONFIG_FILE=$XDG_STATE_HOME/desktop/state.json
WAYBAR_STATUS=$(jq '.waybar.enabled' $CONFIG_FILE)


if [ $WAYBAR_STATUS = "true" ] ;then
    jq '.waybar.enabled = false' $CONFIG_FILE | sponge $CONFIG_FILE
else
    jq '.waybar.enabled = true' $CONFIG_FILE | sponge $CONFIG_FILE
fi

~/.config/hypr/scripts/waybar/launch.sh &
