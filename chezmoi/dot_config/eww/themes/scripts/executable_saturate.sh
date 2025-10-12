#!/usr/bin/env bash
#            _                   _
#  ___  __ _| |_ _   _ _ __ __ _| |_ ___
# / __|/ _` | __| | | | '__/ _` | __/ _ \
# \__ \ (_| | |_| |_| | | | (_| | ||  __/
# |___/\__,_|\__|\__,_|_|  \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CONFIG_FILE=$HOME/.local/state/desktop/state.json

# Maybe the saturation function should work even in focus mode but it would be a pain to implement for almost nothing.
if hyprctl getoption animations:enabled | grep -q "int: 0"; then
    dunstify "Focus mode activated, saturation disabled."
    exit
fi

SATURATION_VALUE=$1

WALLPAPER=$(cat $HOME/.cache/wallpaper/current_wallpaper)
wal -q -i $WALLPAPER --saturate $SATURATION_VALUE &
jq '.theme.saturation.enabled = true' $CONFIG_FILE | sponge $CONFIG_FILE
jq --argjson saturation_level "$SATURATION_VALUE" -r '.theme.saturation.level = $saturation_level' $CONFIG_FILE | sponge $CONFIG_FILE
ACCENT_COLOR_STATUS=$(jq '.theme.accent_color.enabled' $CONFIG_FILE)

if [ $ACCENT_COLOR_STATUS = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(jq -r '.theme.accent_color.hex' $CONFIG_FILE)
    COLOR_NB=$(jq -r '.theme.accent_color.index' $CONFIG_FILE)

    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB &
else
    $HOME/.config/hypr/scripts/theming/apply-theme.sh &
fi

# eww reload
# eww update saturation-value="$SATURATION_VALUE"
