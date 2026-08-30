#!/usr/bin/env bash
#  _                                               _            _        _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      ___| |_ __ _| |_ _   _ ___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____/ __| __/ _` | __| | | / __|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____\__ \ || (_| | |_| |_| \__ \
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |___/\__\__,_|\__|\__,_|___/
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE=$XDG_STATE_HOME/desktop/state.json
MANUAL_FILTER_ON=$(jq '.hyprsunset.filter_on' $STATE_FILE)
AUTOTIMER_STATE=$(jq '.hyprsunset.auto_timer' $STATE_FILE)

if $MANUAL_FILTER_ON; then
    echo '{"class": "filter_on"}'
else
    if $AUTOTIMER_STATE; then
        echo '{"class": "auto_timer"}'
    else
        echo '{"class": "filter_off"}'
    fi
fi
