#!/usr/bin/env bash
#  _                                               _                      _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      _ __ ___  ___| |_ ___  _ __ ___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| '__/ _ \/ __| __/ _ \| '__/ _ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| | |  __/\__ \ || (_) | | |  __/
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |_|  \___||___/\__\___/|_|  \___|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Restores the previous state of hyprsunset.
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
FILTER_STATE=$(state_get ".hyprsunset.state")
script_name=$(basename "$0")

pgrep -x hyprsunset >/dev/null || hyprsunset -i &

logger -t hyprsunset -p user.info "[$script_name] Restoring hyprsunset config"

case $FILTER_STATE in
on)
    temperature=$(state_get ".hyprsunset.temperature")
    hyprctl hyprsunset temperature "$temperature"
    logger -t hyprsunset -p user.info "[$script_name] Restoring manual hyprsunset"
    ;;
off)
    hyprctl hyprsunset identity
    logger -t hyprsunset -p user.info "[$script_name] Restoring off state"
    ;;
auto)
    "$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-timer.sh"
    logger -t hyprsunset -p user.info "[$script_name] Restoring auto hyprsunset"
    ;;
*)
    logger -t hyprsunset -p user.error "[$script_name] Error, filter state unkown"
    ;;
esac

# Update waybar icon config.
pkill -RTMIN+8 waybar
