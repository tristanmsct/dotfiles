#!/usr/bin/env bash
#               _ _       _           _                   _                         _                          _   _
#  _____      _(_) |_ ___| |__       | |__   ___  _ __ __| | ___ _ __ ___        __| | ___  ___ ___  _ __ __ _| |_(_) ___  _ __  ___
# / __\ \ /\ / / | __/ __| '_ \ _____| '_ \ / _ \| '__/ _` |/ _ \ '__/ __|_____ / _` |/ _ \/ __/ _ \| '__/ _` | __| |/ _ \| '_ \/ __|
# \__ \\ V  V /| | || (__| | | |_____| |_) | (_) | | | (_| |  __/ |  \__ \_____| (_| |  __/ (_| (_) | | | (_| | |_| | (_) | | | \__ \
# |___/ \_/\_/ |_|\__\___|_| |_|     |_.__/ \___/|_|  \__,_|\___|_|  |___/      \__,_|\___|\___\___/|_|  \__,_|\__|_|\___/|_| |_|___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

script_name=$(basename "$0")

FOCUSMODE_ENABLED=$(state_get ".focusmode.enabled")

if [ "$1" == true ]; then
    logger -t theming -p user.info "[$script_name] Disabling decoration borders"

    if ! $FOCUSMODE_ENABLED; then
        # Waybar border disabled in focus mode.
        sed -i -E "s/(border-accent-color) @accent-color;/\1 transparent;/" "$XDG_CONFIG_HOME/waybar/colors-waybar.css"
    fi

    # Waypaper
    sed -i -E "s/(border-accent-color) @accent-color;/\1 transparent;/" "$XDG_CONFIG_HOME/waypaper/colors-waypaper.css"

    # Eww
    sed -i -E "s/(border-accent-color:) \\\$accent-color/\1 transparent/" "$XDG_CONFIG_HOME/eww/colors-eww.scss"

    # Rofi
    sed -i -E "s/(border-accent-color:) @accent-color/\1 transparent/" "$XDG_CONFIG_HOME/rofi/colors-rofi.rasi"

    # NWG
    sed -i -E "s/(border-accent-color) @accent-color/\1 transparent/" "$XDG_CONFIG_HOME/nwg-drawer/colors-nwg.css"
    sed -i -E "s/(border-accent-color) @accent-color/\1 transparent/" "$XDG_CONFIG_HOME/nwg-panel/colors-nwg.css"

    # Dunst is excluded because it just looks weird without borders

    state_set ".theme.border_decorations" false
else
    logger -t theming -p user.info "[$script_name] Enabling decoration borders"

    if ! $FOCUSMODE_ENABLED; then
        # Waybar border disabled in focus mode.
        sed -i -E "s/(border-accent-color) transparent;/\1 @accent-color;/" "$XDG_CONFIG_HOME/waybar/colors-waybar.css"
    fi

    # Waypaper
    sed -i -E "s/(border-accent-color) transparent;/\1 @accent-color;/" "$XDG_CONFIG_HOME/waypaper/colors-waypaper.css"

    # Eww
    sed -i -E "s/(border-accent-color:) transparent/\1 \\\$accent-color/" "$XDG_CONFIG_HOME/eww/colors-eww.scss"

    # Rofi
    sed -i -E "s/(border-accent-color:) transparent/\1 @accent-color/" "$XDG_CONFIG_HOME/rofi/colors-rofi.rasi"

    # NWG
    sed -i -E "s/(border-accent-color) transparent/\1 @accent-color/" "$XDG_CONFIG_HOME/nwg-drawer/colors-nwg.css"
    sed -i -E "s/(border-accent-color) transparent/\1 @accent-color/" "$XDG_CONFIG_HOME/nwg-panel/colors-nwg.css"

    state_set ".theme.border_decorations" true
fi
