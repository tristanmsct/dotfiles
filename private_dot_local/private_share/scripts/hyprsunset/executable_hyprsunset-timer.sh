#!/usr/bin/env bash
#  _                                               _        _   _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_     | |_(_)_ __ ___   ___ _ __
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| __| | '_ ` _ \ / _ \ '__|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| |_| | | | | | |  __/ |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|     \__|_|_| |_| |_|\___|_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Handles the logic of applying the right temperature for the time.
# -----------------------------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1091

HYPRSUNSET_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
script_name=$(basename "$0")

source "$HYPRSUNSET_DIR/hyprsunset-utils.sh"

# 90-minute transitions, starting from 6500 K and stepping 200 K.
readonly DIMMING_INTERVAL=90
readonly HYPRSUNSET_BASE=6500
readonly INCREMENT=200

normalize_time() {
    local hour="$1"
    local minute="$2"

    printf '%d' "$((10#$hour * 60 + 10#$minute))"
}

# Month-specific sunrise and sunset minutes come from calendar JSON.
load_calendar_times() {
    local calendar_file="$1"
    local month="$2"
    local morning
    local evening

    morning=$(jq -r --arg month "$month" '.[$month].morning' "$calendar_file")
    evening=$(jq -r --arg month "$month" '.[$month].evening' "$calendar_file")

    [[ "$morning" =~ ^[0-9]+$ ]] || return 1
    [[ "$evening" =~ ^[0-9]+$ ]] || return 1

    printf '%s %s' "$morning" "$evening"
}

calculate_schedule() {
    local current_time="$1"
    local morning_start="$2"
    local evening_start="$3"

    # Move before-morning times past midnight into the following day.
    # This is for cases when the transition starts before midnight but ends after midnight.
    if (( current_time < morning_start)); then
        current_time=$((current_time + 1440))
    fi

    # Morning transition, evening transition, night, then daytime.
    if (( current_time >= morning_start && current_time <= morning_start + DIMMING_INTERVAL)); then
        local slice=$(((current_time - morning_start) / 10))
        local temperature=$((HYPRSUNSET_BASE - ((DIMMING_INTERVAL / 10 - slice) * INCREMENT)))
        printf 'sunrise %d' "$temperature"
    elif (( current_time >= evening_start && current_time <= evening_start + DIMMING_INTERVAL)); then
        local slice=$((((current_time - evening_start) / 10) + 1))
        local temperature=$((HYPRSUNSET_BASE - (slice * INCREMENT)))
        printf 'sunset %d' "$temperature"
    elif (( current_time > evening_start + DIMMING_INTERVAL)); then
        local temperature=$((HYPRSUNSET_BASE - ((DIMMING_INTERVAL / 10 + 1) * INCREMENT)))
        printf 'night %d' "$temperature"
    else
        printf 'day'
    fi
}

# Converts calculated phase into logger and Hyprsunset actions.
apply_schedule() {
    local schedule="$1"
    local phase temperature

    read -r phase temperature <<< "$schedule"

    case "$phase" in
        sunrise)
            logger -t hyprsunset -p user.info "[$script_name] Sunrise: incrementing temperature to $temperature"
            hyprsunset_set_temperature "$temperature"
            ;;
        sunset)
            logger -t hyprsunset -p user.info "[$script_name] Sunset: decreasing temperature to $temperature"
            hyprsunset_set_temperature "$temperature"
            ;;
        night)
            logger -t hyprsunset -p user.debug "[$script_name] Night time: temperature set to $temperature"
            hyprsunset_set_temperature "$temperature"
            ;;
        day)
            logger -t hyprsunset -p user.debug "[$script_name] Day time: no temperature modifier"
            hyprsunset_set_identity
            ;;
    esac
}

main() {
    local filter_state
    local calendar_file
    local month
    local hour minute current_time schedule
    local morning_start evening_start calendar_times

    filter_state=$(state_get ".hyprsunset.state")

    if [[ "$filter_state" != "auto" ]]; then
        logger -t hyprsunset -p user.debug "[$script_name] Auto timer is off, exiting"
        return 0
    fi

    hour=$(date +%H)
    minute=$(date +%M)
    month=$(date +%m)
    calendar_file="$DESKTOP_SCRIPTS/hyprsunset/hyprsunset-calendar.json"

    if ! calendar_times=$(load_calendar_times "$calendar_file" "$month"); then
        logger -t hyprsunset -p user.error "[$script_name] Invalid calendar data for $month"
        return 1
    fi

    read -r morning_start evening_start <<< "$calendar_times"

    current_time=$(normalize_time "$hour" "$minute")
    schedule=$(calculate_schedule "$current_time" "$morning_start" "$evening_start")

    hyprsunset_ensure_running
    apply_schedule "$schedule"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
