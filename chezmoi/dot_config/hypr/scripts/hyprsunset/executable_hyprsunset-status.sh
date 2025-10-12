#!/usr/bin/env bash
#  _                                               _            _        _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      ___| |_ __ _| |_ _   _ ___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____/ __| __/ _` | __| | | / __|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____\__ \ || (_| | |_| |_| \__ \
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |___/\__\__,_|\__|\__,_|___/
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CONFIG_FILE=$HOME/.local/state/desktop/state.json
manual_filter_on=$(jq '.hyprsunset.filter_on' $CONFIG_FILE)
autotimer_state=$(jq '.hyprsunset.auto_timer' $CONFIG_FILE)

if [ $manual_filter_on = "true" ]; then
    echo '{"class": "filter_on"}'
else
    if [ $autotimer_state = "true" ]; then
        echo '{"class": "auto_timer"}'
    else
        echo '{"class": "filter_off"}'
    fi
fi
