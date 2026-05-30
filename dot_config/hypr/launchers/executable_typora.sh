#!/usr/bin/env bash
exec /usr/bin/typora \
    --enable-features=UseOzonePlatform \
    --ozone-platform=wayland \
    --enable-wayland-ime \
    --wayland-text-input-version=3 \
    --user-data-dir="$XDG_DATA_HOME/typora-data" \
    "$@"
