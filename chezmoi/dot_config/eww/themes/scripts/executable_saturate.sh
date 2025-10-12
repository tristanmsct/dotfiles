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

WALLPAPER=$(cat $HOME/.cache/wallpaper/current_wallpaper)
wal -q -i $WALLPAPER --saturate $1 &
jq '.theme.saturation.enabled = true' $CONFIG_FILE | sponge $CONFIG_FILE
jq --argjson saturation_level "$1" -r '.theme.saturation.level = $saturation_level' $CONFIG_FILE | sponge $CONFIG_FILE

if [ -f $HOME/.cache/accent-color ]; then
    # If there was accent colors cached, then we re-apply them.
    read -r COLOR < ~/.cache/accent-color
    read -r COLOR_NB < <(sed -n '2p' ~/.cache/accent-color)

    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB &
else
    $HOME/.config/hypr/scripts/theming/apply-theme.sh &
fi
