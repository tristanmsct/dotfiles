#!/usr/bin/env bash
#  _                                               _     _   _                       _           _   _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_  | |_(_)_ __ ___   ___ _ __  | |__  _   _| |_| |_ ___  _ __
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __| | __| | '_ ` _ \ / _ \ '__| | '_ \| | | | __| __/ _ \| '_ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ |_  | |_| | | | | | |  __/ |    | |_) | |_| | |_| || (_) | | | |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|  \__|_|_| |_| |_|\___|_|    |_.__/ \__,_|\__|\__\___/|_| |_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
CONFIG_FILE=$HOME/.config/hypr/conf/hyprsunset.json
autotimer_state=$(jq '.auto_timer' $CONFIG_FILE)

if [[ $autotimer_state = "true" ]]; then
    # When turning off the auto timer, we restore the last known config.
    # It is a bit redundant because manual hyprsunset should have priority.
    jq '.auto_timer = false' $CONFIG_FILE | sponge $CONFIG_FILE
    $HOME/.config/hypr/scripts/hyprsunset/hyprsunset.sh restore
    dunstify "Hyprsunset auto-timer off"
elif [[ $autotimer_state = "false" ]]; then
    # If we activate the auto timer, then the script is run once to catch up.
    jq '.auto_timer = true' $CONFIG_FILE | sponge $CONFIG_FILE
    $HOME/.config/hypr/scripts/hyprsunset/hyprsunset-timer.sh
    dunstify "Hyprsunset auto-timer on"
fi
