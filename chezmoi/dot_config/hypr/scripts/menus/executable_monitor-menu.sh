#!/usr/bin/env bash
#                        _ _
#  _ __ ___   ___  _ __ (_) |_ ___  _ __      _ __ ___   ___ _ __  _   _
# | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|____| '_ ` _ \ / _ \ '_ \| | | |
# | | | | | | (_) | | | | | || (_) | | |_____| | | | | |  __/ | | | |_| |
# |_| |_| |_|\___/|_| |_|_|\__\___/|_|       |_| |_| |_|\___|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CONFIG_DIR="$HOME/.config/hypr/conf"
CONFIG_FILE=$HOME/.local/state/desktop/state.json
source $HOME/.config/hypr/scripts/monitors/monitor-helpers.sh

default="Default"
auto_detect="Auto Detect"
external="External Only"
mirror="Mirror Main Screen"

monitor_cmd() {
    rofi -dmenu -replace -config ~/.config/rofi/config-simple.rasi -i -no-show-icons -l $1 -p "Choose a monitor setup"
}

monitor_menu() {
    monitor_count=$(hyprctl monitors -j | jq length)
    if [[ $monitor_count -ge 2 ]]; then
        echo -e "$default\n$auto_detect\n$external\n$mirror" | monitor_cmd 4
    else
        echo -e "$default\n$auto_detect" | monitor_cmd 2
    fi
}

selected_setup="$(monitor_menu)"
case $selected_setup in
    $default)
        # log_message "Manually triggering default conf"
        jq '.display.monitor_external_only = false' $CONFIG_FILE | sponge $CONFIG_FILE
        cp "$CONFIG_DIR/monitors/mono.conf" "$MONITOR_FILE"
        sed -i 's/"\*": [0-9]/"\*": 4/g' "$HOME/.config/waybar/modules.jsonc"
        hyprctl reload
        ;;
    $auto_detect)
        # log_message "Manually triggering auto detect"
        jq '.display.monitor_external_only = false' $CONFIG_FILE | sponge $CONFIG_FILE
        $HOME/.config/hypr/scripts/monitors/monitor-check.sh
        ;;
    $external)
        # log_message "Manually triggering external only conf"
        monitor_count=$(hyprctl monitors -j | jq length)
        if [[ $monitor_count -ge 2 ]]; then
            jq '.display.monitor_external_only = true' $CONFIG_FILE | sponge $CONFIG_FILE
            sed -i "s|^monitor=eDP-1.*$|monitor=eDP-1,disabled|g" "$MONITOR_FILE"
            sed -i "s|^bindl = , switch:on:Lid Switch, exec, hyprlock$||g" "$MONITOR_FILE"
            sed -i 's/"\*": [0-9]/"\*": 4/g' "$HOME/.config/waybar/modules.jsonc"
            exit 1
        else
            dunstify "Cannot disable the main monitor: need at least another one."
            exit 1
        fi
        ;;
    $mirror)
        sed -i 's/^monitor=DP-[0-9].*/&,mirror,eDP-1/' "$MONITOR_FILE"
        ;;
    *)
        echo "Unknown command."
        ;;
esac
