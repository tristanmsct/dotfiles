#!/usr/bin/env bash
#                                 _                             _
#  _ __ ___   _____   _____      | |_ ___         ___ _ __   __| |
# | '_ ` _ \ / _ \ \ / / _ \_____| __/ _ \ _____ / _ \ '_ \ / _` |
# | | | | | | (_) \ V /  __/_____| || (_) |_____|  __/ | | | (_| |
# |_| |_| |_|\___/ \_/ \___|      \__\___/       \___|_| |_|\__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Move active window to the end of the workspaces for a monitor.
# With one monitor, the window will be moved to workspace 4, except if its occupied, then it will be moved to the next empty up to 8.
# With multiple monitors, each have 3 fixed workspaces so the window will be sent to the third no matter what.
# -----------------------------------------------------------------------------------------------------------------------------------------

# Getting the address for the active window, wich is neede to be able to move it.
active_window_address=$(hyprctl activewindow -j | jq -r '.address')
active_window_workspace=$(hyprctl activewindow -j | jq -r '.workspace.id')

nb_monitors=$(hyprctl monitors -j|jq length)

if [ $nb_monitors -eq 1 ];then
    target=$(hyprctl workspaces -j | jq -r '.[].id' | sort -n|tail -1)
    # Target workspace min 4, max 8.
    target=$(($target < 4 ? 4 : $target))
    target=$(($target > 8 ? 8 : $target))

    hyprctl dispatch movetoworkspacesilent "$target,address:$active_window_address"
else
    # Each monitor has a set of 3 workpaces.
    workspace_set=$(( (($active_window_workspace - 1) / 3) + 1 ))
    target=$(( $workspace_set * 3 ))

    hyprctl dispatch movetoworkspacesilent "$target,address:$active_window_address"
fi
