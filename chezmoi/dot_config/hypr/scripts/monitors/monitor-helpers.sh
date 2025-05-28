#                        _ _                  _          _
#  _ __ ___   ___  _ __ (_) |_ ___  _ __     | |__   ___| |_ __   ___ _ __ ___
# | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|____| '_ \ / _ \ | '_ \ / _ \ '__/ __|
# | | | | | | (_) | | | | | || (_) | | |_____| | | |  __/ | |_) |  __/ |  \__ \
# |_| |_| |_|\___/|_| |_|_|\__\___/|_|       |_| |_|\___|_| .__/ \___|_|  |___/
#                                                         |_|
#
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# A collection of function used to change and adjust the monitor configuration.
# -----------------------------------------------------------------------------------------------------------------------------------------

CONFIG_DIR="$HOME/.config/hypr/conf"
MONITOR_FILE="$CONFIG_DIR/monitor.conf"
HOME_MONITOR="Acer Technologies QG241Y TLAEE001854A"
LOG_FILE="/tmp/hyprland-monitor.log"

log_message() {
    echo "$(date): $1" >> "$LOG_FILE"
}

get_monitor_label_by_name() {
    local monitor_name="$1"
    hyprctl monitors | awk -v name="$monitor_name" '
        $0 ~ "Monitor" { monitor = $2 }
        $0 ~ "description: " name { print monitor }
    '
}

update_monitor_config() {
    # Get number of monitors
    # Add a running state flag file in cache, and don't do anything if it exists.

    if [ ! -f "$HOME/.cache/monitor-config-running" ]; then
        # log_message "Creating already running flag"
        touch "$HOME/.cache/monitor-config-running"
        declare -i monitor_count=$(hyprctl monitors -j | jq length)
        # log_message "Detected $monitor_count monitors"

        if ! hyprctl monitors|grep "Monitor eDP-1"; then
            # log_message "DEBUG : eDP-1 not in monitors list"
            monitor_count=$monitor_count+1
            # log_message "DEBUG : $monitor_count is the monitor count"
        fi

        if [ ! -f "$HOME/.cache/monitor-external-only" ]; then
            if [ "$monitor_count" -eq 1 ]; then
                # log_message "Applying mono configuration"
                cp "$CONFIG_DIR/monitors/mono.conf" "$MONITOR_FILE"
                cp $HOME/.config/waybar/templates/config-mono.jsonc $HOME/.config/waybar/config.jsonc
            elif [ "$monitor_count" -ge 1 ]; then
                # log_message "Applying multi-monitor configuration"
                cp "$CONFIG_DIR/monitors/multi-home.conf" "$MONITOR_FILE"
                cp $HOME/.config/waybar/templates/config-multi.jsonc $HOME/.config/waybar/config.jsonc

                if hyprctl monitors|grep "$HOME_MONITOR"; then
                    # Home config.
                    monitor_label=$(get_monitor_label_by_name "$HOME_MONITOR")
                    sed -i "s|# SECONDARY MONITOR CONFIG|monitor=$monitor_label,1920x1080@120Hz,-1920x-600,1|g" "$MONITOR_FILE"
                fi
            fi
        fi

        # Reload Hyprland configuration
        # log_message "hyprctl reload ..."
        hyprctl reload
        # log_message "wallpaper reload ..."
        pkill hyprpaper
        waypaper --restore
        $HOME/.config/hypr/scripts/waybar/launch.sh
        # log_message "Configuration reloaded"

        # Hyprsunset can be stopped when pluging / unpluging a monitor, if it is not running we restart it.
        pgrep -x hyprsunset >/dev/null || hyprsunset -i &

        sleep 1
        # log_message "Removing already running flag"
        rm $HOME/.cache/monitor-config-running
    else
        # log_message "Tried to run update monitor config script but is already running"
        :
    fi
}
