#!/usr/bin/env bash

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 0 ] ; then
    dunstify "Game mode activated, theming disabled."
    exit
fi

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open theme-menu-window-closer --screen $monitor_id
eww open theme-menu-window --screen $monitor_id
