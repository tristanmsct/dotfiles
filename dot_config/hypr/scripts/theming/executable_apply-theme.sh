#!/usr/bin/env bash
#                    _         _   _
#   __ _ _ __  _ __ | |_   _  | |_| |__   ___ _ __ ___   ___
#  / _` | '_ \| '_ \| | | | | | __| '_ \ / _ \ '_ ` _ \ / _ \
# | (_| | |_) | |_) | | |_| | | |_| | | |  __/ | | | | |  __/
#  \__,_| .__/| .__/|_|\__, |  \__|_| |_|\___|_| |_| |_|\___|
#       |_|   |_|      |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Change the color of the terminal based on the main colors of the wallpaper.
# -----------------------------------------------------------------------------------------------------------------------------------------

# The script can run with or without arguments. Without arguments, the first color in the theme will be used unless it is too grey.
# See python script for more details.

# Pywal can be slightly slower than this script and changes later can be overwritten by pywal.
# A short sleep helps with that issue. Maybe its time to use the rust version.
sleep 0.2

# Set up state file if necessary.
$HOME/.config/hypr/scripts/system/setup-state.sh

STATE_FILE=$HOME/.local/state/desktop/state.json
THEME_TYPE=$(jq -r '.theme.mode' $STATE_FILE)

# Import enhance_templates
source $HOME/.config/hypr/scripts/theming/pywal-enhance.sh

COLOR=${1:-"DEFAULT"}
COLOR_NB=${2:-"1"}
read icons_color theme_color _ <<< $(python $HOME/.config/hypr/scripts/theming/convert_colors.py -c $COLOR -d)

COLOR_NB_INC=$((COLOR_NB + 1))
WAL_COLOR=$(sed -n "${COLOR_NB_INC}p" $HOME/.cache/wal/colors)

read saturated_color <<< $(python $HOME/.config/hypr/scripts/theming/increase_saturation.py -c $WAL_COLOR -t rgba -s 0.2)

# ---------------------------------------------------------------------------------------
# Applying theme to Icons and GTK applications
# ---------------------------------------------------------------------------------------

if [ $THEME_TYPE = "dark" ]; then
    theme_color+="-Dark"
else
    theme_color+="-Light"
fi

# Setting general themes.
sed -i "s/^icon-theme=.*$/icon-theme=Tela-circle-${icons_color}/" $HOME/.local/share/nwg-look/gsettings
sed -i "s|^gtk-theme=.*$|gtk-theme=Orchis-${theme_color}-Compact|" $HOME/.local/share/nwg-look/gsettings
sed -i "s|^font-name=.*$|font-name=Cantarell 11|" $HOME/.local/share/nwg-look/gsettings
sed -i "s|^cursor-theme=.*$|cursor-theme=Vimix-white-cursors|" $HOME/.local/share/nwg-look/gsettings

GTK2_RC_FILES="$HOME"/.config/gtk-2.0/gtkrc nwg-look -a -x

# The gtk-4.0 part has to be done by hand. the `nwg-look -a -x` command can only find themes in $HOME/.themes
# although running the nwg-look utility from the terminal does not have this issue.
# Might be able to delete that if this is ever fixed, anyway, all the tool does is create the symlinks as I do it manually.
rm "$HOME/.config/gtk-4.0/assets"
rm "$HOME/.config/gtk-4.0/gtk-dark.css"
rm "$HOME/.config/gtk-4.0/gtk.css"

ln -sf /usr/share/themes/Orchis-${theme_color}-Compact/gtk-4.0/assets "$HOME/.config/gtk-4.0/assets"
ln -sf /usr/share/themes/Orchis-${theme_color}-Compact/gtk-4.0/gtk-dark.css "$HOME/.config/gtk-4.0/gtk-dark.css"
ln -sf /usr/share/themes/Orchis-${theme_color}-Compact/gtk-4.0/gtk.css "$HOME/.config/gtk-4.0/gtk.css"

