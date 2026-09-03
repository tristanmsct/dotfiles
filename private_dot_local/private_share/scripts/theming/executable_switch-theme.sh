#!/usr/bin/env bash
#               _ _       _           _   _
#  _____      _(_) |_ ___| |__       | |_| |__   ___ _ __ ___   ___
# / __\ \ /\ / / | __/ __| '_ \ _____| __| '_ \ / _ \ '_ ` _ \ / _ \
# \__ \\ V  V /| | || (__| | | |_____| |_| | | |  __/ | | | | |  __/
# |___/ \_/\_/ |_|\__\___|_| |_|      \__|_| |_|\___|_| |_| |_|\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

THEME_TYPE=$(state_get ".theme.mode")
script_name=$(basename "$0")

if [ "$THEME_TYPE" = "dark" ]; then
    FOCUSMODE_ENABLED=$(state_get ".focusmode.enabled")
    if [ "$FOCUSMODE_ENABLED" = "true" ]; then
        dunstify "Game mode enabled, cannot switch to light theme"
        exit
    fi
    logger -t theming -p user.info "[$script_name] Switching to light theme"
    state_set ".theme.mode" "light"
else
    logger -t theming -p user.info "[$script_name] Switching to dark theme"
    state_set ".theme.mode" "dark"
fi

ACCENT_COLOR_STATUS=$(state_get ".theme.accent_color.enabled")

if [ "$ACCENT_COLOR_STATUS" = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(state_get ".theme.accent_color.hex")
    COLOR_NB=$(state_get ".theme.accent_color.index")

    "$DESKTOP_SCRIPTS/theming/apply-theme.sh" "$COLOR" "$COLOR_NB"
else
    "$DESKTOP_SCRIPTS/theming/apply-theme.sh"
fi
