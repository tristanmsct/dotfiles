#!/usr/bin/env bash
#          _     _
#  ___  __| | __| |_ __ ___
# / __|/ _` |/ _` | '_ ` _ \
# \__ \ (_| | (_| | | | | | |
# |___/\__,_|\__,_|_| |_| |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

WALLPAPER=$1
COLOR=$2

# Being careful with .png, .jpg. etc.
extension="${WALLPAPER##*.}"

sddm_theme_name="eucalyptus-drop"
sddm_asset_folder="/usr/share/sddm/themes/$sddm_theme_name/Backgrounds"

# Changing the SDDM wallpaper with the new one.
sudo rm $sddm_asset_folder/current_wallpaper.*
sudo cp $WALLPAPER $sddm_asset_folder/current_wallpaper.$extension

# Adding the SDDM template and replacing the wallpaper and accent color.

export CURRENTWALLPAPER="current_wallpaper.$extension"
export ACCENTCOLOR="$COLOR"
envsubst '${CURRENTWALLPAPER} ${ACCENTCOLOR}' \
  < "$HOME/.config/sddm-themes/theme-eucalyptus-drop.template" \
  | sudo tee /usr/share/sddm/themes/$sddm_theme_name/theme.conf > /dev/null
