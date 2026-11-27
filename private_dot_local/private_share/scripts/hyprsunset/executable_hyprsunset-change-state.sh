#!/usr/bin/env bash
#  _                                               _             _                                      _        _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_       ___| |__   __ _ _ __   __ _  ___       ___| |_ __ _| |_ ___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____ / __| '_ \ / _` | '_ \ / _` |/ _ \_____/ __| __/ _` | __/ _ \
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| (__| | | | (_| | | | | (_| |  __/_____\__ \ || (_| | ||  __/
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|     \___|_| |_|\__,_|_| |_|\__, |\___|     |___/\__\__,_|\__\___|
#        |___/|_|                                                                  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Handles changes in state for hyprsunset.
# -----------------------------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1091

HYPRSUNSET_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
script_name=$(basename "$0")

source "$HYPRSUNSET_DIR/hyprsunset-utils.sh"

usage() {
    printf 'Usage: %s {switch|on|off|auto}\n' "$script_name" >&2
}

hyprsunset_ensure_running
filter_state=$(state_get ".hyprsunset.state")

case "${1:-}" in
    switch)
        if [[ "$filter_state" == "on" ]]; then
            hyprsunset_set_off "$script_name"
        else
            hyprsunset_set_manual "$script_name"
        fi
        ;;
    on)
        [[ "$filter_state" != "on" ]] && hyprsunset_set_manual "$script_name"
        ;;
    off)
        [[ "$filter_state" != "off" ]] && hyprsunset_set_off "$script_name"
        ;;
    auto)
        [[ "$filter_state" != "auto" ]] && hyprsunset_set_auto "$script_name"
        ;;
    *)
        usage
        exit 64
        ;;
esac

hyprsunset_refresh_waybar
