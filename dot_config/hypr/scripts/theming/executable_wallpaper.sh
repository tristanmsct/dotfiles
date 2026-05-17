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

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

STATE_FILE=$HOME/.local/state/desktop/state.json
CACHE_FILE="$HOME/.local/state/desktop/wallpaper"

# ---------------------------------------------------------------------------------------
# Get selected wallpaper
# ---------------------------------------------------------------------------------------

WALLPAPER=$1

# When changing wallpaper, the accent-color cache file need to be reset, otherwise
# accent colors from previous wallpapers might get mixed.
if [ ! "$WALLPAPER" = "$(cat $CACHE_FILE)" ]; then
    jq 'del(.theme.accent_color.hex)' "$STATE_FILE" | sponge "$STATE_FILE"
    jq 'del(.theme.accent_color.index)' "$STATE_FILE" | sponge "$STATE_FILE"
    jq '.theme.accent_color.enabled = false' "$STATE_FILE" | sponge "$STATE_FILE"
fi
echo "$WALLPAPER" > $CACHE_FILE

# ---------------------------------------------------------------------------------------
# Execute Wallust
# ---------------------------------------------------------------------------------------

wallust run "$WALLPAPER" --skip-sequences

# ---------------------------------------------------------------------------------------
# Restore border config
# ---------------------------------------------------------------------------------------

BORDER_MAIN=$(jq '.theme.border_main' $STATE_FILE)
BORDER_DECORATIONS=$(jq '.theme.border_decorations' $STATE_FILE)

if [ $BORDER_MAIN = "false" ]; then
    "$HOME/.config/eww/themes/scripts/switch-borders.sh" true
fi

if [ $BORDER_DECORATIONS = "false" ]; then
    "$HOME/.config/eww/themes/scripts/switch-borders-decorations.sh" true
fi

# ---------------------------------------------------------------------------------------
# Apply created theme
# ---------------------------------------------------------------------------------------

# Should cover all basis.
# At boot or when refreshing waypapr (meta + W) if an accent color was selected, the cache file will be here, otherwise it will not exist.
# When switching wallpaper, the cache file is deleted right before so no problem.
ACCENT_COLOR_STATUS=$(jq '.theme.accent_color.enabled' $STATE_FILE)

if [ $ACCENT_COLOR_STATUS = "true" ]; then
    # If there was accent colors cached, then we re-apply them.
    COLOR=$(jq -r '.theme.accent_color.hex' $STATE_FILE)
    COLOR_NB=$(jq -r '.theme.accent_color.index' $STATE_FILE)

    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB
else
    $HOME/.config/hypr/scripts/theming/apply-theme.sh
fi

# Remove any custom saturation.
jq '.theme.saturation.enabled = false' $STATE_FILE | sponge $STATE_FILE
jq 'del(.theme.saturation.level)' $STATE_FILE | sponge $STATE_FILE
