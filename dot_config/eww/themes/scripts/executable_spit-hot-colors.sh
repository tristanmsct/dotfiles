#!/usr/bin/env bash
#            _ _        _           _                  _
#  ___ _ __ (_) |_     | |__   ___ | |_       ___ ___ | | ___  _ __ ___
# / __| '_ \| | __|____| '_ \ / _ \| __|____ / __/ _ \| |/ _ \| '__/ __|
# \__ \ |_) | | ||_____| | | | (_) | ||_____| (_| (_) | | (_) | |  \__ \
# |___/ .__/|_|\__|    |_| |_|\___/ \__|     \___\___/|_|\___/|_|  |___/
#     |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

COLORS_WALLUST=($(sed -n '1,8p' $HOME/.local/state/desktop/colors))

# Building a list of color option to chose from with the "human" name for each color
# because the script sometimes convert colors to unexpected Tela equivalent.
OPTIONS="["
i=1
for color in "${COLORS_WALLUST[@]}"; do
    read icons_color theme_color hex_color <<< $(python $HOME/.config/hypr/scripts/theming/convert_colors.py -c $color)
    OPTIONS+="\"$i - Accent Color <span foreground='$color'>󱓻 </span> with $icons_color <span foreground='$hex_color'>󱓻 </span> icons\", "
    OPTIONS+=$'\n'
    i=$((i+1))
done
OPTIONS=${OPTIONS::-3}
OPTIONS+="]"

echo $OPTIONS
