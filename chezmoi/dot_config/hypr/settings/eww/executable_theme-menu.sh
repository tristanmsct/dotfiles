#!/usr/bin/env bash

# Reset saturation value from cache before opening.
CACHED_SAT=$([ -f ~/.cache/saturation ] && cat ~/.cache/saturation || echo 0.5)
eww update saturation-value="$CACHED_SAT"

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open theme-menu-window-closer --screen $monitor_id
eww open theme-menu-window --screen $monitor_id
