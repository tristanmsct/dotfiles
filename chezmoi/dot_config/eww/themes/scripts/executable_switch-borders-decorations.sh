#!/usr/bin/env bash
#               _ _       _           _                   _                         _                          _   _
#  _____      _(_) |_ ___| |__       | |__   ___  _ __ __| | ___ _ __ ___        __| | ___  ___ ___  _ __ __ _| |_(_) ___  _ __  ___
# / __\ \ /\ / / | __/ __| '_ \ _____| '_ \ / _ \| '__/ _` |/ _ \ '__/ __|_____ / _` |/ _ \/ __/ _ \| '__/ _` | __| |/ _ \| '_ \/ __|
# \__ \\ V  V /| | || (__| | | |_____| |_) | (_) | | | (_| |  __/ |  \__ \_____| (_| |  __/ (_| (_) | | | (_| | |_| | (_) | | | \__ \
# |___/ \_/\_/ |_|\__\___|_| |_|     |_.__/ \___/|_|  \__,_|\___|_|  |___/      \__,_|\___|\___\___/|_|  \__,_|\__|_|\___/|_| |_|___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

if [ $1 == true ]; then
    # Waybar
    sed -i -E "s/(border: 2px solid) @accent-color;/\1 rgba(0,0,0,0);/" $HOME/.config/waybar/style.css

    # Eww
    sed -i -E "s/(border-theme:) 2px/\1 0px/" $HOME/.config/eww/eww.scss

    # Rofi
    sed -i -E "s/(border-width:\s*) 0.2%/\1 0%/" $HOME/.config/rofi/config-base.rasi

    # NWG
    sed -i -E "s/(border:) 2px/\1 0px/" $HOME/.config/nwg-drawer/drawer.css
    sed -i -E "s/(border:) 2px/\1 0px/" $HOME/.config/nwg-panel/menu-start.css

    # Dunst is excluded because it just looks weird without borders
    # sed -i -E "s/( frame_width =) 2/\1 0/" $HOME/.config/dunst/dunstrc
    # sed -i -E "s/( frame_width =) 2/\1 0/" $HOME/.config/dunst/dunstrc.tpl
else
    # Waybar
    sed -i -E "s/(border: 2px solid) rgba\(0,0,0,0\);/\1 @accent-color;/" $HOME/.config/waybar/style.css

    # Eww
    sed -i -E "s/(border-theme:) 0px/\1 2px/" $HOME/.config/eww/eww.scss

    # Rofi
    sed -i -E "s/(border-width:\s*) 0%/\1 0.2%/" $HOME/.config/rofi/config-base.rasi

    # NWG
    sed -i -E "s/(border:) 0px/\1 2px/" $HOME/.config/nwg-drawer/drawer.css
    sed -i -E "s/(border:) 0px/\1 2px/" $HOME/.config/nwg-panel/menu-start.css

    # sed -i -E "s/( frame_width =) 0/\1 2/" $HOME/.config/dunst/dunstrc
    # sed -i -E "s/( frame_width =) 0/\1 2/" $HOME/.config/dunst/dunstrc.tpl
fi

# pkill dunst
# dunstctl reload
