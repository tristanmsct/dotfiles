#!/usr/bin/env bash
#  _           _   _                                              _ _
# | |__   __ _| |_| |_ ___ _ __ _   _       _ __ ___   ___  _ __ (_) |_ ___  _ __
# | '_ \ / _` | __| __/ _ \ '__| | | |_____| '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|
# | |_) | (_| | |_| ||  __/ |  | |_| |_____| | | | | | (_) | | | | | || (_) | |
# |_.__/ \__,_|\__|\__\___|_|   \__, |     |_| |_| |_|\___/|_| |_|_|\__\___/|_|
#                               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

BATTERY_FILE="$XDG_STATE_HOME/desktop/state.json"
BATTERY_LOCK="$BATTERY_FILE.lock"

battery_state_get() {
    jq -r "$1" "$BATTERY_FILE"
}

battery_state_set() {
    (
        flock -x 200
        tmp=$(mktemp)
        # Determine if $2 is valid JSON. If so, use --argjson, else use --arg for string.
        if printf '%s' "$2" | jq -e . >/dev/null 2>&1; then
            jq --argjson val "$2" "$1 = \$val" "$BATTERY_FILE" > "$tmp" && mv "$tmp" "$BATTERY_FILE"
        else
            jq --arg val "$2" "$1 = \$val" "$BATTERY_FILE" > "$tmp" && mv "$tmp" "$BATTERY_FILE"
        fi
        rm -f "$BATTERY_LOCK"
    ) 200>"$BATTERY_LOCK"
}

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
PREVIOUS_LEVEL=$(battery_state_get ".battery_level")

if [ "$BATTERY_LEVEL" -gt "$PREVIOUS_LEVEL" ]; then
    if [ "$BATTERY_LEVEL" -eq 100 ]; then
        dunstify "Battery fully charged"
    fi
elif [ "$PREVIOUS_LEVEL" -gt "$BATTERY_LEVEL" ]; then
    if [ "$BATTERY_LEVEL" -eq 50 ]; then
        dunstify "Battery at 50% level"
    elif [ "$BATTERY_LEVEL" -eq 20 ]; then
        dunstify "Battery at 20% level"
    elif [ "$BATTERY_LEVEL" -eq 10 ]; then
        dunstify -u critical "Battery at critical 10% level"
    elif [ "$BATTERY_LEVEL" -eq 5 ]; then
        dunstify -u critical "Battery at critical 5% level, shutting down soon"
    fi
fi

battery_state_set ".battery_level" "$BATTERY_LEVEL"
