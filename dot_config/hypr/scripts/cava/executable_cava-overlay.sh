#!/usr/bin/env bash
#                                                 _
#   ___ __ ___   ____ _        _____   _____ _ __| | __ _ _   _
#  / __/ _` \ \ / / _` |_____ / _ \ \ / / _ \ '__| |/ _` | | | |
# | (_| (_| |\ V / (_| |_____| (_) \ V /  __/ |  | | (_| | |_| |
#  \___\__,_| \_/ \__,_|      \___/ \_/ \___|_|  |_|\__,_|\__, |
#                                                         |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Script to toggle cava visualization panel on or off
# /!\ : To target a specific monitor, use the --location=id:1 option
# -----------------------------------------------------------------------------------------------------------------------------------------

# Check if any kitty panel processes with cava are running
cava_running=$(pgrep -f "kitty \+kitten panel.*cava" || true)

# Position options.
# For a 1920 x 1080 monitor. (margin top = 900 & margin left = 1520 for a 20 margin at bottom and right).
PANEL_HEIGHT=160
PANEL_WIDTH=380

MARGIN_TOP=900
MARGIN_LEFT=1520


if [ -n "$cava_running" ]; then
    # Kill all running kitty panel cava processes
    pkill -f "kitty \+kitten panel.*cava"
else
    if [ "$1" = "mini" ]; then
        kitty +kitten panel --edge=center --layer=overlay -o background_opacity=0 -o font_size=1 \
                    --margin-top=$MARGIN_TOP --margin-bottom=$((1080 - $MARGIN_TOP - $PANEL_HEIGHT)) \
                    --margin-left=$MARGIN_LEFT --margin-right=$((1920 - $MARGIN_LEFT - $PANEL_WIDTH)) \
                    cava -p $HOME/.config/cava/config_mini &

        if [ "$2" = "title" ]; then
            kitty +kitten panel --edge=center --layer=overlay -o background_opacity=0 -o font_size=11 \
                        --margin-top=$((MARGIN_TOP - 20)) --margin-bottom=$((1080 - $MARGIN_TOP - $PANEL_HEIGHT - 20)) \
                        --margin-left=$MARGIN_LEFT --margin-right=$((1920 - $MARGIN_LEFT - $PANEL_WIDTH)) \
                        python $HOME/.config/hypr/scripts/cava/song_display.py &
        fi
    else
        # No cava panel running, start a new one
        kitty +kitten panel --edge=background -o font_size=5 -o background_opacity=0 cava &
    fi
fi
