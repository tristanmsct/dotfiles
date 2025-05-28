#!/bin/bash
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

aur_helper="$(cat ~/.config/hypr/settings/aur.sh)"
term="$(cat ~/.config/hypr/settings/terminal.sh)"

if [[ $# -eq 0 ]] ; then

    # -----------------------------------------------------------------------------------
    # Compute available updates and return a json for the waybar module.
    # -----------------------------------------------------------------------------------

    if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
        updates_arch=0
    fi

    if ! updates_aur=$($aur_helper -Qu --aur --quiet | wc -l); then
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

    $term --title systemupdate sh -c "$aur_helper -Syu"
    dunstify "System updated"
fi
