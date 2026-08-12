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
        sed -i -E "s/(border-accent-color) @accent-color;/\1 transparent;/" $HOME/.config/waybar/colors-waybar.css
    fi

    # Waypaper
    sed -i -E "s/(border-accent-color) @accent-color;/\1 transparent;/" $HOME/.config/waypaper/colors-waypaper.css

    # Eww
    sed -i -E "s/(border-accent-color:) \\\$accent-color/\1 transparent/" $HOME/.config/eww/colors-eww.scss

    # Rofi
    sed -i -E "s/(border-accent-color:) @accent-color/\1 transparent/" $HOME/.config/rofi/colors-rofi.rasi

    # NWG
    sed -i -E "s/(border-accent-color) @accent-color/\1 transparent/" $HOME/.config/nwg-drawer/colors-nwg.css
    sed -i -E "s/(border-accent-color) @accent-color/\1 transparent/" $HOME/.config/nwg-panel/colors-nwg.css

    # Dunst is excluded because it just looks weird without borders

    jq '.theme.border_decorations = false' $STATE_FILE | sponge $STATE_FILE
else
    if ! $FOCUSMODE_ENABLED; then
        # Waybar border disabled in focus mode.
        sed -i -E "s/(border-accent-color) transparent;/\1 @accent-color;/" $HOME/.config/waybar/colors-waybar.css
    fi

    # Waypaper
    sed -i -E "s/(border-accent-color) transparent;/\1 @accent-color;/" $HOME/.config/waypaper/colors-waypaper.css

    # Eww
    sed -i -E "s/(border-accent-color:) transparent/\1 \\\$accent-color/" $HOME/.config/eww/colors-eww.scss

    # Rofi
    sed -i -E "s/(border-accent-color:) transparent/\1 @accent-color/" $HOME/.config/rofi/colors-rofi.rasi

    # NWG
    sed -i -E "s/(border-accent-color) transparent/\1 @accent-color/" $HOME/.config/nwg-drawer/colors-nwg.css
    sed -i -E "s/(border-accent-color) transparent/\1 @accent-color/" $HOME/.config/nwg-panel/colors-nwg.css

    jq '.theme.border_decorations = true' $STATE_FILE | sponge $STATE_FILE
fi
