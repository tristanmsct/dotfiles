#!/usr/bin/env bash
#               _ _       _               _       _
#  _____      _(_) |_ ___| |__        ___(_)_ __ | | __
# / __\ \ /\ / / | __/ __| '_ \ _____/ __| | '_ \| |/ /
# \__ \\ V  V /| | || (__| | | |_____\__ \ | | | |   <
# |___/ \_/\_/ |_|\__\___|_| |_|     |___/_|_| |_|_|\_\
#
# -----------------------------------------------------------------------------------------------------------------------------------------

DESCRIPTION="$1"

# Function to get sink name from description.
get_sink_name() {
    local desc="$1"

    # Check if it's a simplified HDMI description.
    if [[ "$desc" =~ ^HDMI[[:space:]]([0-9]+)$ ]]; then
        hdmi_num="${BASH_REMATCH[1]}"
        # Find the actual HDMI sink with that number.
        pactl list sinks | awk -v num="$hdmi_num" '
            /Name:/ {name=$2}
            /Description:/ && /DisplayPort '"$hdmi_num"' Output/ {print name; exit}
        '
    else
        # Regular description lookup.
        pactl list sinks | grep -B 1 "Description: ${desc}" | grep "Name:" | awk '{print $2}'
    fi
}

SINK_NAME=$(get_sink_name "$DESCRIPTION")

if [ -n "$SINK_NAME" ]; then
    pactl set-default-sink "$SINK_NAME"
    echo "Switched to: $DESCRIPTION"
else
    echo "Sink not found: $DESCRIPTION"
fi

eww close sink-switcher-window
eww close sink-switcher-window-closer
