#!/usr/bin/env python
#                                       _                        _
#   ___ ___  _ __ ___  _ __   __ _  ___| |_  __      _____  _ __| | _____ _ __   __ _  ___ ___  ___
#  / __/ _ \| '_ ` _ \| '_ \ / _` |/ __| __| \ \ /\ / / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
# | (_| (_) | | | | | | |_) | (_| | (__| |_   \ V  V / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
#  \___\___/|_| |_| |_| .__/ \__,_|\___|\__|___\_/\_/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
#                     |_|                 |_____|                        |_|
#
"""
Created on 2025-05-11.

@author: Tristan Muscat
@email: tristan.muscat@pm.me
"""
import subprocess
import json

from collections import namedtuple

# This is a simple representation of a Hyprland window, its address to be able to reference
# it to a dispatcher and its current workspace id.
Window = namedtuple("Window", ["address", "workspace_id"])


def count_monitors():
    """Get the number of plugged in monitors."""
    # Run the hyprctl clients -j command and capture its output.
    result = subprocess.run(['hyprctl', 'monitors', '-j'], capture_output=True, text=True)

    # Parse the JSON output into a Python dictionary.
    monitors_dict = json.loads(result.stdout)

    return len(monitors_dict)


def get_hyprctl_windows():
    """Get all windows informations from hyprctl."""
    # Run the hyprctl clients -j command and capture its output.
    result = subprocess.run(['hyprctl', 'clients', '-j'], capture_output=True, text=True)

    # Parse the JSON output into a Python dictionary.
    clients_dict = json.loads(result.stdout)

    lst_windows = []
    for client in clients_dict:
        lst_windows.append(
            Window(client["address"], client["workspace"]["id"])
        )

    # The idea is to have windows sorted by workspace id to be able to go through them from smallest to biggest id.
    lst_windows.sort(key=lambda elt: elt.workspace_id)

    return lst_windows


def move_window_to_workspace(workspace_number, window_address):
    """Simply and safely moves a window to a target workspace."""
    # Format the argument properly
    arg = f"""hl.dsp.window.move({{window='address:{window_address}',workspace={workspace_number},follow=false}})"""

    # Run the command with separate arguments
    result = subprocess.run(["hyprctl", "dispatch", arg])

    return result.returncode == 0


def create_workspace_mappings(non_empty_workspaces):
    """Create a mapping for existing workspaces to nearest empty workspaces. This takes into account the number of monitors"""
    # Multiscreen always have 3 persistent workspaces.
    # Mono screen have 4 but it does not matter since it is the last and only threshold,
    # everything above 3 still goes to the first monitor.

    nb_workspace_per_screen = 3
    nb_monitors = count_monitors()
    nb_threshold_above = (max(non_empty_workspaces) // nb_workspace_per_screen) + 1

    mappings = dict()
    for threshold in range(1, nb_threshold_above + 1):
        min_workspace = (nb_workspace_per_screen * (threshold - 1))
        max_workspace = (nb_workspace_per_screen * threshold)

        # List all workspaces for a given threshold interval. If we are in the last threshold, the we remove the upper bound.
        # This means that for 3 monitors with 3 workspaces each, workspace 12 will always go to the last moitor.
        if threshold < nb_monitors:
            workspaces_in_threshold = [elt for elt in non_empty_workspaces if min_workspace < elt <= max_workspace]
        else:
            workspaces_in_threshold = [elt for elt in non_empty_workspaces if min_workspace < elt]

        # The get out of order for some reason.
        workspaces_in_threshold.sort()

        # For each workspace in the interval we can determine its mapping.
        for workspace in workspaces_in_threshold:
            try:
                tmp = max(max(mappings.values()) + 1, min_workspace + 1)
            except ValueError:
                tmp = min_workspace + 1

            mappings.update({workspace: tmp})

        # If we get to the last threshold, every workspace after is bunched into this interval so we can stop here.
        if threshold == nb_monitors:
            break

    return mappings


def compact_workspaces():
    """List all windows and move them in a more compact way.

    The idea is to create a list of non empty workspaces.
    If workspaces 2, 3 and 5 are not empty then each non empty workspace perfectly align with its index in a list + 1.
    Workspace 2 should be workspace 1, 3 should be 2 and 5 should be 3.
    We then move the windows accordingly.
    """
    lst_windows = get_hyprctl_windows()

    non_empty_workspaces = set([window.workspace_id for window in lst_windows])
    workspace_mapping = create_workspace_mappings(non_empty_workspaces)

    for workspace, target_workspace in workspace_mapping.items():
        if workspace != (target_workspace):
            lst_windows_to_move = [window.address for window in lst_windows if window.workspace_id == workspace]
            for window_to_move in lst_windows_to_move:
                move_window_to_workspace(target_workspace, window_to_move)


if __name__ == "__main__":
    compact_workspaces()
