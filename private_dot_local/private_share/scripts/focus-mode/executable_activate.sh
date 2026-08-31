#!/usr/bin/env bash
#   __                                   _   _            _
#  / _| ___   ___ _   _ ___    __ _  ___| |_(_)_   ____ _| |_ ___
# | |_ / _ \ / __| | | / __|  / _` |/ __| __| \ \ / / _` | __/ _ \
# |  _| (_) | (__| |_| \__ \ | (_| | (__| |_| |\ V / (_| | ||  __/
# |_|  \___/ \___|\__,_|___/  \__,_|\___|\__|_| \_/ \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$DESKTOP_SCRIPTS/system/setup-state.sh

STATE_FILE=$XDG_STATE_HOME/desktop/state.json
THEME_TYPE=$(jq -r '.theme.mode' $STATE_FILE)
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)

if [ $THEME_TYPE = "light" ]; then
    $DESKTOP_SCRIPTS/theming/switch-theme.sh
fi

if $FOCUSMODE_ENABLED; then
    # If focus mode is on, then we restore everything and disable it.
    hyprctl reload
    waypaper --restore

    nextcloud --background &

    if [ "$#" -eq 0 ] || [ $1 != "quiet" ]; then
        dunstify "Focus mode deactivated" "Decorations, blur, wallpaper, etc. enabled"
    fi

    jq '.focusmode.enabled = false' $STATE_FILE | sponge $STATE_FILE
else
    # If focus mode is off, then start it.
    hyprctl eval "hl.config({decoration = {shadow = {enabled = false}}})"
    # hyprctl eval "hl.config({decoration = {blur = {enabled = false}}})"
    hyprctl eval "hl.config({decoration = {inactive_opacity = 1}})"
    hyprctl eval "hl.config({decoration = {rounding = 1}})"
    hyprctl eval "hl.config({general = {gaps_in = 0}})"
    hyprctl eval "hl.config({general = {gaps_out = 0}})"
    hyprctl eval "hl.config({general = {border_size = 0}})"

    awww kill

    sed -i -E "s/(background-theme) rgba\(0, 0, 0, 0.4\);/\1 transparent;/" $HOME/.config/waybar/colors-waybar.css
    sed -i -E "s/(border-color) @accent-color;/\1 transparent;/" $HOME/.config/waybar/colors-waybar.css

    nextcloud --quit

    if [ "$#" -eq 0 ] || [ $1 != "quiet" ]; then
        dunstify "Focus mode activated" "Decorations, blur, wallpaper, etc. disabled"
    fi

    jq '.focusmode.enabled = true' $STATE_FILE | sponge $STATE_FILE
fi
