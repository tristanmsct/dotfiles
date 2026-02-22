#!/usr/bin/env bash
#  _   _           _       _
# | | | |_ __   __| | __ _| |_ ___  ___
# | | | | '_ \ / _` |/ _` | __/ _ \/ __|
# | |_| | |_) | (_| | (_| | ||  __/\__ \
#  \___/| .__/ \__,_|\__,_|\__\___||___/
#       |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------
# Initialise variables
# ---------------------------------------------------------------------------------------

if [[ $# -eq 0 ]] ; then

    # -----------------------------------------------------------------------------------
    # Compute available updates and return a json for the waybar module.
    # -----------------------------------------------------------------------------------

    if ! updates_arch=$(timeout 10 checkupdates 2> /dev/null | wc -l ); then
        updates_arch=0
    fi

    if ! updates_aur=$(timeout 10 yay -Qu --aur --quiet | wc -l); then
        updates_aur=0
    fi

    updates=$(("$updates_arch" + "$updates_aur"))

    if [ "$updates" -gt 0 ]; then
        printf '{"text": " %s", "alt": "%s", "tooltip": "%s Official | %s AUR"}' "$updates" "$updates" "$updates_arch" "$updates_aur"
    else
        printf '{"text": "", "alt": "noupdate"}'
    fi

elif [ "$1" == "up" ] ; then

    # -----------------------------------------------------------------------------------
    # Run an update.
    # -----------------------------------------------------------------------------------

    kitty --title systemupdate sh -c "yay -Syu && dunstify 'System updated' || dunstify 'Update cancelled or failed'"
fi
