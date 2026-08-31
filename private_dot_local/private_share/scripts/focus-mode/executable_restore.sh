#!/usr/bin/env bash
#   __                                      _
#  / _| ___   ___ _   _ ___   _ __ ___  ___| |_ ___  _ __ ___
# | |_ / _ \ / __| | | / __| | '__/ _ \/ __| __/ _ \| '__/ _ \
# |  _| (_) | (__| |_| \__ \ | | |  __/\__ \ || (_) | | |  __/
# |_|  \___/ \___|\__,_|___/ |_|  \___||___/\__\___/|_|  \___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE="$XDG_STATE_HOME/desktop/state.json"
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' "$STATE_FILE")

if $FOCUSMODE_ENABLED; then
    # If focus mode is supposed to be enabled, we put the flag as false and run the script which will put it at true again.
    jq '.focusmode.enabled = false' "$STATE_FILE" | sponge "$STATE_FILE"

    "$DESKTOP_SCRIPTS/focus-mode/activate.sh" quiet
fi
