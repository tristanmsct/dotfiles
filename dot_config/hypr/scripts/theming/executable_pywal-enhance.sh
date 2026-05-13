#!/usr/bin/env bash
#                            _                  _
#  _ __  _   ___      ____ _| |       ___ _ __ | |__   __ _ _ __   ___ ___
# | '_ \| | | \ \ /\ / / _` | |_____ / _ \ '_ \| '_ \ / _` | '_ \ / __/ _ \
# | |_) | |_| |\ V  V / (_| | |_____|  __/ | | | | | | (_| | | | | (_|  __/
# | .__/ \__, | \_/\_/ \__,_|_|      \___|_| |_|_| |_|\__,_|_| |_|\___\___|
# |_|    |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

enhance_templates () {

    if [ $THEME_TYPE = "dark" ]; then
        hyprctl setcursor Vimix-white-cursors 40
        sed -i "s/-light.png/-dark.png/" $HOME/.config/wlogout/style.css

        BG_COLOR="rgba(0, 0, 0, 0.4)"
        TXT_COLOR="#eeeeee"
    else
        hyprctl setcursor Vimix-cursors 40
        sed -i "s/-dark.png/-light.png/" $HOME/.config/wlogout/style.css

        BG_COLOR="rgba(230, 230, 230, 0.4)"
        TXT_COLOR="#000000"
    fi

    # Hyprland
    sed -i -E "s/(accent_color = color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-hyprland.lua
    sed -i -E "s/(accent_color_transparent = colort)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-hyprland.lua
    sed -i -E "s/(highlight_color = )\"rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)\"/\1\"$saturated_color\"/" $HOME/.cache/wal/colors-hyprland.lua

    # Rofi
    sed -i -E "s/(accent-color: @color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-rofi-pywal.rasi
    sed -i -E "s/(accent-color-transparent: @color)[0-9]{1,2}(-tr)/\1$COLOR_NB\2/" $HOME/.cache/wal/colors-rofi-pywal.rasi
    sed -i -E "s/(background: )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-rofi-pywal.rasi
    sed -i -E "s/(foreground: )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-rofi-pywal.rasi

    # NWG
    sed -i -E "s/(accent-color @color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-nwg.css
    sed -i -E "s/(highlight-color )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors-nwg.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-nwg.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-nwg.css

    # NMRS
    sed -i -E "s/(accent-color @color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-nmrs.css
    sed -i -E "s/(highlight-color )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors-nmrs.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-nmrs.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-nmrs.css

    # Waybar
    sed -i -E "s/(accent-color @color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-waybar.css
    sed -i -E "s/(highlight-color )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors-waybar.css
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-waybar.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-waybar.css
    cp "$HOME/.config/waybar/style.css" "$HOME/.config/waybar/style.css.tmp"
    mv "$HOME/.config/waybar/style.css.tmp" "$HOME/.config/waybar/style.css"

    # SCSS / EWW
    sed -i -E "s/(\\\$accent-color: \\\$color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors.scss
    sed -i -E "s/(\\\$accent-color-transparent: \\\$color)[0-9]{1,2}-tr/\1$COLOR_NB-tr/" $HOME/.cache/wal/colors.scss
    sed -i -E "s/(\\\$highlight-color: )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors.scss
    sed -i -E "s/(\\\$background-theme: )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors.scss
    sed -i -E "s/(\\\$foreground-theme: )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors.scss

    # WLogout
    sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-wlogout.css
    sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-wlogout.css
}
