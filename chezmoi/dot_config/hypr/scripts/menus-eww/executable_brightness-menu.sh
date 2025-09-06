#!/usr/bin/env bash

monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

eww open brightness-menu-window-closer --screen $monitor_id
eww open brightness-menu-window --screen $monitor_id
