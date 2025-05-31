#!/bin/bash
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

COLOR=${1:-"DEFAULT"}
COLOR_NB=${2:-"1"}
read icons_color theme_color _ <<< $(python $HOME/.config/hypr/scripts/theming/convert_colors.py -c $COLOR -d)

COLOR_NB_INC=$((COLOR_NB + 1))
WAL_COLOR=$(sed -n "${COLOR_NB_INC}p" $HOME/.cache/wal/colors)

read saturated_color <<< $(python $HOME/.config/hypr/scripts/theming/increase_saturation.py -c $WAL_COLOR -t rgba)

theme_type="dark"
if [ -f $HOME/.cache/theme-light-dark ]; then
    theme_type=$(cat $HOME/.cache/theme-light-dark)
fi

# ---------------------------------------------------------------------------------------
# Applying theme to Icons and GTK applications
# ---------------------------------------------------------------------------------------

if [ $theme_type = "dark" ]; then
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

# The gtk-4.0 part has to be done by hand. the `nwg-look -a -x` command can only find themes in ~/.themes
# although running the nwg-look utility from the terminal does not have this issue.
# Might be able to delete that if this is ever fixed, anyway, all the tool does is create the symlinks as I do it manually.
rm "$HOME/.config/gtk-4.0/assets"
rm "$HOME/.config/gtk-4.0/gtk-dark.css"
rm "$HOME/.config/gtk-4.0/gtk.css"

ln -sf /usr/share/themes/Orchis-${theme_color}-Compact/gtk-4.0/assets "$HOME/.config/gtk-4.0/assets"
ln -sf /usr/share/themes/Orchis-${theme_color}-Compact/gtk-4.0/gtk-dark.css "$HOME/.config/gtk-4.0/gtk-dark.css"
ln -sf /usr/share/themes/Orchis-${theme_color}-Compact/gtk-4.0/gtk.css "$HOME/.config/gtk-4.0/gtk.css"

