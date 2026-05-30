#!/usr/bin/env bash
exec /usr/bin/brave \
    --user-data-dir="$XDG_DATA_HOME/brave-data" \
    --disk-cache-dir="$XDG_CACHE_HOME/brave-cache" \
    --enable-features=UseOzonePlatform \
    --ozone-platform=wayland \
    --ozone-platform-hint=auto \
    "$@"
