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
CONFIG_FILE=$HOME/.local/state/desktop/state.json
hyprsunset_state=$(jq '.hyprsunset.filter_on' $CONFIG_FILE)
autotimer_state=$(jq '.hyprsunset.auto_timer' $CONFIG_FILE)

pgrep -x hyprsunset >/dev/null || hyprsunset -i &

logger -t hyprsunset-base "Starting hyprsunset script"

if [[ $1 = "restore" ]]; then
    # When rebooting, or restarting the session, we can restore the current hyprsunset state.
    logger -t hyprsunset-base "Restoring hyprsunset config"
    if [[ $hyprsunset_state = "true" ]]; then
        temperature=$(jq '.hyprsunset.temperature' $CONFIG_FILE)
        hyprctl hyprsunset temperature $temperature
        logger -t hyprsunset-base "Restoring manual hyprsunset"
        dunstify "Restoring hyprsunset with temperature $temperature"
    elif [[ $autotimer_state = "true" ]]; then
        $HOME/.config/hypr/scripts/hyprsunset/hyprsunset-timer.sh
        logger -t hyprsunset-base "Restoring auto hyprsunset"
        dunstify "Restoring hyprsunset timer"
    else
        hyprctl hyprsunset identity
    fi
elif [[ $hyprsunset_state = "true" ]]; then
    # The filter_on variable need to be changed before the hyprsunset-timer.sh call otherwise the
    # other script will not get past the first check.
    # The goal is to deactivate the manual hyprsunset so if the timer was supposed to be on then we call it, to restore it.
    jq '.hyprsunset.filter_on = false' $CONFIG_FILE | sponge $CONFIG_FILE
    if [[ $autotimer_state = "true" ]]; then
        $HOME/.config/hypr/scripts/hyprsunset/hyprsunset-timer.sh
        logger -t hyprsunset-base "Stopping manual hyprsunset, timer resumed"
        dunstify "Stopping manual hyprsunset, timer resumed"
    else
        logger -t hyprsunset-base "Hyprsunset stopped"
        hyprctl hyprsunset identity
        dunstify "Hyprsunset stopped"
    fi
else
    jq '.hyprsunset.filter_on = true' $CONFIG_FILE | sponge $CONFIG_FILE
    temperature=$(jq '.hyprsunset.temperature' $CONFIG_FILE)
    hyprctl hyprsunset temperature $temperature
    logger -t hyprsunset-base "Hyprsunset started with temperature $temperature"
    dunstify "Hyprsunset started with temperature $temperature"
fi

# Update waybar icon config.
pkill -RTMIN+8 waybar
