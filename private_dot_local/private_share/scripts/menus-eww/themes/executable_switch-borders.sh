#!/usr/bin/env bash
#               _ _       _           _                   _
#  _____      _(_) |_ ___| |__       | |__   ___  _ __ __| | ___ _ __ ___
# / __\ \ /\ / / | __/ __| '_ \ _____| '_ \ / _ \| '__/ _` |/ _ \ '__/ __|
# \__ \\ V  V /| | || (__| | | |_____| |_) | (_) | | | (_| |  __/ |  \__ \
# |___/ \_/\_/ |_|\__\___|_| |_|     |_.__/ \___/|_|  \__,_|\___|_|  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
FOCUSMODE_ENABLED=$(state_get ".focusmode.enabled")

script_name=$(basename "$0")

if $FOCUSMODE_ENABLED; then
    dunstify "Cannot enable main borders" "Main borders are disabled in focus mode."
    exit
fi

if [ "$1" == true ]; then
    logger -t theming -p user.info "[$script_name] Disabling main borders"

    sed -i -E "s/(border_color =) accent_color/\1 'rgba(00000000)'/" "$XDG_CONFIG_HOME/hypr/conf/colors-hyprland.lua"
    sed -i -E "s/(border_color_bright =) highlight_color/\1 'rgba(00000000)'/" "$XDG_CONFIG_HOME/hypr/conf/colors-hyprland.lua"
    sed -i -E "s/(border_color_tranparent =) accent_color_transparent/\1 'rgba(00000000)'/" "$XDG_CONFIG_HOME/hypr/conf/colors-hyprland.lua"

    state_set ".theme.border_main" false
else
    logger -t theming -p user.info "[$script_name] Enabling main borders"

    sed -i -E "s/(border_color =) 'rgba\(00000000\)'/\1 accent_color/" "$XDG_CONFIG_HOME/hypr/conf/colors-hyprland.lua"
    sed -i -E "s/(border_color_bright =) 'rgba\(00000000\)'/\1 highlight_color/" "$XDG_CONFIG_HOME/hypr/conf/colors-hyprland.lua"
    sed -i -E "s/(border_color_tranparent =) 'rgba\(00000000\)'/\1 accent_color_transparent/" "$XDG_CONFIG_HOME/hypr/conf/colors-hyprland.lua"

    state_set ".theme.border_main" true
fi
