#!/usr/bin/env bash
#  _                                               _        _   _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_     | |_(_)_ __ ___   ___ _ __
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| __| | '_ ` _ \ / _ \ '__|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| |_| | | | | | |  __/ |
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|     \__|_|_| |_| |_|\___|_|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Needed for the systemd timer.
DESKTOP_SCRIPTS=${DESKTOP_SCRIPTS:-$HOME/.local/share/scripts}
script_name=$(basename "$0")

source "$DESKTOP_SCRIPTS/system/state-utils"
MANUAL_FILTER_ON=$(state_get ".hyprsunset.filter_on")
AUTOTIMER_STATE=$(state_get ".hyprsunset.auto_timer")
CALENDAR_FILE=$DESKTOP_SCRIPTS/hyprland/hyprsunset/hyprsunset-calendar.json

# The timer does not have priority over the manual filter, IF either the manual filter is on, or the auto timer is off, the script stops.
if [[ $MANUAL_FILTER_ON = "" ]]; then
    logger -t hyprsunset -p user.info "[$script_name] Manual filter is on, exiting"
    exit
fi
if ! $AUTOTIMER_STATE; then
    logger -t hyprsunset -p user.info "[$script_name] Auto timer is off, exiting"
    exit
fi

DIMMING_INTERVAL=90
HYPRSUNSET_BASE=6500
INCREMENT=200

hour=$(date +%H)
hour=${hour#0}
minute=$(date +%M)
minute=${minute#0}

# Morning and evening starts depend on the month and are in the config file.
morning_start=$(jq -r ".calendar.$(LC_TIME=en_UK.utf8 date +%B)[0]" "$CALENDAR_FILE")
evening_start=$(jq -r ".calendar.$(LC_TIME=en_UK.utf8 date +%B)[1]" "$CALENDAR_FILE")
current_time=$((hour * 60 + minute))

# If we are before the morning start, then we add 24h to the current time, so that if it is 1h20, we will have 25h20.
# It is a lot easier to handle than having to work arround the midnight edge case.
[[ $current_time -lt $morning_start ]] && current_time=$((current_time + 1440))

pgrep -x hyprsunset >/dev/null || hyprsunset -i &

if [[ $current_time -ge $morning_start ]] && [[ $current_time -le $((morning_start + DIMMING_INTERVAL)) ]]; then
    # Morning, sun is rising.
    slice=$(((current_time - morning_start) / 10))
    temperature=$((HYPRSUNSET_BASE - (((DIMMING_INTERVAL / 10) - slice) * INCREMENT)))
    logger -t hyprsunset -p user.info "[$script_name] Sunrise : incrementing temperature to $temperature"

    hyprctl hyprsunset temperature $temperature
elif [[ $current_time -ge $evening_start ]] && [[ $current_time -le $((evening_start + DIMMING_INTERVAL)) ]]; then
    # Evening, sun is setting.
    slice=$((((current_time - evening_start) / 10) + 1))
    temperature=$((HYPRSUNSET_BASE - (slice * INCREMENT)))
    logger -t hyprsunset -p user.info "[$script_name] Sunset : decreasing temperature to $temperature"

    hyprctl hyprsunset temperature $temperature
elif [[ $current_time -gt $((evening_start + DIMMING_INTERVAL)) ]]; then
    # Night time.
    slice=$(((DIMMING_INTERVAL / 10) + 1))
    temperature=$((HYPRSUNSET_BASE - (slice * INCREMENT)))
    logger -t hyprsunset -p user.info "[$script_name] Night time : temperature set to $temperature"

    hyprctl hyprsunset temperature $temperature
else
    # Day time.
    logger -t hyprsunset -p user.info "[$script_name] Day time : no temperature modifier"
    hyprctl hyprsunset identity
fi
