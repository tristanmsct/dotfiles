#!/bin/bash
#   ____                                                _                   _   _            _
#  / ___| __ _ _ __ ___   ___       _ __ ___   ___   __| | ___    __ _  ___| |_(_)_   ____ _| |_ ___
# | |  _ / _` | '_ ` _ \ / _ \_____| '_ ` _ \ / _ \ / _` |/ _ \  / _` |/ __| __| \ \ / / _` | __/ _ \
# | |_| | (_| | | | | | |  __/_____| | | | | | (_) | (_| |  __/ | (_| | (__| |_| |\ V / (_| | ||  __/
#  \____|\__,_|_| |_| |_|\___|     |_| |_| |_|\___/ \__,_|\___|  \__,_|\___|\__|_| \_/ \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:inactive_opacity 1;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0"

    pkill hyprpaper
    [ ! -f $HOME/.cache/waybar-disabled ] && $HOME/.config/hypr/scripts/waybar/toggle.sh
    pkill nextcloud
    dunstify "Gamemode activated" "Animations, blur, wallpaper and bar disabled"
    exit
fi

source ~/.config/hypr/scripts/game-mode/hide-games.sh
hyprctl reload
waypaper --restore
[ -f $HOME/.cache/waybar-disabled ] && $HOME/.config/hypr/scripts/waybar/toggle.sh
/usr/bin/nextcloud --background &
dunstify "Gamemode deactivated" "Animations, blur, wallpaper and bar enabled"
