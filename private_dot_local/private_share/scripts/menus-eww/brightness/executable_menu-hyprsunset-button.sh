#!/usr/bin/env bash
#  _                                               _     _   _                       _           _   _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_  | |_(_)_ __ ___   ___ _ __  | |__  _   _| |_| |_ ___  _ __
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __| | __| | '_ ` _ \ / _ \ '__| | '_ \| | | | __| __/ _ \| '_ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ |_  | |_| | | | | | |  __/ |    | |_) | |_| | |_| || (_) | | | |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|  \__|_|_| |_| |_|\___|_|    |_.__/ \__,_|\__|\__\___/|_| |_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
FILTER_STATE=$(state_get ".hyprsunset.state")

if [[ $1 == "on" ]] && [[ $FILTER_STATE != "on" ]]; then
    "$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-switch.sh"
elif [[ $1 == "auto" ]] && [[ $FILTER_STATE != "auto" ]]; then
    state_set ".hyprsunset.state" "auto"
    "$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-timer.sh"
elif [[ $1 == "off" ]] && [[ $FILTER_STATE != "off" ]]; then
    "$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-switch.sh"
fi

# Help change waybar idicator faster.
pkill -RTMIN+8 waybar
