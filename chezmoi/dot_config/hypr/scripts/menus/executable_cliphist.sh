#!/bin/bash
#   ____ _ _       _     _     _
#  / ___| (_)_ __ | |__ (_)___| |_
# | |   | | | '_ \| '_ \| / __| __|
# | |___| | | |_) | | | | \__ \ |_
#  \____|_|_| .__/|_| |_|_|___/\__|
#           |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Common theme configuration
THEME_NORTHEAST="window { location: northeast; anchor: northeast; x-offset: -1.5%; y-offset: 4%; width: 25%; padding: 1% 0.5% 0% 0.5%;}"

case $1 in
    delete) cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-search.rasi -theme-str "${THEME_NORTHEAST}" | cliphist delete
       ;;

    wipe) if [ `echo -e "Clear\nCancel" | rofi -dmenu -l 2 -config ~/.config/rofi/config-simple.rasi -theme-str "${THEME_NORTHEAST}"` == "Clear" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-search.rasi -theme-str "${THEME_NORTHEAST}" | cliphist decode | wl-copy
       ;;
esac
