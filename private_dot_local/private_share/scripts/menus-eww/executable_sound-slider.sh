#!/usr/bin/env bash
#                            _           _ _     _
#  ___  ___  _   _ _ __   __| |      ___| (_) __| | ___ _ __
# / __|/ _ \| | | | '_ \ / _` |_____/ __| | |/ _` |/ _ \ '__|
# \__ \ (_) | |_| | | | | (_| |_____\__ \ | | (_| |  __/ |
# |___/\___/ \__,_|_| |_|\__,_|     |___/_|_|\__,_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# TODO : niri needs a monitor_id there.
if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
    monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')
    monitor_model=$(hyprctl monitors -j | jq -r --argjson id "$monitor_id" '.[] | select(.id == $id) | .model')
elif [[ $XDG_CURRENT_DESKTOP == "niri" ]]; then
    monitor_model=$(niri msg -j focused-output| jq -r ".model")
fi

if [ $monitor_id -eq 0 ]; then
    eww open sound-slider-window-closer --screen $monitor_model
    eww open sound-slider-window --screen $monitor_model
else
    eww open sound-slider-window-secondary-closer --screen $monitor_model
    eww open sound-slider-window-secondary --screen $monitor_model
fi
