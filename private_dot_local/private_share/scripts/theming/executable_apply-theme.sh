#!/usr/bin/env bash
#                    _             _   _
#   __ _ _ __  _ __ | |_   _      | |_| |__   ___ _ __ ___   ___
#  / _` | '_ \| '_ \| | | | |_____| __| '_ \ / _ \ '_ ` _ \ / _ \
# | (_| | |_) | |_) | | |_| |_____| |_| | | |  __/ | | | | |  __/
#  \__,_| .__/| .__/|_|\__, |      \__|_| |_|\___|_| |_| |_|\___|
#       |_|   |_|      |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Change the color of the terminal based on the main colors of the wallpaper.
# -----------------------------------------------------------------------------------------------------------------------------------------

# The script can run with or without arguments. Without arguments, the first color in the theme will be used unless it is too grey.
# See python script for more details.

# Wallust can be slightly slower than this script and changes later can be overwritten by wallust.
# A short sleep helps with that issue. Maybe its time to use the rust version.
sleep 0.2

# Set up state file if necessary.
"$DESKTOP_SCRIPTS/system/setup-state.sh"

script_name=$(basename "$0")

WALLPAPER=$(cat "$XDG_STATE_HOME/desktop/wallpaper")

source "$DESKTOP_SCRIPTS/system/state-utils"
THEME_TYPE=$(state_get ".theme.mode")

# Import the apply_accent_colors function to be run later.
source "$DESKTOP_SCRIPTS/theming/apply-accent-colors.sh"

COLOR=${1:-"DEFAULT"}
COLOR_NB=${2:-"1"}
read -r icons_color theme_color _ <<< "$(python "$DESKTOP_SCRIPTS/theming/convert_colors.py" -c "$COLOR" -d)"

ACCENT_COLOR=$(sed -n "${COLOR_NB}p" "$XDG_STATE_HOME/desktop/colors")

logger -t theming -p user.info "[$script_name] Setting up theme with accent color $COLOR_NB ($icons_color)"

# ---------------------------------------------------------------------------------------
# Applying theme to Icons and GTK applications
# ---------------------------------------------------------------------------------------

apply_gtk_theme "$THEME_TYPE" "$theme_color" "$icons_color"

# ---------------------------------------------------------------------------------------
# SDDM
# ---------------------------------------------------------------------------------------

apply_sddm_theme "$WALLPAPER" "$ACCENT_COLOR"

# ---------------------------------------------------------------------------------------
# Enhancing wallust themes and applying dark and light variant
# ---------------------------------------------------------------------------------------

apply_accent_colors "$THEME_TYPE" "$ACCENT_COLOR"

# ---------------------------------------------------------------------------------------
# Refreshing apps
# ---------------------------------------------------------------------------------------

refresh_applications
