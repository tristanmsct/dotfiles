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

force_generate=0
cache_directory="$HOME/.cache/wallpaper"
cache_file="$cache_directory/current_wallpaper"
square_wallpaper="$cache_directory/square_wallpaper.png"
blurred_wallpaper="$cache_directory/blurred_wallpaper.png"

if [ ! -d $cache_directory ]; then
    mkdir $cache_directory
fi

# ---------------------------------------------------------------------------------------
# Get selected wallpaper
# ---------------------------------------------------------------------------------------

if [ -z $1 ]; then
    wallpaper=$(cat $cache_file)
else
    wallpaper=$1
fi

# When changing wallpaper, the accent-color cache file need to be reset, otherwise
# accent colors from previous wallpapers might get mixed.
if ! [ "$wallpaper" = "$(cat $cache_file)" ]; then
    rm $HOME/.cache/accent-color
fi

echo ":: Setting wallpaper with source image $wallpaper"

if [ ! -f $cache_file ]; then
    touch $cache_file
fi
echo "$wallpaper" > $cache_file
echo ":: Path of current wallpaper copied to $cache_file"

wallpaperfilename=$(basename $wallpaper)
echo ":: Wallpaper Filename: $wallpaperfilename"

# ---------------------------------------------------------------------------------------
# Execute pywal
# ---------------------------------------------------------------------------------------

$HOME/.config/hypr/scripts/theming/create-theme.sh $wallpaper

# ---------------------------------------------------------------------------------------
# Apply created theme
# ---------------------------------------------------------------------------------------

# Changing folders / directories icons
source "$HOME/.cache/wal/colors.sh"

# Should cover all basis.
# At boot or when refreshing waypapr (meta + W) if an accent color was selected, the cache file will be here, otherwise it will not exist.
# When switching wallpaper, the cache file is deleted right before so no problem.
if [ -f $HOME/.cache/accent-color ]; then
    # If there was accent colors cached, then we re-apply them.
    read -r COLOR < ~/.cache/accent-color
    read -r COLOR_NB < <(sed -n '2p' ~/.cache/accent-color)

    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB
else
    $HOME/.config/hypr/scripts/theming/apply-theme.sh
fi

# Remove any custom saturation
[ -f "~/.cache/saturation" ] || rm ~/.cache/saturation

# ---------------------------------------------------------------------------------------
# Created specific wallpapers
# ---------------------------------------------------------------------------------------

magick $wallpaper -resize 75% $blurred_wallpaper
magick $blurred_wallpaper -blur "50x30" $blurred_wallpaper
magick $wallpaper -gravity Center -extent 1:1 $square_wallpaper
