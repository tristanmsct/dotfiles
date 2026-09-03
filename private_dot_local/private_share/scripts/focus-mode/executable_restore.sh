#!/usr/bin/env bash
#   __                                      _
#  / _| ___   ___ _   _ ___   _ __ ___  ___| |_ ___  _ __ ___
# | |_ / _ \ / __| | | / __| | '__/ _ \/ __| __/ _ \| '__/ _ \
# |  _| (_) | (__| |_| \__ \ | | |  __/\__ \ || (_) | | |  __/
# |_|  \___/ \___|\__,_|___/ |_|  \___||___/\__\___/|_|  \___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
FOCUSMODE_ENABLED=$(state_get ".focusmode.enabled")
script_name=$(basename "$0")

if $FOCUSMODE_ENABLED; then
    # If focus mode is supposed to be enabled, we put the flag as false and run the script which will put it at true again.
    logger -t focusmode -p user.info "[$script_name] Restoring focus mode"

    state_set ".focusmode.enabled" false

    "$DESKTOP_SCRIPTS/focus-mode/activate.sh" quiet
fi
