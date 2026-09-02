#!/usr/bin/env bash
#  _          _       _     _                                 _ _     _
# | |__  _ __(_) __ _| |__ | |_ _ __   ___  ___ ___       ___| (_) __| | ___ _ __
# | '_ \| '__| |/ _` | '_ \| __| '_ \ / _ \/ __/ __|_____/ __| | |/ _` |/ _ \ '__|
# | |_) | |  | | (_| | | | | |_| | | |  __/\__ \__ \_____\__ \ | | (_| |  __/ |
# |_.__/|_|  |_|\__, |_| |_|\__|_| |_|\___||___/___/     |___/_|_|\__,_|\___|_|
#               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
    monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')
    monitor_model=$(hyprctl monitors -j | jq -r --argjson id "$monitor_id" '.[] | select(.id == $id) | .model')
elif [[ $XDG_CURRENT_DESKTOP == "niri" ]]; then
    monitor_model=$(niri msg -j focused-output| jq -r ".model")
fi

eww open brightness-slider-window-closer --screen "$monitor_model"
eww open brightness-slider-window --screen "$monitor_model"
