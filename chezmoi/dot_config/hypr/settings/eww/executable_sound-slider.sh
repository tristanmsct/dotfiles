#!/usr/bin/env bash

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open sound-slider-window-closer --screen $monitor_id
eww open sound-slider-window --screen $monitor_id
