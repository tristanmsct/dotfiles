#!/bin/bash
#  _          _       _     _
# | |__  _ __(_) __ _| |__ | |_ _ __   ___  ___ ___       _ __ ___   ___ _ __  _   _
# | '_ \| '__| |/ _` | '_ \| __| '_ \ / _ \/ __/ __|_____| '_ ` _ \ / _ \ '_ \| | | |
# | |_) | |  | | (_| | | | | |_| | | |  __/\__ \__ \_____| | | | | |  __/ | | | |_| |
# |_.__/|_|  |_|\__, |_| |_|\__|_| |_|\___||___/___/     |_| |_| |_|\___|_| |_|\__,_|
#               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

brightness=$(
    rofi -dmenu -l 0 -width 20 -replace \
        -config ~/.config/rofi/config-simple-entry.rasi \
        -theme-str 'entry { placeholder: "Screen brightness 10 - 100"; }'
)

# Just a bit of input format check.
RE_INT='^[0-9]+$'
if ! [[ $brightness =~ $RE_INT ]];then
    dunstify "Input error"
else
    if [ $brightness -lt 10 ] || [ $brightness -gt 100 ]; then
        dunstify "Input should be between 10 and 100"
    else
        brightnessctl set $(($(brightnessctl max) * $brightness / 100))
    fi
fi