if [ $THEME_TYPE = "dark" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    sed -i "s|color_scheme_path=/usr/share/qt6ct/colors/.*.conf|color_scheme_path=/usr/share/qt6ct/colors/darker.conf|" $HOME/.config/qt6ct/qt6ct.conf
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    sed -i "s|color_scheme_path=/usr/share/qt6ct/colors/.*.conf|color_scheme_path=/usr/share/qt6ct/colors/airy.conf|" $HOME/.config/qt6ct/qt6ct.conf
fi

# Then nextcloud and repo directories get a specific folder icon in the current theme.
gio set $HOME/Nextcloud metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-cloud.svg"
gio set $HOME/Media/Movies metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-video.svg"
gio set $HOME/Media/Series metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-video.svg"
gio set $HOME/Media/Games metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-games.svg"

# Getting all repos
# Main repo, config files and such.
lst_repos=("$HOME/.local/share/dotfiles")
lst_repos+=("$HOME/.local/share/ansible-archlinux")

# The main hub for repos.
base_repos="$HOME/Nextcloud/02-Projets/01-Repos"
public_repos="$HOME/Nextcloud/02-Projets/02-Public"
aur_repos="$HOME/.local/share/aur"

# Add base repos
if [[ -d "$base_repos" ]]; then
    readarray -t base_dirs < <(ls -1d "$base_repos"/*/ 2>/dev/null)
    lst_repos+=("${base_dirs[@]}")
fi

# Add public repos
if [[ -d "$public_repos" ]]; then
    readarray -t public_dirs < <(ls -1d "$public_repos"/*/ 2>/dev/null)
    lst_repos+=("${public_dirs[@]}")
fi

# Add aur repos
if [[ -d "$aur_repos" ]]; then
    readarray -t base_dirs < <(ls -1d "$aur_repos"/*/ 2>/dev/null)
    lst_repos+=("${base_dirs[@]}")
fi

# Other repos.
lst_repos+=("$HOME/Nextcloud/01-Travail/05-OpenClassrooms/01-OC_Projets"
    "$HOME/Nextcloud/01-Travail/05-OpenClassrooms/98-OC_Manager")

for repo in ${lst_repos[@]}; do
    gio set "$repo" metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-git.svg"
done

gio set "$HOME/Media" metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder_color_default_pictures.svg"

# Forces nautilus to reload its theme, otherwise the icon are changed but not orchis theme.
pkill -f nautilus

# ---------------------------------------------------------------------------------------
# SDDM
# ---------------------------------------------------------------------------------------

WALLPAPER=$(cat $HOME/.cache/wallpaper/current_wallpaper)
$HOME/.config/hypr/scripts/theming/sddm.sh $WALLPAPER $WAL_COLOR

# ---------------------------------------------------------------------------------------
# Enhancing pywal themes and applying dark and light variant
# ---------------------------------------------------------------------------------------

enhance_templates

hyprctl reload
eww reload

# ---------------------------------------------------------------------------------------
# Dunst
# ---------------------------------------------------------------------------------------

export COLOR_FRAME=$WAL_COLOR
envsubst < "$HOME/.config/dunst/dunstrc.template" > "$HOME/.config/dunst/dunstrc"

pkill dunst
dunstctl reload

# ---------------------------------------------------------------------------------------
# Cava
# ---------------------------------------------------------------------------------------

colors=($(sed -n '2,8p' "$HOME/.cache/wal/colors"))
export COLOR1="${colors[0]}"
export COLOR2="${colors[1]}"
export COLOR3="${colors[2]}"
export COLOR4="${colors[3]}"
export COLOR5="${colors[4]}"
export COLOR6="${colors[5]}"
export COLOR7="${colors[6]}"
export COLOR="${WAL_COLOR}"

envsubst < "$HOME/.config/cava/templates/config.template" > "$HOME/.config/cava/config"
envsubst < "$HOME/.config/cava/templates/config_mini.template" > "$HOME/.config/cava/config_mini"

# Live reload config
if pgrep -f "kitty.*kitten.*panel.*cava" > /dev/null; then
    pkill -SIGUSR1 cava
    pkill -USR1 -f song_display.py
fi

# ---------------------------------------------------------------------------------------
# Clock overlay
# ---------------------------------------------------------------------------------------

if pgrep -f "isthataclock.py" > /dev/null; then
    pkill -USR1 -f isthataclock.py
fi

# ---------------------------------------------------------------------------------------
# Clock overlay
# ---------------------------------------------------------------------------------------


