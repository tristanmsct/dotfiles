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

    if grep -q "accent-color" "$HOME/.cache/wal/colors-hyprland.conf"; then

        # Hyprland
        sed -i -E "s/(\\\$accent-color = \\\$color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-hyprland.conf
        sed -i -E "s/(\\\$accent-color-transparent = \\\$colort)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-hyprland.conf
        sed -i -E "s/(\\\$highlight-color = )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors-hyprland.conf

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

        # Waybar
        sed -i -E "s/(accent-color @color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors-waybar.css
        sed -i -E "s/(highlight-color )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors-waybar.css
        sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-waybar.css
        sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-waybar.css
        cp ~/.config/waybar/style.css ~/.config/waybar/style.css.tmp
        mv ~/.config/waybar/style.css.tmp ~/.config/waybar/style.css

        # SCSS / EWW
        sed -i -E "s/(\\\$accent-color: \\\$color)[0-9]{1,2}/\1$COLOR_NB/" $HOME/.cache/wal/colors.scss
        sed -i -E "s/(\\\$accent-color-transparent: \\\$color)[0-9]{1,2}-tr/\1$COLOR_NB-tr/" $HOME/.cache/wal/colors.scss
        sed -i -E "s/(\\\$highlight-color: )rgba\([0-9]{1,3},[0-9]{1,3},[0-9]{1,3},1\)/\1$saturated_color/" $HOME/.cache/wal/colors.scss
        sed -i -E "s/(\\\$background-theme: )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors.scss
        sed -i -E "s/(\\\$foreground-theme: )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors.scss

        # WLogout
        sed -i -E "s/(background-theme )rgba\([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3}, 0\.4\)/\1$BG_COLOR/" $HOME/.cache/wal/colors-wlogout.css
        sed -i -E "s/(foreground-theme )#.{6}/\1$TXT_COLOR/" $HOME/.cache/wal/colors-wlogout.css
    else

        # Hyprland
        printf "\n" >> "$HOME/.cache/wal/colors-hyprland.conf"
        echo "\$accent-color = \$color$COLOR_NB" >> "$HOME/.cache/wal/colors-hyprland.conf"
        echo "\$accent-color-transparent = \$colort$COLOR_NB" >> "$HOME/.cache/wal/colors-hyprland.conf"
        echo "\$highlight-color = $saturated_color" >> "$HOME/.cache/wal/colors-hyprland.conf"

        # Rofi
        sed -i '/^}$/i\ ' "$HOME/.cache/wal/colors-rofi-pywal.rasi"
        sed -i "/^}$/i\\\\taccent-color: @color$COLOR_NB;" "$HOME/.cache/wal/colors-rofi-pywal.rasi"
        sed -i "/^}$/i\\\\taccent-color-transparent: @color$COLOR_NB-tr;" "$HOME/.cache/wal/colors-rofi-pywal.rasi"
        sed -i "/^}$/i\\\\tforeground: $TXT_COLOR;" "$HOME/.cache/wal/colors-rofi-pywal.rasi"
        sed -i "/^}$/i\\\\tbackground: $BG_COLOR;" "$HOME/.cache/wal/colors-rofi-pywal.rasi"

        # NWG
        printf "\n" >> "$HOME/.cache/wal/colors-nwg.css"
        echo "@define-color accent-color @color$COLOR_NB;" >> "$HOME/.cache/wal/colors-nwg.css"
        echo "@define-color highlight-color $saturated_color;" >> "$HOME/.cache/wal/colors-nwg.css"
        echo "@define-color background-theme $BG_COLOR;" >> "$HOME/.cache/wal/colors-nwg.css"
        echo "@define-color foreground-theme $TXT_COLOR;" >> "$HOME/.cache/wal/colors-nwg.css"

        # Waybar
        printf "\n" >> "$HOME/.cache/wal/colors-waybar.css"
        echo "@define-color accent-color @color$COLOR_NB;" >> "$HOME/.cache/wal/colors-waybar.css"
        echo "@define-color highlight-color $saturated_color;" >> "$HOME/.cache/wal/colors-waybar.css"
        echo "@define-color background-theme $BG_COLOR;" >> "$HOME/.cache/wal/colors-waybar.css"
        echo "@define-color foreground-theme $TXT_COLOR;" >> "$HOME/.cache/wal/colors-waybar.css"
        cp ~/.config/waybar/style.css ~/.config/waybar/style.css.tmp
        mv ~/.config/waybar/style.css.tmp ~/.config/waybar/style.css

        # SCSS / EWW
        printf "\n" >> "$HOME/.cache/wal/colors.scss"
        echo "\$accent-color: \$color$COLOR_NB;" >> "$HOME/.cache/wal/colors.scss"
        echo "\$accent-color-transparent: \$color$COLOR_NB-tr;" >> "$HOME/.cache/wal/colors.scss"
        echo "\$highlight-color: $saturated_color;" >> "$HOME/.cache/wal/colors.scss"
        echo "\$background-theme: $BG_COLOR;" >> "$HOME/.cache/wal/colors.scss"
        echo "\$foreground-theme: $TXT_COLOR;" >> "$HOME/.cache/wal/colors.scss"

        # WLogout
        printf "\n" >> "$HOME/.cache/wal/colors-wlogout.css"
        echo "@define-color background-theme $BG_COLOR;" >> "$HOME/.cache/wal/colors-wlogout.css"
        echo "@define-color foreground-theme $TXT_COLOR;" >> "$HOME/.cache/wal/colors-wlogout.css"
    fi
}
