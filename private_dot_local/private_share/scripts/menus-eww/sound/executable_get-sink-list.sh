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
    pactl list sinks | awk '
        /^Sink #/ {
            if (desc != "" && available == 1) {
                print desc
            }
            desc = ""
            available = 0
        }
        /Description:/ {
            desc = $0
            sub(/^[[:space:]]*Description: /, "", desc)
        }
        /Ports:/ {
            in_ports = 1
        }
        /Active Port:/ {
            in_ports = 0
        }
        in_ports && /priority:/ {
            if ($0 ~ /available\)/ || $0 ~ /availability unknown\)/ || $0 ~ /, available$/) {
                if ($0 !~ /not available/) {
                    available = 1
                }
            }
        }
        END {
            if (desc != "" && available == 1) {
                print desc
            }
        }
    ' | while read -r line; do
        if [[ "$line" =~ HDMI\ /\ DisplayPort\ ([0-9]+)\ Output ]]; then
            echo "HDMI / DisplayPort ${BASH_REMATCH[1]} Output"
        elif [[ "$line" =~ "Speaker" ]]; then
            echo "Speaker"
        else
            echo "$line"
        fi
    done | awk '
        /^HDMI \/ DisplayPort/ {
            hdmi[NR] = $0
            next
        }
        {
            other[NR] = $0
        }
        END {
            for (i in other) print other[i]
            for (i in hdmi) print hdmi[i]
        }
    ' | jq -R -s -c 'split("\n") | map(select(length > 0))'
)

echo "$SINK_OPTIONS"
