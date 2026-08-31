#!/usr/bin/env bash
#                        _ _
#  _ __ ___   ___  _ __ (_) |_ ___  _ __      _ __ ___   ___ _ __  _   _
# | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|____| '_ ` _ \ / _ \ '_ \| | | |
# | | | | | | (_) | | | | | || (_) | | |_____| | | | | |  __/ | | | |_| |
# |_| |_| |_|\___/|_| |_|_|\__\___/|_|       |_| |_| |_|\___|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

default="Default"
external="External Only"
mirror="Mirror Main Screen"

THEME_MONITOR="window {width: 20%;} inputbar {enabled: false;} listview {padding: 0;}"

monitor_cmd() {
    rofi -disable-history -dmenu -replace -font "Noto Sans Bold 14" \
        -config "$XDG_CONFIG_HOME/rofi/config-simple.rasi" -theme-str "${THEME_MONITOR}"\
        -i -no-show-icons -l "$1" -p "Choose a monitor setup"
}

monitor_menu() {
    monitor_count=$(hyprctl monitors -j | jq length)
    if [[ $monitor_count -ge 2 ]]; then
        echo -e "$external\n$mirror" | monitor_cmd 2
    else
        echo -e "$default" | monitor_cmd 1
    fi
}

selected_setup="$(monitor_menu)"
case "$selected_setup" in
    "$default")
        hyprctl reload
        ;;
    "$external")
        # log_message "Manually triggering external only conf"
        monitor_count=$(hyprctl monitors -j | jq length)
        if [[ $monitor_count -ge 2 ]]; then
            hyprctl eval "hl.monitor({ output = 'eDP-1', disabled = true })"
            exit 1
        else
            dunstify "Cannot disable the main monitor: need at least another one."
            exit 1
        fi
        ;;
    "$mirror")
        hyprctl eval "hl.monitor({ output = 'DP-1', mode = '1920x1080@120', position = '0x0', scale = 1, mirror = 'eDP-1' })"
        ;;
    *)
        echo "Unknown command."
        ;;
esac
