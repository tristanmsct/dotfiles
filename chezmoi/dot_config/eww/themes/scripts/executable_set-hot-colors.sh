#!/usr/bin/env bash
#           _        _           _                  _
#  ___  ___| |_     | |__   ___ | |_       ___ ___ | | ___  _ __ ___
# / __|/ _ \ __|____| '_ \ / _ \| __|____ / __/ _ \| |/ _ \| '__/ __|
# \__ \  __/ ||_____| | | | (_) | ||_____| (_| (_) | | (_) | |  \__ \
# |___/\___|\__|    |_| |_|\___/ \__|     \___\___/|_|\___/|_|  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

CONFIG_FILE=$HOME/.local/state/desktop/state.json

COLOR=$(echo $1 | awk -F'#' '{print "#" $2}' | cut -c 1-7)
COLOR_NB=$(echo $1 | grep -o "^[0-9]")

# If focus mode was activated we need to reactivate it after setting the colors.
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

$HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB &

# Accent colors are stored in a cache files to set them up again at restart.
jq --arg color "$COLOR" --arg color_nb "$COLOR_NB" '
  .theme.accent_color.enabled = true |
  .theme.accent_color.hex = $color |
  .theme.accent_color.index = $color_nb
' "$CONFIG_FILE" | sponge "$CONFIG_FILE"

# We need to wait a bit otherwise we reactivate focus mode before the borders are back on.
timeout 0.5 sleep 0.5 || true
if [ "$HYPRGAMEMODE" = 0 ] ; then
    $HOME/.config/hypr/scripts/game-mode/activate.sh quiet
fi

eww close theme-menu-window-closer
eww close theme-menu-window
