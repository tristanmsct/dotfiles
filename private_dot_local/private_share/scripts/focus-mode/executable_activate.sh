#!/usr/bin/env bash
#   __                                   _   _            _
#  / _| ___   ___ _   _ ___    __ _  ___| |_(_)_   ____ _| |_ ___
# | |_ / _ \ / __| | | / __|  / _` |/ __| __| \ \ / / _` | __/ _ \
# |  _| (_) | (__| |_| \__ \ | (_| | (__| |_| |\ V / (_| | ||  __/
# |_|  \___/ \___|\__,_|___/  \__,_|\___|\__|_| \_/ \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

THEME_TYPE=$(state_get ".theme.mode")
FOCUSMODE_ENABLED=$(state_get ".focusmode.enabled")
script_name=$(basename "$0")

if [ "$THEME_TYPE" = "light" ]; then
    "$DESKTOP_SCRIPTS/theming/switch-theme.sh"
fi

if [ "$FOCUSMODE_ENABLED" = "true" ]; then
    # If focus mode is on, then we restore everything and disable it.
    logger -t focusmode -p user.info "[$script_name] Deactivating focus mode"

    hyprctl reload
    waypaper --restore

    nextcloud --background &

    if [ "$#" -eq 0 ] || [ "$1" != "quiet" ]; then
        dunstify "Focus mode deactivated" "Decorations, blur, wallpaper, etc. enabled"
    fi

    state_set ".focusmode.enabled" false
else
    # If focus mode is off, then start it.
    logger -t focusmode -p user.info "[$script_name] Activating focus mode"

    hyprctl eval "hl.config({decoration = {shadow = {enabled = false}}})"
    # hyprctl eval "hl.config({decoration = {blur = {enabled = false}}})"
    hyprctl eval "hl.config({decoration = {inactive_opacity = 1}})"
    hyprctl eval "hl.config({decoration = {rounding = 1}})"
    hyprctl eval "hl.config({general = {gaps_in = 0}})"
    hyprctl eval "hl.config({general = {gaps_out = 0}})"
    hyprctl eval "hl.config({general = {border_size = 0}})"

    awww kill

    sed -i -E "s/(background-theme) rgba\(0, 0, 0, 0.4\);/\1 transparent;/" "$XDG_CONFIG_HOME/waybar/colors-waybar.css"
    sed -i -E "s/(border-color) @accent-color;/\1 transparent;/" "$XDG_CONFIG_HOME/waybar/colors-waybar.css"

    nextcloud --quit

    if [ "$#" -eq 0 ] || [ "$1" != "quiet" ]; then
        dunstify "Focus mode activated" "Decorations, blur, wallpaper, etc. disabled"
    fi

    state_set ".focusmode.enabled" true
fi
