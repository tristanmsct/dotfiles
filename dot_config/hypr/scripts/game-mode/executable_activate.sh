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

CONFIG_FILE=$HOME/.local/state/desktop/state.json
THEME_TYPE=$(jq -r '.theme.mode' $CONFIG_FILE)

if [ $THEME_TYPE = "light" ]; then
    $HOME/.config/hypr/scripts/theming/switch-theme.sh
fi

HYPRGAMEMODE=$(hyprctl getoption decoration:shadow:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:inactive_opacity 1;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0"

    awww kill

    sed -i -E "s/(border: 2px solid) @accent-color;/\1 rgba(0,0,0,0);/" $HOME/.config/waybar/style.css
    sed -i -E "s/(background:) @background-theme;/\1 rgba(0,0,0,0);/" $HOME/.config/waybar/style.css

    rm $HOME/.cache/wallpaper/blurred_wallpaper.png

    /usr/bin/nextcloud --quit
    if [ "$#" -eq 0 ] || [ $1 != "quiet" ]; then
        dunstify "Gamemode activated" "Decorations, blur, wallpaper and bar disabled"
    fi
    exit
fi

source $HOME/.config/hypr/scripts/game-mode/cleanup-games.sh
hyprctl reload
waypaper --restore

if (grep -q "border-theme: 2px" "$HOME/.config/eww/eww.scss"); then
    sed -i -E "s/(border: 2px solid) rgba\(0,0,0,0\);/\1 @accent-color;/" $HOME/.config/waybar/style.css
fi
sed -i -E "s/(background:) rgba\(0,0,0,0\);/\1 @background-theme;/" $HOME/.config/waybar/style.css

$HOME/.config/hypr/launchers/nextcloud.sh --background &

if [ "$#" -eq 0 ] || [ $1 != "quiet" ]; then
    dunstify "Gamemode deactivated" "Decorations, blur, wallpaper and bar enabled"
fi
