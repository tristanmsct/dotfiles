#!/usr/bin/env bash
#                    _                                      _                  _
#   __ _ _ __  _ __ | |_   _        __ _  ___ ___ ___ _ __ | |_       ___ ___ | | ___  _ __ ___
#  / _` | '_ \| '_ \| | | | |_____ / _` |/ __/ __/ _ \ '_ \| __|____ / __/ _ \| |/ _ \| '__/ __|
# | (_| | |_) | |_) | | |_| |_____| (_| | (_| (_|  __/ | | | ||_____| (_| (_) | | (_) | |  \__ \
#  \__,_| .__/| .__/|_|\__, |      \__,_|\___\___\___|_| |_|\__|     \___\___/|_|\___/|_|  |___/
#       |_|   |_|      |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

apply_accent_colors () {

    if [ $THEME_TYPE = "dark" ]; then
        hyprctl setcursor Vimix-white-cursors 40
        sed -i "s/-light.png/-dark.png/" $HOME/.config/wlogout/colors-wlogout.css

        BG_COLOR="rgba(0, 0, 0, 0.4)"
        TXT_COLOR="#eeeeee"
    else
        hyprctl setcursor Vimix-cursors 40
        sed -i "s/-dark.png/-light.png/" $HOME/.config/wlogout/colors-wlogout.css

        BG_COLOR="rgba(230, 230, 230, 0.4)"
        TXT_COLOR="#000000"
    fi

    # Hyprland
    sed -i -E "s/(accent_color = color_)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/hypr/conf/colors-hyprland.lua
    sed -i -E "s/(highlight_color = color_br_)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/hypr/conf/colors-hyprland.lua
    sed -i -E "s/(accent_color_transparent = color_tr_)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/hypr/conf/colors-hyprland.lua

    # Rofi
    sed -i -E "s/(accent-color: @color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/rofi/colors-rofi.rasi
    sed -i -E "s/(accent-color-transparent: @color-tr-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/rofi/colors-rofi.rasi
    sed -i -E "s/(background: )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/rofi/colors-rofi.rasi
    sed -i -E "s/(foreground: )#.{6}/\1$TXT_COLOR/" $HOME/.config/rofi/colors-rofi.rasi

    # NWG Drawer
    sed -i -E "s/(accent-color @color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/nwg-drawer/colors-nwg.css
    sed -i -E "s/(highlight-color @color-br-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/nwg-drawer/colors-nwg.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/nwg-drawer/colors-nwg.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.config/nwg-drawer/colors-nwg.css

    # NWG Panel
    sed -i -E "s/(accent-color @color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/nwg-panel/colors-nwg.css
    sed -i -E "s/(highlight-color @color-br-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/nwg-panel/colors-nwg.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/nwg-panel/colors-nwg.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.config/nwg-panel/colors-nwg.css

    # NMRS
    sed -i -E "s/(accent-color @color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/nmrs/colors-nmrs.css
    sed -i -E "s/(highlight-color @color-br-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/nmrs/colors-nmrs.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/nmrs/colors-nmrs.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.config/nmrs/colors-nmrs.css

    # Waybar
    sed -i -E "s/(accent-color @color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/waybar/colors-waybar.css
    sed -i -E "s/(highlight-color @color-br-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/waybar/colors-waybar.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/waybar/colors-waybar.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.config/waybar/colors-waybar.css

    # Waypaper
    sed -i -E "s/(accent-color @color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/waypaper/colors-waypaper.css
    sed -i -E "s/(highlight-color @color-br-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/waypaper/colors-waypaper.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/waypaper/colors-waypaper.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.config/waypaper/colors-waypaper.css

    # SCSS / EWW
    sed -i -E "s/(\\\$accent-color: \\\$color-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/eww/colors-eww.scss
    sed -i -E "s/(\\\$highlight-color: \\\$color-br-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/eww/colors-eww.scss
    sed -i -E "s/(\\\$accent-color-transparent: \\\$color-tr-)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.config/eww/colors-eww.scss
    sed -i -E "s/(\\\$background-theme: )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/eww/colors-eww.scss
    sed -i -E "s/(\\\$foreground-theme: )#.{6}/\1$TXT_COLOR/" $HOME/.config/eww/colors-eww.scss

    # WLogout
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.config/wlogout/colors-wlogout.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.config/wlogout/colors-wlogout.css

    # Dunst
    export COLOR_FRAME=$WAL_COLOR
    envsubst < "$HOME/.config/dunst/dunstrc.template" > "$HOME/.config/dunst/dunstrc"

    # Cava
    colors=($(sed -n '1,7p' "$HOME/.local/state/desktop/colors"))
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
}

apply_gtk_theme () {
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
    gio set $HOME/Downloads metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder-downloads.svg"
    gio set $HOME/Documents metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder-documents.svg"
    gio set $HOME/Documents/Desktop metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder-desktop.svg"
    gio set $HOME/Documents/Public metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder-public.svg"
    gio set $HOME/Documents/Templates metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/folder-templates.svg"
    gio set $HOME/Media/Movies metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-video.svg"
    gio set $HOME/Media/Series metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-video.svg"
    gio set $HOME/Media/Games metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-games.svg"
    gio set $HOME/Media/Music metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-music.svg"
    gio set $HOME/Media/Pictures metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-pictures.svg"
    gio set $HOME/Media/Videos metadata::custom-icon "file:///usr/share/icons/Tela-circle-${icons_color}/scalable/places/default-folder-video.svg"

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
}

apply_sddm_theme () {
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
}

refresh_applications () {
    # Nautilus
    pkill -f nautilus

    # Kitty
    if pgrep -f "kitty" > /dev/null; then
        pkill -USR1 -f kitty
    fi

    # EWW
    eww reload

    # Dunst
    pkill dunst
    dunstctl reload

    # Cava
    if pgrep -f "kitty.*kitten.*panel.*cava" > /dev/null; then
        pkill -SIGUSR1 cava
        pkill -USR1 -f song_display.py
    fi

    # Clock overlay
    if pgrep -f "isthataclock.py" > /dev/null; then
        pkill -USR1 -f isthataclock.py
    fi
}
