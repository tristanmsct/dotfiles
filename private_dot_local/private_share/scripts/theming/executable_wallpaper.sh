#!/usr/bin/env bash
#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------
# Set defaults
# ---------------------------------------------------------------------------------------

source "$DESKTOP_SCRIPTS/system/state-utils"

WALLPAPER_FILE="$XDG_STATE_HOME/desktop/wallpaper"

# ---------------------------------------------------------------------------------------
# Get selected wallpaper
# ---------------------------------------------------------------------------------------

WALLPAPER="$1"

# When changing wallpaper, the accent-color cache file need to be reset, otherwise
# accent colors from previous wallpapers might get mixed.
if [ ! "$WALLPAPER" = "$(cat "$WALLPAPER_FILE")" ]; then
    state_del ".theme.accent_color.hex"
    state_del ".theme.accent_color.index"
    state_set ".theme.accent_color.enabled" false
fi
echo "$WALLPAPER" > "$WALLPAPER_FILE"

# ---------------------------------------------------------------------------------------
# Execute Wallust
# ---------------------------------------------------------------------------------------

wallust run "$WALLPAPER" --skip-sequences

# ---------------------------------------------------------------------------------------
# Restore border config
# ---------------------------------------------------------------------------------------

BORDER_MAIN=$(state_get ".theme.border_main")
BORDER_DECORATIONS=$(state_get ".theme.border_decorations")

if [ "$BORDER_MAIN" = "false" ]; then
    "$XDG_CONFIG_HOME/eww/themes/scripts/switch-borders.sh" true
fi

if [ "$BORDER_DECORATIONS" = "false" ]; then
    "$XDG_CONFIG_HOME/eww/themes/scripts/switch-borders-decorations.sh" true
fi

# ---------------------------------------------------------------------------------------
# Apply created theme
# ---------------------------------------------------------------------------------------

# Should cover all basis.
# At boot or when refreshing waypapr (meta + W) if an accent color was selected, the cache file will be here, otherwise it will not exist.
# When switching wallpaper, the cache file is deleted right before so no problem.
ACCENT_COLOR_STATUS=$(state_get ".theme.accent_color.enabled")

if [ "$ACCENT_COLOR_STATUS" = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(state_get ".theme.accent_color.hex")
    COLOR_NB=$(state_get ".theme.accent_color.index")

    "$DESKTOP_SCRIPTS/theming/apply-theme.sh" "$COLOR" "$COLOR_NB"
else
    "$DESKTOP_SCRIPTS/theming/apply-theme.sh"
fi

# Remove any custom saturation.
state_set ".theme.saturation.enabled" false
state_del ".theme.saturation.level"
