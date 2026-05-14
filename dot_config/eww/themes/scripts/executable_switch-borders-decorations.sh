#!/usr/bin/env bash
#               _ _       _           _                   _                         _                          _   _
#  _____      _(_) |_ ___| |__       | |__   ___  _ __ __| | ___ _ __ ___        __| | ___  ___ ___  _ __ __ _| |_(_) ___  _ __  ___
# / __\ \ /\ / / | __/ __| '_ \ _____| '_ \ / _ \| '__/ _` |/ _ \ '__/ __|_____ / _` |/ _ \/ __/ _ \| '__/ _` | __| |/ _ \| '_ \/ __|
# \__ \\ V  V /| | || (__| | | |_____| |_) | (_) | | | (_| |  __/ |  \__ \_____| (_| |  __/ (_| (_) | | | (_| | |_| | (_) | | | \__ \
# |___/ \_/\_/ |_|\__\___|_| |_|     |_.__/ \___/|_|  \__,_|\___|_|  |___/      \__,_|\___|\___\___/|_|  \__,_|\__|_|\___/|_| |_|___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE=$HOME/.local/state/desktop/state.json
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)

if [ $1 == true ]; then
    if ! $FOCUSMODE_ENABLED; then
        # Waybar border disabled in focus mode.
        sed -i -E "s/(border-color) @accent-color;/\1 rgba\(0, 0, 0, 0\);/" $HOME/.cache/wal/colors-waybar.css
    fi

    # Waypaper
    sed -i -E "s/(border-color) @accent-color;/\1 rgba\(0, 0, 0, 0\);/" $HOME/.cache/wal/colors-waypaper.css

    # Eww
    sed -i -E "s/(border-theme:) 2px/\1 0px/" $HOME/.config/eww/eww.scss

    # Rofi
    sed -i -E "s/(border-width:\s*) 0.2%/\1 0%/" $HOME/.config/rofi/config-base.rasi

    # NWG
    sed -i -E "s/(border:) 2px/\1 0px/" $HOME/.config/nwg-drawer/drawer.css
    sed -i -E "s/(border:) 2px/\1 0px/" $HOME/.config/nwg-panel/menu-start.css

    # Dunst is excluded because it just looks weird without borders
else
    if ! $FOCUSMODE_ENABLED; then
        # Waybar border disabled in focus mode.
        sed -i -E "s/(border-color) rgba\(0, 0, 0, 0\);/\1 @accent-color;/" $HOME/.cache/wal/colors-waybar.css
    fi

    # Waypaper
    sed -i -E "s/(border-color) rgba\(0, 0, 0, 0\);/\1 @accent-color;/" $HOME/.cache/wal/colors-waypaper.css

    # Eww
    sed -i -E "s/(border-theme:) 0px/\1 2px/" $HOME/.config/eww/eww.scss

    # Rofi
    sed -i -E "s/(border-width:\s*) 0%/\1 0.2%/" $HOME/.config/rofi/config-base.rasi

    # NWG
    sed -i -E "s/(border:) 0px/\1 2px/" $HOME/.config/nwg-drawer/drawer.css
    sed -i -E "s/(border:) 0px/\1 2px/" $HOME/.config/nwg-panel/menu-start.css
fi
