#!/usr/bin/env bash

CONFIG_FILE=$HOME/.config/hypr/conf/hyprsunset.json
manual_filter_on=$(jq '.filter_on' $CONFIG_FILE)
autotimer_state=$(jq '.auto_timer' $CONFIG_FILE)

if [ $manual_filter_on = "true" ]; then
    echo '{"class": "filter_on"}'
else
    if [ $autotimer_state = "true" ]; then
        echo '{"class": "auto_timer"}'
    else
        echo '{"class": "filter_off"}'
    fi
fi
