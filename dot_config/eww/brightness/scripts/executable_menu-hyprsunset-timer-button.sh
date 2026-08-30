#!/usr/bin/env bash
#  _                                               _     _   _                       _           _   _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_  | |_(_)_ __ ___   ___ _ __  | |__  _   _| |_| |_ ___  _ __
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __| | __| | '_ ` _ \ / _ \ '__| | '_ \| | | | __| __/ _ \| '_ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ |_  | |_| | | | | | |  __/ |    | |_) | |_| | |_| || (_) | | | |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|  \__|_|_| |_| |_|\___|_|    |_.__/ \__,_|\__|\__\___/|_| |_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Set up state file if necessary.
$DESKTOP_SCRIPTS/system/setup-state.sh

STATE_FILE=$XDG_STATE_HOME/desktop/state.json
AUTOTIMER_STATE=$(jq '.hyprsunset.auto_timer' $STATE_FILE)

if $AUTOTIMER_STATE; then
    # When turning off the auto timer, we restore the last known config.
    # It is a bit redundant because manual hyprsunset should have priority.
    jq '.hyprsunset.auto_timer = false' $STATE_FILE | sponge $STATE_FILE
    $DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset.sh restore
    dunstify "Hyprsunset auto-timer off"
elif ! $AUTOTIMER_STATE; then
    # If we activate the auto timer, then the script is run once to catch up.
    jq '.hyprsunset.auto_timer = true' $STATE_FILE | sponge $STATE_FILE
    $DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-timer.sh
    dunstify "Hyprsunset auto-timer on"
fi
