#!/bin/sh
#  _                    _                                      _
# | |_ ___   __ _  __ _| | ___       ___  ___  _   _ _ __   __| |
# | __/ _ \ / _` |/ _` | |/ _ \_____/ __|/ _ \| | | | '_ \ / _` |
# | || (_) | (_| | (_| | |  __/_____\__ \ (_) | |_| | | | | (_| |
#  \__\___/ \__, |\__, |_|\___|     |___/\___/ \__,_|_| |_|\__,_|
#           |___/ |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Get the mute status of the default sink.
MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$MUTE_STATUS" = "yes" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0
else
    pactl set-sink-mute @DEFAULT_SINK@ 1
fi
