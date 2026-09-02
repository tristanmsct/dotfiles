#!/usr/bin/env bash
#  _   _
# | |_| |__   ___ _ __ ___   ___       _ __ ___   ___ _ __  _   _
# | __| '_ \ / _ \ '_ ` _ \ / _ \_____| '_ ` _ \ / _ \ '_ \| | | |
# | |_| | | |  __/ | | | | |  __/_____| | | | | |  __/ | | | |_| |
#  \__|_| |_|\___|_| |_| |_|\___|     |_| |_| |_|\___|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
SATURATE_STATE=$(state_get ".theme.saturation.enabled")

# Reset saturation value from cache before opening.
if [ "$SATURATE_STATE" = "true" ]; then
    CACHED_SAT=$(state_get ".theme.saturation.level" | awk '{print $1 / 100}')
else
    CACHED_SAT=0.5
fi

eww update saturation-value="$CACHED_SAT"

if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
    monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')
    monitor_model=$(hyprctl monitors -j | jq -r --argjson id "$monitor_id" '.[] | select(.id == $id) | .model')
elif [[ $XDG_CURRENT_DESKTOP == "niri" ]]; then
    monitor_model=$(niri msg -j focused-output| jq -r ".model")
fi

eww open theme-menu-window-closer --screen "$monitor_model"
eww open theme-menu-window --screen "$monitor_model"
