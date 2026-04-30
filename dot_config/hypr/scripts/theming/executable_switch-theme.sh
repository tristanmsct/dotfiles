#!/usr/bin/env bash
#  ____          _ _       _       _____ _
# / ___|_      _(_) |_ ___| |__   |_   _| |__   ___ _ __ ___   ___
# \___ \ \ /\ / / | __/ __| '_ \    | | | '_ \ / _ \ '_ ` _ \ / _ \
#  ___) \ V  V /| | || (__| | | |   | | | | | |  __/ | | | | |  __/
# |____/ \_/\_/ |_|\__\___|_| |_|   |_| |_| |_|\___|_| |_| |_|\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

STATE_FILE=$HOME/.local/state/desktop/state.json
THEME_TYPE=$(jq -r '.theme.mode' $STATE_FILE)

if [ $THEME_TYPE = "dark" ]; then

    FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)
    if $FOCUSMODE_ENABLED; then
        dunstify "Game mode enabled, cannot switch to light theme"
        exit
    fi
    jq '.theme.mode = "light"' $STATE_FILE | sponge $STATE_FILE
else
    jq '.theme.mode = "dark"' $STATE_FILE | sponge $STATE_FILE
fi

ACCENT_COLOR_STATUS=$(jq '.theme.accent_color.enabled' $STATE_FILE)

if [ $ACCENT_COLOR_STATUS = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(jq -r '.theme.accent_color.hex' $STATE_FILE)
    COLOR_NB=$(jq -r '.theme.accent_color.index' $STATE_FILE)

    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB
else
    $HOME/.config/hypr/scripts/theming/apply-theme.sh
fi
