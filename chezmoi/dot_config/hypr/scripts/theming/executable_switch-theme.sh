#!/usr/bin/env bash
#  ____          _ _       _       _____ _
# / ___|_      _(_) |_ ___| |__   |_   _| |__   ___ _ __ ___   ___
# \___ \ \ /\ / / | __/ __| '_ \    | | | '_ \ / _ \ '_ ` _ \ / _ \
#  ___) \ V  V /| | || (__| | | |   | | | | | |  __/ | | | | |  __/
# |____/ \_/\_/ |_|\__\___|_| |_|   |_| |_| |_|\___|_| |_| |_|\___|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

theme_type="dark"
if [ -f $HOME/.cache/theme-light-dark ]; then
    theme_type=$(cat $HOME/.cache/theme-light-dark)
fi

if [ $theme_type = "dark" ]; then
    echo "light" > $HOME/.cache/theme-light-dark
else
    echo "dark" > $HOME/.cache/theme-light-dark
fi

if [ -f $HOME/.cache/accent-color ]; then
    # If there was accent colors cached, then we re-apply them.
    read -r COLOR < ~/.cache/accent-color
    read -r COLOR_NB < <(sed -n '2p' ~/.cache/accent-color)

    $HOME/.config/hypr/scripts/theming/apply-theme.sh $COLOR $COLOR_NB
else
    $HOME/.config/hypr/scripts/theming/apply-theme.sh
fi
