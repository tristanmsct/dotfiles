#!/usr/bin/env bash
#           _        _           _                  _
#  ___  ___| |_     | |__   ___ | |_       ___ ___ | | ___  _ __ ___
# / __|/ _ \ __|____| '_ \ / _ \| __|____ / __/ _ \| |/ _ \| '__/ __|
# \__ \  __/ ||_____| | | | (_) | ||_____| (_| (_) | | (_) | |  \__ \
# |___/\___|\__|    |_| |_|\___/ \__|     \___\___/|_|\___/|_|  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Set up state file if necessary.
$DESKTOP_SCRIPTS/system/setup-state.sh

STATE_FILE=$XDG_STATE_HOME/desktop/state.json

COLOR=$(echo $1 | awk -F'#' '{print "#" $2}' | cut -c 1-7)
COLOR_NB=$(echo $1 | grep -o "^[0-9]")

# If focus mode was activated we need to reactivate it after setting the colors.
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)

$DESKTOP_SCRIPTS/theming/apply-theme.sh $COLOR $COLOR_NB &

# Accent colors are stored in a cache files to set them up again at restart.
jq --arg color "$COLOR" --arg color_nb "$COLOR_NB" '
  .theme.accent_color.enabled = true |
  .theme.accent_color.hex = $color |
  .theme.accent_color.index = $color_nb
' "$STATE_FILE" | sponge "$STATE_FILE"

# We need to wait a bit otherwise we reactivate focus mode before the borders are back on.
if $FOCUSMODE_ENABLED; then
  timeout 1.5 sleep 1.5 || true
  $DESKTOP_SCRIPTS/focus-mode/restore.sh
fi

eww close theme-menu-window-closer
eww close theme-menu-window
