#!/usr/bin/env bash
#                            _           _ _     _
#  ___  ___  _   _ _ __   __| |      ___| (_) __| | ___ _ __
# / __|/ _ \| | | | '_ \ / _` |_____/ __| | |/ _` |/ _ \ '__|
# \__ \ (_) | |_| | | | | (_| |_____\__ \ | | (_| |  __/ |
# |___/\___/ \__,_|_| |_|\__,_|     |___/_|_|\__,_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

if [ $monitor_id -eq 0 ]; then
    eww open sound-slider-window-closer --screen $monitor_id
    eww open sound-slider-window --screen $monitor_id
else
    eww open sound-slider-window-secondary-closer --screen $monitor_id
    eww open sound-slider-window-secondary --screen $monitor_id
fi
