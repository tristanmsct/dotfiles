#!/usr/bin/env bash
#  _                                               _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ |_
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Simple switch. Turn on hyprsunset if it is off, off if it is on.
# -----------------------------------------------------------------------------------------------------------------------------------------

# I can't find a clean way to get hyprsunset state from hyprctl yet, maybe in the future.
# I can only fetch the current temperature.
# What is missing is a way to know if the temperature is overwritten by "identity".
source "$DESKTOP_SCRIPTS/system/state-utils"
MANUAL_FILTER_ON=$(state_get ".hyprsunset.filter_on")
AUTOTIMER_STATE=$(state_get ".hyprsunset.auto_timer")
script_name=$(basename "$0")

pgrep -x hyprsunset >/dev/null || hyprsunset -i &

if [[ "$1" = "restore" ]]; then
    # When rebooting, or restarting the session, we can restore the current hyprsunset state.
    logger -t hyprsunset -p user.info "[$script_name] Restoring hyprsunset config"
    if [[ "$MANUAL_FILTER_ON" == "true" ]]; then
        temperature=$(state_get ".hyprsunset.temperature")
        hyprctl hyprsunset temperature "$temperature"
        logger -t hyprsunset -p user.info "[$script_name] Restoring manual hyprsunset"
    elif [[ "$AUTOTIMER_STATE" == "true" ]]; then
        "$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-timer.sh"
        logger -t hyprsunset -p user.info "[$script_name] Restoring auto hyprsunset"
    else
        hyprctl hyprsunset identity
    fi
elif [[ "$MANUAL_FILTER_ON" == "true" ]]; then
    # The filter_on variable need to be changed before the hyprsunset-timer.sh call otherwise the
    # other script will not get past the first check.
    # The goal is to deactivate the manual hyprsunset so if the timer was supposed to be on then we call it, to restore it.
    state_set ".hyprsunset.filter_on" false
    if [[ "$AUTOTIMER_STATE" == "true" ]]; then
        "$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-timer.sh"
        logger -t hyprsunset -p user.info "[$script_name] Stopping manual hyprsunset, timer resumed"

    else
        logger -t hyprsunset -p user.info "[$script_name] Hyprsunset stopped"
        hyprctl hyprsunset identity
    fi
else
    state_set ".hyprsunset.filter_on" true
    temperature=$(state_get ".hyprsunset.temperature")
    hyprctl hyprsunset temperature "$temperature"
    logger -t hyprsunset -p user.info "[$script_name] Hyprsunset started with temperature $temperature"
fi

# Update waybar icon config.
pkill -RTMIN+8 waybar
