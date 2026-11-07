#!/usr/bin/env bash
#  _                                               _                     _ _       _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      _____      _(_) |_ ___| |__
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____/ __\ \ /\ / / | __/ __| '_ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____\__ \\ V  V /| | || (__| | | |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|    |___/ \_/\_/ |_|\__\___|_| |_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Simple switch. Turn on hyprsunset if it is off, off if it is on.
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"
FILTER_STATE=$(state_get ".hyprsunset.state")
script_name=$(basename "$0")

pgrep -x hyprsunset >/dev/null || hyprsunset -i &

if [[ "$FILTER_STATE" == "on" ]]; then
    hyprctl hyprsunset identity
    logger -t hyprsunset -p user.info "[$script_name] Stopping hyprsunset filter"
    state_set ".hyprsunset.state" "off"
else
    temperature=$(state_get ".hyprsunset.temperature")
    hyprctl hyprsunset temperature "$temperature"
    logger -t hyprsunset -p user.info "[$script_name] Hyprsunset started with temperature $temperature"
    state_set ".hyprsunset.state" "on"
fi

# Update waybar icon config.
pkill -RTMIN+8 waybar
