#!/usr/bin/env bash
#  _                                               _            _        _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      ___| |_ __ _| |_ _   _ ___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____/ __| __/ _` | __| | | / __|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____\__ \ || (_| | |_| |_| \__ \
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |___/\__\__,_|\__|\__,_|___/
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
MANUAL_FILTER_ON=$(state_get ".hyprsunset.filter_on")
AUTOTIMER_STATE=$(state_get ".hyprsunset.auto_timer")

if $MANUAL_FILTER_ON; then
    echo '{"class": "filter_on"}'
else
    if $AUTOTIMER_STATE; then
        echo '{"class": "auto_timer"}'
    else
        echo '{"class": "filter_off"}'
    fi
fi
