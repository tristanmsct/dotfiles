#!/usr/bin/env bash
#  _     _                                        _
# | |__ | |_ ___  _ __         _____   _____ _ __| | __ _ _   _
# | '_ \| __/ _ \| '_ \ _____ / _ \ \ / / _ \ '__| |/ _` | | | |
# | |_) | || (_) | |_) |_____| (_) \ V /  __/ |  | | (_| | |_| |
# |_.__/ \__\___/| .__/       \___/ \_/ \___|_|  |_|\__,_|\__, |
#                |_|                                      |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

MARGIN_TOP=100
MARGIN_LEFT=50
PANEL_WIDTH=900
PANEL_HEIGHT=400

# Check if any kitty panel processes with the btop overlay is running.
btop_running=$(pgrep -f "kitty \+kitten panel.*btop" || true)


if [ -n "$btop_running" ]; then
    # Kill all running kitty panel btop processes.
    pkill -f "kitty \+kitten panel.*btop"
else
    kitty +kitten panel --edge=center --layer=bottom -o background_opacity=0 \
        --margin-top=$MARGIN_TOP \
        --margin-bottom=$((1080 - $MARGIN_TOP - $PANEL_HEIGHT)) \
        --margin-left=$MARGIN_LEFT \
        --margin-right=$((1920 - $MARGIN_LEFT - $PANEL_WIDTH)) \
        btop --config $XDG_CONFIG_HOME/btop/btop-cpu.conf &
fi
