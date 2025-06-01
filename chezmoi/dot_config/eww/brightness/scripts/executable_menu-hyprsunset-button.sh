#!/usr/bin/env bash
CONFIG_FILE=$HOME/.config/hypr/conf/hyprsunset.json
manual_filter_on=$(jq '.filter_on' $CONFIG_FILE)
temperature=$(jq '.temperature' $CONFIG_FILE)

if [[ ($manual_filter_on = "true") ]]; then
    jq '.filter_on = false' $CONFIG_FILE | sponge $CONFIG_FILE
    hyprctl hyprsunset identity
else
    jq '.filter_on = true' $CONFIG_FILE | sponge $CONFIG_FILE
    hyprctl hyprsunset temperature $temperature
fi
