#!/usr/bin/env bash

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open theme-menu-window-closer --screen $monitor_id
eww open theme-menu-window --screen $monitor_id
