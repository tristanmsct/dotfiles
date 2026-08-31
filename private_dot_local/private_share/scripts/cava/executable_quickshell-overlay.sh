#                                     _      _        _          _ _                           _
#   ___ __ ___   ____ _    __ _ _   _(_) ___| | _____| |__   ___| | |       _____   _____ _ __| | __ _ _   _
#  / __/ _` \ \ / / _` |  / _` | | | | |/ __| |/ / __| '_ \ / _ \ | |_____ / _ \ \ / / _ \ '__| |/ _` | | | |
# | (_| (_| |\ V / (_| | | (_| | |_| | | (__|   <\__ \ | | |  __/ | |_____| (_) \ V /  __/ |  | | (_| | |_| |
#  \___\__,_| \_/ \__,_|  \__, |\__,_|_|\___|_|\_\___/_| |_|\___|_|_|      \___/ \_/ \___|_|  |_|\__,_|\__, |
#                            |_|                                                                       |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

turbocava_running=$(pgrep -f "qs -p .*quickshell/turbo-cava.qml" || true)

if [ -n "$turbocava_running" ]; then
    # Kill the running turbocava process
    pkill -f "qs -p .*quickshell/turbo-cava.qml"
else
    # No turbocava process running, start a new one
    qs -p "$XDG_CONFIG_HOME/quickshell/turbo-cava.qml" &
fi