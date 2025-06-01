#!/usr/bin/env bash
new_value=$1

# dunstify $new_value
CONFIG_FILE=$HOME/.config/hypr/conf/hyprsunset.json
manual_filter_on=$(jq '.filter_on' $CONFIG_FILE)

jq '.temperature ='$new_value $CONFIG_FILE | sponge $CONFIG_FILE

if [[ ($manual_filter_on = "true") ]]; then
    hyprctl hyprsunset temperature $new_value
fi
