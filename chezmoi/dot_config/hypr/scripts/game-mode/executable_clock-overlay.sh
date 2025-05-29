#!/usr/bin/env bash
#       _            _                             _
#   ___| | ___   ___| | __      _____   _____ _ __| | __ _ _   _
#  / __| |/ _ \ / __| |/ /____ / _ \ \ / / _ \ '__| |/ _` | | | |
# | (__| | (_) | (__|   <_____| (_) \ V /  __/ |  | | (_| | |_| |
#  \___|_|\___/ \___|_|\_\     \___/ \_/ \___|_|  |_|\__,_|\__, |
#                                                          |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

PANEL_HEIGHT=50
PANEL_WIDTH=150

MARGIN_TOP=30
MARGIN_LEFT=1780

# Check if any kitty panel processes with the clock is running.
clock_running=$(pgrep -f "kitty \+kitten panel.*isthataclock" || true)


if [ -n "$clock_running" ]; then
    # Kill all running kitty panel cava processes
    pkill -f "kitty \+kitten panel.*isthataclock"
else
    kitty +kitten panel --edge=center --layer=overlay -o background_opacity=0 -o font_size=24 \
                --margin-top=$((MARGIN_TOP - 20)) --margin-bottom=$((1080 - $MARGIN_TOP - $PANEL_HEIGHT - 20)) \
                --margin-left=$MARGIN_LEFT --margin-right=$((1920 - $MARGIN_LEFT - $PANEL_WIDTH)) \
                python $HOME/.config/hypr/scripts/game-mode/isthataclock.py &
fi
