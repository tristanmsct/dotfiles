#!/usr/bin/env bash
#   ____                                                _                   _   _            _
#  / ___| __ _ _ __ ___   ___       _ __ ___   ___   __| | ___    __ _  ___| |_(_)_   ____ _| |_ ___
# | |  _ / _` | '_ ` _ \ / _ \_____| '_ ` _ \ / _ \ / _` |/ _ \  / _` |/ __| __| \ \ / / _` | __/ _ \
# | |_| | (_| | | | | | |  __/_____| | | | | | (_) | (_| |  __/ | (_| | (__| |_| |\ V / (_| | ||  __/
#  \____|\__,_|_| |_| |_|\___|     |_| |_| |_|\___/ \__,_|\___|  \__,_|\___|\__|_| \_/ \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

STATE_FILE=$HOME/.local/state/desktop/state.json
THEME_TYPE=$(jq -r '.theme.mode' $STATE_FILE)
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)

# Running the clean up games scripts : will add NoDisplay=true for games and use steam.sh instead of steam in Exec.
source $HOME/.config/hypr/scripts/game-mode/cleanup-games.sh

if [ $THEME_TYPE = "light" ]; then
    $HOME/.config/hypr/scripts/theming/switch-theme.sh
fi

if $FOCUSMODE_ENABLED; then
    # If focus mode is on, then we restore everything and disable it.
    hyprctl reload
    waypaper --restore

    $HOME/.config/hypr/launchers/nextcloud.sh --background &

    if [ "$#" -eq 0 ] || [ $1 != "quiet" ]; then
        dunstify "Gamemode deactivated" "Decorations, blur, wallpaper, etc. enabled"
    fi

    jq '.focusmode.enabled = false' $STATE_FILE | sponge $STATE_FILE
else
    # If focus mode is off, then start it.
    hyprctl eval "hl.config({decoration = {shadow = {enabled = false}}})"
    hyprctl eval "hl.config({decoration = {blur = {enabled = false}}})"
    hyprctl eval "hl.config({decoration = {inactive_opacity = 1}})"
    hyprctl eval "hl.config({decoration = {rounding = 1}})"
    hyprctl eval "hl.config({general = {gaps_in = 0}})"
    hyprctl eval "hl.config({general = {gaps_out = 0}})"
    hyprctl eval "hl.config({general = {border_size = 0}})"

    awww kill

    sed -i -E "s/(background-theme) rgba\(0, 0, 0, 0.4\);/\1 rgba\(0, 0, 0, 0\);/" $HOME/.cache/wal/colors-waybar.css
    sed -i -E "s/(border-color) @accent-color;/\1 rgba\(0, 0, 0, 0\);/" $HOME/.cache/wal/colors-waybar.css

    /usr/bin/nextcloud --quit
    if [ "$#" -eq 0 ] || [ $1 != "quiet" ]; then
        dunstify "Gamemode activated" "Decorations, blur, wallpaper, etc. disabled"
    fi

    jq '.focusmode.enabled = true' $STATE_FILE | sponge $STATE_FILE
fi
