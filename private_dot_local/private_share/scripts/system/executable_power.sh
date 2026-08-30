#!/usr/bin/env bash
#  ____
# |  _ \ _____      _____ _ __
# | |_) / _ \ \ /\ / / _ \ '__|
# |  __/ (_) \ V  V /  __/ |
# |_|   \___/ \_/\_/ \___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

if [[ "$1" == "exit" ]]; then
    sleep 0.2
    if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
        hyprctl dispatch "hl.dsp.exit()"
    else
        dunstify "Not implemented"
    fi
    sleep 2
fi

if [[ "$1" == "lock" ]]; then
    sleep 0.2
    if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
        hyprlock --grace 3
    else
        dunstify "Not implemented"
    fi
fi

if [[ "$1" == "reboot" ]]; then
    sleep 0.2
    systemctl reboot
fi

if [[ "$1" == "shutdown" ]]; then
    sleep 0.2
    systemctl poweroff
fi

if [[ "$1" == "suspend" ]]; then
    sleep 0.2
    systemctl suspend
fi

if [[ "$1" == "hibernate" ]]; then
    sleep 1;
    systemctl hibernate
fi
