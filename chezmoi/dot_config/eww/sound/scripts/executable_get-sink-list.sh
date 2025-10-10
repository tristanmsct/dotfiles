#!/usr/bin/env bash
#             _            _       _         _ _     _
#   __ _  ___| |_      ___(_)_ __ | | __    | (_)___| |_
#  / _` |/ _ \ __|____/ __| | '_ \| |/ /____| | / __| __|
# | (_| |  __/ ||_____\__ \ | | | |   <_____| | \__ \ |_
#  \__, |\___|\__|    |___/_|_| |_|_|\_\    |_|_|___/\__|
#  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

SINK_OPTIONS=$(
    pactl list sinks | grep 'Description:' | sed 's/^[[:space:]]*Description: //' | awk '{
        if ($0 ~ /HDMI \/ DisplayPort [0-9]+ Output/) {
            match($0, /DisplayPort ([0-9]+)/, arr);
            hdmi[arr[1]] = "HDMI " arr[1]
        } else {
            print $0
        }
        } END {
        for (i=1; i<=3; i++) if (hdmi[i]) print hdmi[i]
    }' | jq -R -s -c 'split("\n")[:-1]'
)

echo $SINK_OPTIONS
