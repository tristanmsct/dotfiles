#!/bin/bash
#                           _                  _
#   __ _  ___ ___ ___ _ __ | |_       ___ ___ | | ___  _ __
#  / _` |/ __/ __/ _ \ '_ \| __|____ / __/ _ \| |/ _ \| '__|
# | (_| | (_| (_|  __/ | | | ||_____| (_| (_) | | (_) | |
#  \__,_|\___\___\___|_| |_|\__|     \___\___/|_|\___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

COLORS=($(sed -n '2,9p' $HOME/.cache/wal/colors))

# Building a list of color option to chose from with the "human" name for each color because the script sometimes convert colors to unexpected Tela equivalent.
OPTIONS=""
i=1
for color in "${COLORS[@]}"; do
    read icons_color theme_color hex_color <<< $(python $HOME/.config/hypr/scripts/theming/convert_colors.py -c $color)
    OPTIONS+="$i - Accent Color <span foreground='$color'>󱓻</span>  with $icons_color <span foreground='$hex_color'>󱓻</span>  icons"
    OPTIONS+=$'\n'
    i=$((i+1))
done
OPTIONS=${OPTIONS::-1}

SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -config ~/.config/rofi/config-simple.rasi -markup-rows -l 8 -p "Select:")
COLOR=$(echo $SELECTED | awk -F'#' '{print "#" $2}' | cut -c 1-7)
COLOR_NB=$(echo $SELECTED | grep -o "^[0-9]")

if [[ $SELECTED != "" ]]; then
    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB

    # Accent colors are stored in a cache files to set them up again at restart.
    echo -e "$COLOR\n$COLOR_NB" > $HOME/.cache/accent-color
fi
