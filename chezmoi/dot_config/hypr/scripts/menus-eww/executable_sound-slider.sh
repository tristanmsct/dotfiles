#!/usr/bin/env bash

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

if [ $monitor_id -eq 0 ]; then
    eww open sound-slider-window-closer --screen $monitor_id
    eww open sound-slider-window --screen $monitor_id
else
    eww open sound-slider-window-secondary-closer --screen $monitor_id
    eww open sound-slider-window-secondary --screen $monitor_id
fi
