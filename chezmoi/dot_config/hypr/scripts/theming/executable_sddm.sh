#!/bin/bash
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
rm $sddm_asset_folder/current_wallpaper.*
cp $WALLPAPER $sddm_asset_folder/current_wallpaper.$extension

# Adding the SDDM template and replacing the wallpaper and accent color.
sddm_theme_tpl="$HOME/.config/hypr/sddm/theme-eucalyptus-drop.tpl"
cp $sddm_theme_tpl /usr/share/sddm/themes/$sddm_theme_name/theme.conf
sed -i 's/CURRENTWALLPAPER/'"current_wallpaper.$extension"'/' /usr/share/sddm/themes/$sddm_theme_name/theme.conf

sed -i 's/ACCENTCOLOR/'"$COLOR"'/' /usr/share/sddm/themes/$sddm_theme_name/theme.conf
