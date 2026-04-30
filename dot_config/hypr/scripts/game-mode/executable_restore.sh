#!/usr/bin/env bash
#                                                       _                      _
#   __ _  __ _ _ __ ___   ___       _ __ ___   ___   __| | ___   _ __ ___  ___| |_ ___  _ __ ___
#  / _` |/ _` | '_ ` _ \ / _ \_____| '_ ` _ \ / _ \ / _` |/ _ \ | '__/ _ \/ __| __/ _ \| '__/ _ \
# | (_| | (_| | | | | | |  __/_____| | | | | | (_) | (_| |  __/ | | |  __/\__ \ || (_) | | |  __/
#  \__, |\__,_|_| |_| |_|\___|     |_| |_| |_|\___/ \__,_|\___| |_|  \___||___/\__\___/|_|  \___|
#  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE=$HOME/.local/state/desktop/state.json
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)

if $FOCUSMODE_ENABLED; then
    # If focus mode is supposed to be enabled, we put the flag as false and run the script which will put it at true again.
    jq '.focusmode.enabled = false' $STATE_FILE | sponge $STATE_FILE

    $HOME/.config/hypr/scripts/game-mode/activate.sh quiet
fi
