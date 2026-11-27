#!/usr/bin/env bash
#  _                                               _              _   _ _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_      _   _| |_(_) |___
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| | | | __| | / __|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| |_| | |_| | \__ \
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|     \__,_|\__|_|_|___/
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1091

HYPRSUNSET_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DESKTOP_SCRIPTS="${DESKTOP_SCRIPTS:-$(cd -- "$HYPRSUNSET_DIR/.." && pwd)}"
export DESKTOP_SCRIPTS

source "$DESKTOP_SCRIPTS/system/state-utils"

hyprsunset_ensure_running() {
    pgrep -x hyprsunset >/dev/null || hyprsunset -i &
}

hyprsunset_set_temperature() {
    local temperature="${1:?temperature required}"

    hyprctl hyprsunset temperature "$temperature"
}

hyprsunset_set_identity() {
    hyprctl hyprsunset identity
}

hyprsunset_set_manual() {
    local script_name="${1:-$(basename "$0")}"
    local temperature

    temperature=$(state_get ".hyprsunset.temperature")
    hyprsunset_set_temperature "$temperature" || return 1

    state_set ".hyprsunset.state" "on" || return 1
    logger -t hyprsunset -p user.info "[$script_name] Hyprsunset started with temperature $temperature"
}

hyprsunset_set_off() {
    local script_name="${1:-$(basename "$0")}"

    hyprsunset_set_identity || return 1

    state_set ".hyprsunset.state" "off" || return 1
    logger -t hyprsunset -p user.info "[$script_name] Stopping hyprsunset filter"
}

hyprsunset_set_auto() {
    local script_name="${1:-$(basename "$0")}"

    state_set ".hyprsunset.state" "auto" || return 1
    logger -t hyprsunset -p user.info "[$script_name] Starting automatic hyprsunset timer"

    "$DESKTOP_SCRIPTS/hyprsunset/hyprsunset-timer.sh"
}

hyprsunset_restore() {
    local script_name="${1:-$(basename "$0")}"
    local state

    state=$(state_get ".hyprsunset.state")

    case "$state" in
        on)
            hyprsunset_set_manual "$script_name"
            ;;
        off)
            hyprsunset_set_off "$script_name"
            ;;
        auto)
            hyprsunset_set_auto "$script_name"
            ;;
        *)
            logger -t hyprsunset -p user.error "[$script_name] Unknown hyprsunset state: $state"
            return 1
            ;;
    esac
}

hyprsunset_refresh_waybar() {
    pkill -RTMIN+8 waybar
}
