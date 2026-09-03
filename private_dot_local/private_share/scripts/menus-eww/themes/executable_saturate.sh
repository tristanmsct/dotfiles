#!/usr/bin/env bash
#            _                   _
#  ___  __ _| |_ _   _ _ __ __ _| |_ ___
# / __|/ _` | __| | | | '__/ _` | __/ _ \
# \__ \ (_| | |_| |_| | | | (_| | ||  __/
# |___/\__,_|\__|\__,_|_|  \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

script_name=$(basename "$0")

logger -t theming -p user.info "[$script_name] Generating a new palette with $1 saturation"

# Maybe the saturation function should work even in focus mode but it would be a pain to implement for almost nothing.
if hyprctl getoption animations:enabled | grep -q "int: 0"; then
    dunstify "Focus mode activated, saturation disabled."
    exit
fi

SATURATION_VALUE=$(awk "BEGIN {printf \"%d\", $1 * 100}")

WALLPAPER=$(cat "$XDG_STATE_HOME/desktop/wallpaper")
wallust run "$WALLPAPER" --skip-sequences -q --saturation "$SATURATION_VALUE" &

state_set ".theme.saturation.enabled" true
state_set ".theme.saturation.level" "$SATURATION_VALUE"
ACCENT_COLOR_STATUS=$(state_get ".theme.accent_color.enabled")

if [ "$ACCENT_COLOR_STATUS" = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(state_get ".theme.accent_color.hex")
    COLOR_NB=$(state_get ".theme.accent_color.index")

    "$DESKTOP_SCRIPTS/theming/apply-theme.sh" "$COLOR" "$COLOR_NB" &
else
    "$DESKTOP_SCRIPTS/theming/apply-theme.sh" &
fi
