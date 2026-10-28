#!/usr/bin/env bash
#               _ _       _           _                   _                                        _
#  _____      _(_) |_ ___| |__       | |__   ___  _ __ __| | ___ _ __ ___     __      ____ _ _   _| |__   __ _ _ __
# / __\ \ /\ / / | __/ __| '_ \ _____| '_ \ / _ \| '__/ _` |/ _ \ '__/ __|____\ \ /\ / / _` | | | | '_ \ / _` | '__|
# \__ \\ V  V /| | || (__| | | |_____| |_) | (_) | | | (_| |  __/ |  \__ \_____\ V  V / (_| | |_| | |_) | (_| | |
# |___/ \_/\_/ |_|\__\___|_| |_|     |_.__/ \___/|_|  \__,_|\___|_|  |___/      \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#                                                                                            |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

script_name=$(basename "$0")

if [ "$1" == true ]; then
    logger -t theming -p user.info "[$script_name] Disabling waybar borders"

    # Waybar
    sed -i -E "s/(border-accent-color) @accent-color;/\1 transparent;/" "$XDG_CONFIG_HOME/waybar/colors-waybar.css"

    state_set ".theme.border_waybar" false
else
    logger -t theming -p user.info "[$script_name] Enabling decoration borders"

    # Waybar
    sed -i -E "s/(border-accent-color) transparent;/\1 @accent-color;/" "$XDG_CONFIG_HOME/waybar/colors-waybar.css"

    state_set ".theme.border_waybar" true
fi
