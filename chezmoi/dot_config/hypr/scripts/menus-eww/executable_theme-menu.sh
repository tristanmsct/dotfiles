#!/usr/bin/env bash

CONFIG_FILE=$HOME/.local/state/desktop/state.json
SATURATE_STATE=$(jq '.theme.saturation.enabled' $CONFIG_FILE)


# Reset saturation value from cache before opening.
if [ $SATURATE_STATE = "true" ]; then
    CACHED_SAT=$(jq '.theme.saturation.level' $CONFIG_FILE)
else
    CACHED_SAT=0.5
fi

eww update saturation-value="$CACHED_SAT"

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open theme-menu-window-closer --screen $monitor_id
eww open theme-menu-window --screen $monitor_id
