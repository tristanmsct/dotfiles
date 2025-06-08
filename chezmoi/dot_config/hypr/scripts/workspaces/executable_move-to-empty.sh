#!/bin/bash
#                                 _                                   _
#  _ __ ___   _____   _____      | |_ ___         ___ _ __ ___  _ __ | |_ _   _
# | '_ ` _ \ / _ \ \ / / _ \_____| __/ _ \ _____ / _ \ '_ ` _ \| '_ \| __| | | |
# | | | | | | (_) \ V /  __/_____| || (_) |_____|  __/ | | | | | |_) | |_| |_| |
# |_| |_| |_|\___/ \_/ \___|      \__\___/       \___|_| |_| |_| .__/ \__|\__, |
#                                                              |_|        |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Send the active window to the next empty workpace.
# -----------------------------------------------------------------------------------------------------------------------------------------

# /!\ Let's you have 3 persisent workspaces.
# In general the `hyprctl workspaces` command will only return non empty workspaces.
# If you got to empty workspace 4 (or any empty workspace at the end of the list after the max persisent workspace),
# The `hyprctl workspaces` command will return something for this workspace which make the following script non functionnal.
# There is no reason to use this script on an empty workspace and it will just not do anything but still, this weird behaviour
# makes the script not work.

# Getting the address for the active window, wich is neede to be able to move it.
active_window_address=$(hyprctl activewindow -j | jq -r '.address')
active_window_workspace=$(hyprctl activewindow -j | jq -r '.workspace.id')

# Each monitor has a set of 3 workpaces.
workspace_set=$(( ($active_window_workspace - 1) / 3 ))
starting_count=$(( 3 * $workspace_set + 1 ))

# Going through each workspace id (its number in the list starting from 1), until an id is not in the list.
# If all ids are in order without a gap we ge for one more.
ids=($(hyprctl workspaces -j | jq -r '.[].id' | sort -n))
for ((i=$starting_count; ; i++)); do
    [[ ! " ${ids[@]} " =~ " $i " ]] && echo "$i" && break
done

# Max workspace at 8.
i=$(($i > 8 ? 8 : $i))

# Finally moving the target window to the next empty workspace.
hyprctl dispatch movetoworkspacesilent "$i,address:$active_window_address"
