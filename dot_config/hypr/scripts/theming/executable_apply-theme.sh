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
$HOME/.config/hypr/scripts/system/setup-state.sh

WALLPAPER=$(cat $HOME/.local/state/desktop/wallpaper)

STATE_FILE=$HOME/.local/state/desktop/state.json
THEME_TYPE=$(jq -r '.theme.mode' $STATE_FILE)

# Import the apply_accent_colors function to be run later.
source $HOME/.config/hypr/scripts/theming/apply-accent-colors.sh

COLOR=${1:-"DEFAULT"}
COLOR_NB=${2:-"1"}
read icons_color theme_color _ <<< $(python $HOME/.config/hypr/scripts/theming/convert_colors.py -c $COLOR -d)

WAL_COLOR=$(sed -n "${COLOR_NB}p" $HOME/.local/state/desktop/colors)

# ---------------------------------------------------------------------------------------
# Applying theme to Icons and GTK applications
# ---------------------------------------------------------------------------------------

apply_gtk_theme

# ---------------------------------------------------------------------------------------
# SDDM
# ---------------------------------------------------------------------------------------

apply_sddm_theme

# ---------------------------------------------------------------------------------------
# Enhancing wallust themes and applying dark and light variant
# ---------------------------------------------------------------------------------------

apply_accent_colors

# ---------------------------------------------------------------------------------------
# Refreshing apps
# ---------------------------------------------------------------------------------------

refresh_applications
