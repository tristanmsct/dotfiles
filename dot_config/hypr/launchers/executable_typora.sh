#!/usr/bin/env bash

# Get XDG variables and create the fake home if it does not exists.
source $HOME/.config/hypr/launchers/setup-fake-home.sh

HOME="$FAKE_HOME" exec /usr/bin/typora \
                --enable-features=UseOzonePlatform \
                --ozone-platform=wayland \
                --enable-wayland-ime \
                --wayland-text-input-version=3 \
                --user-data-dir="$XDG_DATA_HOME/typora-data" "$@"
