#!/usr/bin/env bash
#               _ _       _           _   _
#  _____      _(_) |_ ___| |__       | |_| |__   ___ _ __ ___   ___
# / __\ \ /\ / / | __/ __| '_ \ _____| __| '_ \ / _ \ '_ ` _ \ / _ \
# \__ \\ V  V /| | || (__| | | |_____| |_| | | |  __/ | | | | |  __/
# |___/ \_/\_/ |_|\__\___|_| |_|      \__|_| |_|\___|_| |_| |_|\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
"$DESKTOP_SCRIPTS/system/setup-state.sh"

STATE_FILE="${XDG_STATE_HOME}/desktop/state.json"
THEME_TYPE=$(jq -r '.theme.mode' "$STATE_FILE")

if [ "$THEME_TYPE" = "dark" ]; then
    FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' "$STATE_FILE")
    if [ "$FOCUSMODE_ENABLED" = "true" ]; then
        dunstify "Game mode enabled, cannot switch to light theme"
        exit
    fi
    jq '.theme.mode = "light"' "$STATE_FILE" | sponge "$STATE_FILE"
else
    jq '.theme.mode = "dark"' "$STATE_FILE" | sponge "$STATE_FILE"
fi

ACCENT_COLOR_STATUS=$(jq '.theme.accent_color.enabled' "$STATE_FILE")

if [ "$ACCENT_COLOR_STATUS" = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(jq -r '.theme.accent_color.hex' "$STATE_FILE")
    COLOR_NB=$(jq -r '.theme.accent_color.index' "$STATE_FILE")

    "$DESKTOP_SCRIPTS/theming/apply-theme.sh" "$COLOR" "$COLOR_NB"
else
    "$DESKTOP_SCRIPTS/theming/apply-theme.sh"
fi
