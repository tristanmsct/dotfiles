#!/usr/bin/env bash

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open brightness-slider-window-closer --screen $monitor_id
eww open --debug brightness-slider-window --screen $monitor_id
