#!/usr/bin/env bash
#                        _ _
#  _ __ ___   ___  _ __ (_) |_ ___  _ __      _ __ ___   ___ _ __  _   _
# | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|____| '_ ` _ \ / _ \ '_ \| | | |
# | | | | | | (_) | | | | | || (_) | | |_____| | | | | |  __/ | | | |_| |
# |_| |_| |_|\___/|_| |_|_|\__\___/|_|       |_| |_| |_|\___|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

extend="Extend"
external="External Only"
mirror="Mirror Main Screen"

THEME_MONITOR="window {width: 20%;} inputbar {enabled: false;} listview {padding: 0;}"

monitor_cmd() {
    rofi -disable-history -dmenu -replace -font "Noto Sans Bold 14" \
        -config "$XDG_CONFIG_HOME/rofi/config-simple.rasi" -theme-str "${THEME_MONITOR}" \
        -i -no-show-icons -l 3 -p "Choose a monitor setup"
}

# need at least one non-internal monitor
if ! hyprctl monitors -j | jq -e 'any(.[]; .name != "eDP-1")' >/dev/null; then
    dunstify "No external monitor connected."
    exit 0
fi

selected="$(echo -e "$extend\n$external\n$mirror" | monitor_cmd)"

case "$selected" in
    "$extend")   state_set ".monitor.pref" "extend" ;;
    "$external") state_set ".monitor.pref" "external" ;;
    # "$mirror")   state_set ".monitor.pref" "mirror" ;;
    "$mirror")   dunstify "Not implemented" ;;
    *)           exit 0 ;;
esac

hyprctl reload
