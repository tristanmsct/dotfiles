#!/usr/bin/env bash
#           _        _           _                  _
#  ___  ___| |_     | |__   ___ | |_       ___ ___ | | ___  _ __ ___
# / __|/ _ \ __|____| '_ \ / _ \| __|____ / __/ _ \| |/ _ \| '__/ __|
# \__ \  __/ ||_____| | | | (_) | ||_____| (_| (_) | | (_) | |  \__ \
# |___/\___|\__|    |_| |_|\___/ \__|     \___\___/|_|\___/|_|  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

COLOR=$(echo "$1" | awk -F'#' '{print "#" $2}' | cut -c 1-7)
COLOR_NB=$(echo "$1" | grep -o "^[0-9]")

# If focus mode was activated we need to reactivate it after setting the colors.
FOCUSMODE_ENABLED=$(state_get ".focusmode.enabled")

"$DESKTOP_SCRIPTS/theming/apply-theme.sh" "$COLOR" "$COLOR_NB" &

state_set ".theme.accent_color.enabled" true
state_set ".theme.accent_color.hex" "$COLOR"
state_set ".theme.accent_color.index" "$COLOR_NB"

# We need to wait a bit otherwise we reactivate focus mode before the borders are back on.
if "$FOCUSMODE_ENABLED"; then
  timeout 1.5 sleep 1.5 || true
  "$DESKTOP_SCRIPTS/focus-mode/restore.sh"
fi

eww close theme-menu-window-closer
eww close theme-menu-window
