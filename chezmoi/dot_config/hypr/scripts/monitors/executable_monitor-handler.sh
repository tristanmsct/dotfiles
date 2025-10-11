#!/usr/bin/env bash
#                        _ _                  _                     _ _
#  _ __ ___   ___  _ __ (_) |_ ___  _ __     | |__   __ _ _ __   __| | | ___ _ __
# | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|____| '_ \ / _` | '_ \ / _` | |/ _ \ '__|
# | | | | | | (_) | | | | | || (_) | | |_____| | | | (_| | | | | (_| | |  __/ |
# |_| |_| |_|\___/|_| |_|_|\__\___/|_|       |_| |_|\__,_|_| |_|\__,_|_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

LOG_FILE="/tmp/hyprland-monitor.log"
source $HOME/.config/hypr/scripts/monitors/monitor-helpers.sh

handle() {
    # log_message "Received event: $1"
    case $1 in
        monitoradded*|monitorremoved*)
            # Wait a moment for the system to stabilize.
            # log_message "Recieved event: $1"
            # log_message "Monitor Handling triggered"
            sleep 0.5
            update_monitor_config
            ;;
    esac
}

# Start listening to Hyprland events
# log_message "Starting Hyprland event listener"
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
