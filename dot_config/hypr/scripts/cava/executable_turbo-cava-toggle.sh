turbocava_running=$(pgrep -f "qs -p /home/tristan/.config/quickshell/turbo-cava.qml" || true)

if [ -n "$turbocava_running" ]; then
    # Kill the running turbocava process
    pkill -f "qs -p /home/tristan/.config/quickshell/turbo-cava.qml"
else
    # No turbocava process running, start a new one
    qs -p /home/tristan/.config/quickshell/turbo-cava.qml &
fi