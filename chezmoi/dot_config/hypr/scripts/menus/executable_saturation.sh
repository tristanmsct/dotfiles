#!/bin/bash
#  ____        _                   _   _
# / ___|  __ _| |_ _   _ _ __ __ _| |_(_) ___  _ __        _ __ ___   ___ _ __  _   _
# \___ \ / _` | __| | | | '__/ _` | __| |/ _ \| '_ \ _____| '_ ` _ \ / _ \ '_ \| | | |
#  ___) | (_| | |_| |_| | | | (_| | |_| | (_) | | | |_____| | | | | |  __/ | | | |_| |
# |____/ \__,_|\__|\__,_|_|  \__,_|\__|_|\___/|_| |_|     |_| |_| |_|\___|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

saturation=$(
    rofi -dmenu -l 0 -width 20 -replace \
        -config ~/.config/rofi/config-simple-entry.rasi \
        -theme-str 'entry { placeholder: "Pywall Saturation 0 - 1"; }'
)

# Just a bit of input format check.
RE_INT='^[0-1]\.?[0-9]*$'
if ! [[ $saturation =~ $RE_INT ]];then
    dunstify "Input error"
else
    if [ $saturation -lt 0 ] || [ $saturation -gt 1 ]; then
        dunstify "Input should be between 0 and 1"
    else
        WALLPAPER=$(cat $HOME/.cache/wallpaper/current_wallpaper)
        wal -q -i $WALLPAPER --saturate $saturation
    fi
fi
