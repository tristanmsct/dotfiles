#!/usr/bin/env bash
#            _                   _
#  ___  __ _| |_ _   _ _ __ __ _| |_ ___
# / __|/ _` | __| | | | '__/ _` | __/ _ \
# \__ \ (_| | |_| |_| | | | (_| | ||  __/
# |___/\__,_|\__|\__,_|_|  \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$DESKTOP_SCRIPTS/system/setup-state.sh

STATE_FILE=$XDG_STATE_HOME/desktop/state.json

# Maybe the saturation function should work even in focus mode but it would be a pain to implement for almost nothing.
if hyprctl getoption animations:enabled | grep -q "int: 0"; then
    dunstify "Focus mode activated, saturation disabled."
    exit
fi

SATURATION_VALUE=$(awk "BEGIN {printf \"%d\", $1 * 100}")

WALLPAPER=$(cat $XDG_STATE_HOME/desktop/wallpaper)
wallust run $WALLPAPER --skip-sequences -q --saturation $SATURATION_VALUE &

jq '.theme.saturation.enabled = true' $STATE_FILE | sponge $STATE_FILE
jq --argjson saturation_level "$SATURATION_VALUE" -r '.theme.saturation.level = $saturation_level' $STATE_FILE | sponge $STATE_FILE
ACCENT_COLOR_STATUS=$(jq '.theme.accent_color.enabled' $STATE_FILE)

if [ $ACCENT_COLOR_STATUS = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(jq -r '.theme.accent_color.hex' $STATE_FILE)
    COLOR_NB=$(jq -r '.theme.accent_color.index' $STATE_FILE)

    $DESKTOP_SCRIPTS/theming/apply-theme.sh $COLOR $COLOR_NB &
else
    $DESKTOP_SCRIPTS/theming/apply-theme.sh &
fi
