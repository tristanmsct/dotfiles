#!/usr/bin/env bash
#            _                   _
#  ___  __ _| |_ _   _ _ __ __ _| |_ ___
# / __|/ _` | __| | | | '__/ _` | __/ _ \
# \__ \ (_| | |_| |_| | | | (_| | ||  __/
# |___/\__,_|\__|\__,_|_|  \__,_|\__\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Maybe the saturation function should work even in focus mode but it would be a pain to implement for almost nothing.
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 0 ] ; then
    dunstify "Focus mode activated, saturation disabled."
    exit
fi

WALLPAPER=$(cat $HOME/.cache/wallpaper/current_wallpaper)
wal -q -i $WALLPAPER --saturate $1
eww reload &