if [ $theme_type = "dark" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    sed -i "s|color_scheme_path=/usr/share/qt6ct/colors/.*.conf|color_scheme_path=/usr/share/qt6ct/colors/darker.conf|" $HOME/.config/qt6ct/qt6ct.conf
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    sed -i "s|color_scheme_path=/usr/share/qt6ct/colors/.*.conf|color_scheme_path=/usr/share/qt6ct/colors/airy.conf|" $HOME/.config/qt6ct/qt6ct.conf
fi

# Then nextcloud and repo directories get a specific folder icon in the current theme.
gio set $HOME/Nextcloud metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-cloud.svg"

source $HOME/.local/bin/get-repo-list

for repo in ${lst_repos[@]}; do
    gio set "$repo" metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-git.svg"
done

gio set "$HOME/Media" metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder_color_default_pictures.svg"

# Forces nautilus to reload its theme, otherwise the icon are changed but not orchis theme.
pkill -f nautilus

# ---------------------------------------------------------------------------------------
# Theming the cursor
# ---------------------------------------------------------------------------------------

if [ $theme_type = "dark" ]; then
    hyprctl setcursor Vimix-white-cursors 40
else
    hyprctl setcursor Vimix-cursors 40
fi

# ---------------------------------------------------------------------------------------
# Applying theme to common css files for Rofi, NWG, Dunst and EWW
# ---------------------------------------------------------------------------------------

# ROFI.
cp $HOME/.config/hypr/settings/templates/common.rasi.tpl $HOME/.config/hypr/settings/style/common.rasi
sed -i "s/<MAIN COLOR>/@color$COLOR_NB/g" "$HOME/.config/hypr/settings/style/common.rasi"
sed -i "s/<MAIN COLOR TRANSPARENT>/@color$COLOR_NB-tr/g" "$HOME/.config/hypr/settings/style/common.rasi"

if [ $theme_type = "dark" ]; then
    sed -i "s/<TEXT COLOR>/#eeeeee/g" "$HOME/.config/hypr/settings/style/common.rasi"
    sed -i "s/<BG COLOR>/rgba(0, 0, 0, 0.4)/g" "$HOME/.config/hypr/settings/style/common.rasi"
else
    sed -i "s/<TEXT COLOR>/#000000/g" "$HOME/.config/hypr/settings/style/common.rasi"
    sed -i "s/<BG COLOR>/rgba(230, 230, 230, 0.2)/g" "$HOME/.config/hypr/settings/style/common.rasi"
fi

# NWG, Dunst, hyprland windows.
cp $HOME/.config/hypr/settings/templates/common.css.tpl $HOME/.config/hypr/settings/style/common.css
sed -i "s/<MAIN COLOR>/@color$COLOR_NB/g" "$HOME/.config/hypr/settings/style/common.css"

if [ $theme_type = "dark" ]; then
    sed -i "s/<TEXT COLOR>/#eeeeee/g" "$HOME/.config/hypr/settings/style/common.css"
    sed -i "s/<BG COLOR>/rgba(0, 0, 0, 0.4)/g" "$HOME/.config/hypr/settings/style/common.css"
else
    sed -i "s/<TEXT COLOR>/#000000/g" "$HOME/.config/hypr/settings/style/common.css"
    sed -i "s/<BG COLOR>/rgba(230, 230, 230, 0.4)/g" "$HOME/.config/hypr/settings/style/common.css"
fi

# Can't use a tmp file as intermediary here, it causes a nasty error message.
sed -i -E 's/\$color[0-9]/\$color'"$COLOR_NB"'/g' "$HOME/.config/hypr/conf/windows.conf"
sed -i -E 's/\$colort[0-9]/\$colort'"$COLOR_NB"'/g' "$HOME/.config/hypr/conf/windows.conf"
hyprctl reload

cp $HOME/.config/dunst/dunstrc.tpl $HOME/.config/dunst/dunstrc
sed -i "s/<COLOR_FRAME>/$WAL_COLOR/" "$HOME/.config/dunst/dunstrc"
pkill dunst
dunstctl reload

# EWW.
cp $HOME/.config/hypr/settings/templates/common.scss.tpl $HOME/.config/hypr/settings/style/common.scss
sed -i "s/<MAIN COLOR>/\$color$COLOR_NB/g" "$HOME/.config/hypr/settings/style/common.scss"
if [ $theme_type = "dark" ]; then
    sed -i "s/<TEXT COLOR>/#eeeeee/g" "$HOME/.config/hypr/settings/style/common.scss"
    sed -i "s/<BG COLOR>/rgba(0, 0, 0, 0.4)/g" "$HOME/.config/hypr/settings/style/common.scss"
else
    sed -i "s/<TEXT COLOR>/#000000/g" "$HOME/.config/hypr/settings/style/common.scss"
    sed -i "s/<BG COLOR>/rgba(230, 230, 230, 0.4)/g" "$HOME/.config/hypr/settings/style/common.scss"
fi

eww reload

# ---------------------------------------------------------------------------------------
# Reload Waybar style
# ---------------------------------------------------------------------------------------

# No need to restart waybar, the reload_style_on_change can be used in its config file.
# pkill waybar
# $HOME/.config/hypr/scripts/waybar/launch.sh

cp $HOME/.config/waybar/templates/style.css.tpl $HOME/.config/waybar/style.css
sed -i "s/<MAIN COLOR>/@color$COLOR_NB/g" "$HOME/.config/waybar/style.css"

if [ $theme_type = "dark" ]; then
    sed -i "s/segment-dark rgba(160, 160, 160, 0.7)/segment-dark rgba(0, 0, 0, 0.7)/g" "$HOME/.config/waybar/style.css"
    sed -i "s/segment-light rgba(160, 160, 160, 0.4)/segment-light rgba(0, 0, 0, 0.4)/g" "$HOME/.config/waybar/style.css"
    sed -i "s/border-overlay rgba(160, 160, 160, 0.5)/border-overlay rgba(0, 0, 0, 0.5)/g" "$HOME/.config/waybar/style.css"

    sed -i "s/workspace_bg rgba(210, 210, 210, 0.6)/workspace_bg rgba(0, 0, 0, 0.6)/g" "$HOME/.config/waybar/style.css"
    sed -i "s/workspace_fg @background/workspace_fg @foreground/g" "$HOME/.config/waybar/style.css"

    sed -i "s/color: <TEXT COLOR>;/color: @foreground;/g" "$HOME/.config/waybar/style.css"
else
    sed -i "s/segment-dark rgba(0, 0, 0, 0.7)/segment-dark rgba(160, 160, 160, 0.7)/g" "$HOME/.config/waybar/style.css"
    sed -i "s/segment-light rgba(0, 0, 0, 0.4)/segment-light rgba(160, 160, 160, 0.4)/g" "$HOME/.config/waybar/style.css"
    sed -i "s/border-overlay rgba(0, 0, 0, 0.5)/border-overlay rgba(160, 160, 160, 0.5)/g" "$HOME/.config/waybar/style.css"

    sed -i "s/workspace_bg rgba(0, 0, 0, 0.6)/workspace_bg rgba(210, 210, 210, 0.6)/g" "$HOME/.config/waybar/style.css"
    sed -i "s/workspace_fg @foreground/workspace_fg @background/g" "$HOME/.config/waybar/style.css"

    sed -i "s/color: <TEXT COLOR>;/color: @background;/g" "$HOME/.config/waybar/style.css"
fi

# ---------------------------------------------------------------------------------------
# SDDM
# ---------------------------------------------------------------------------------------

WALLPAPER=$(cat $HOME/.cache/wallpaper/current_wallpaper)
$HOME/.config/hypr/scripts/theming/sddm.sh $WALLPAPER $WAL_COLOR

# ---------------------------------------------------------------------------------------
# wLogout
# ---------------------------------------------------------------------------------------

if [ $theme_type = "dark" ]; then
    sed -i "s/color: #000000;/color: #FFFFFF;/" $HOME/.config/wlogout/style.css
    sed -i "s/background-color: rgba(210, 210, 210, 0.7);/background-color: rgba(12, 12, 12, 0.7);/" $HOME/.config/wlogout/style.css
    sed -i "s/-light.png/-dark.png/" $HOME/.config/wlogout/style.css
else
    sed -i "s/color: #FFFFFF;/color: #000000;/" $HOME/.config/wlogout/style.css
    sed -i "s/background-color: rgba(12, 12, 12, 0.7);/background-color: rgba(210, 210, 210, 0.7);/" $HOME/.config/wlogout/style.css
    sed -i "s/-dark.png/-light.png/" $HOME/.config/wlogout/style.css
fi

# ---------------------------------------------------------------------------------------
# Cava
# ---------------------------------------------------------------------------------------

cp $HOME/.config/cava/templates/config.tpl $HOME/.config/cava/config
cp $HOME/.config/cava/templates/config_mini.tpl $HOME/.config/cava/config_mini

colors=($(sed -n '2,8p' ~/.cache/wal/colors))
for i in {1..7}; do
    sed -i "s/<COLOR$i>/'${colors[$((i-1))]}'/" "$HOME/.config/cava/config"
    sed -i "s/<COLOR$i>/'${colors[$((i-1))]}'/" "$HOME/.config/cava/config_mini"
done
sed -i "s/<COLOR>/'$WAL_COLOR'/" "$HOME/.config/cava/config"
sed -i "s/<COLOR>/'$WAL_COLOR'/" "$HOME/.config/cava/config_mini"

# Live reload config
if pgrep -f "kitty.*kitten.*panel.*cava" > /dev/null; then
    pkill -SIGUSR1 cava
    pkill -USR1 -f song_display.py
fi

# ---------------------------------------------------------------------------------------
# Clock overlay
# ---------------------------------------------------------------------------------------

if pgrep -f "isthataclock.py" > /dev/null; then
    dunstify "hello"
    pkill -USR1 -f isthataclock.py
fi
