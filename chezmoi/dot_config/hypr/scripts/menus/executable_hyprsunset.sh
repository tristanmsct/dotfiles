#!/bin/bash
#  _                                               _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      _ __ ___   ___ _ __  _   _
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| '_ ` _ \ / _ \ '_ \| | | |
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| | | | | |  __/ | | | |_| |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |_| |_| |_|\___|_| |_|\__,_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CONFIG_FILE=$HOME/.config/hypr/conf/hyprsunset.json

pgrep -x hyprsunset >/dev/null || hyprsunset -i &

if [ "$1" = "temperature-setter" ];then
    temperature=$(
        rofi -dmenu -l 0 -width 20 -replace \
            -config ~/.config/rofi/config-simple-entry.rasi \
            -theme-str 'entry { placeholder: "Temperature 1 000 - 20 000"; }'
    )

    # Just a bit of input format check.
    RE_INT='^[0-9]+$'
    if ! [[ $temperature =~ $RE_INT ]];then
        dunstify "Input error"
    else
        if [ $temperature -lt 1000 ] || [ $temperature -gt 20000 ]; then
            dunstify "Input should be between 1 000 and 20 000"
        else
            # Only if the input is well formated we apply the chosen temperature and modify the config file.
            hyprctl hyprsunset temperature $temperature
            jq '.temperature ='$temperature $CONFIG_FILE | sponge $CONFIG_FILE
            jq '.filter_on = true' $CONFIG_FILE | sponge $CONFIG_FILE
            dunstify "Hyprsunset started with temperature $temperature"
        fi
    fi
elif [ "$1" = "autotimer-switch" ];then
    options="Hyprsunset Auto Timer On\nHyprsunset Auto Timer Off"
    choice=$(
        echo -e "$options" | \
            rofi -dmenu -replace \
                -config ~/.config/rofi/config-simple.rasi \
                -i -no-show-icons -l 2 -width 30 -p "Hyprshade"
    )

    if [[ $choice = "Hyprsunset Auto Timer Off" ]]; then
        # When turning of the auto timer, we restore the last known config.
        # It is a bit redundant because manual hyprsunset should have priority.
        jq '.auto_timer = false' $CONFIG_FILE | sponge $CONFIG_FILE
        $HOME/.config/hypr/scripts/hyprsunset/hyprsunset.sh restore
        dunstify "Hyprsunset auto-timer off"
    elif [[ $choice = "Hyprsunset Auto Timer On" ]]; then
        # If we activate the auto timer, then the script is run once to catch up.
        jq '.auto_timer = true' $CONFIG_FILE | sponge $CONFIG_FILE
        $HOME/.config/hypr/scripts/hyprsunset/hyprsunset-timer.sh
        dunstify "Hyprsunset auto-timer on"
    fi
fi
