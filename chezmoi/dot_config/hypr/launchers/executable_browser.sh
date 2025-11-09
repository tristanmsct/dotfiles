#!/usr/bin/env bash

# Get XDG variables and create the fake home if it does not exists.
source $HOME/.config/hypr/launchers/setup-fake-home.sh

HOME="$FAKE_HOME" exec brave --user-data-dir="$XDG_DATA_HOME/brave-data" \
                  --disk-cache-dir="$XDG_CACHE_HOME/brave-cache" \
                  --enable-features=UseOzonePlatform \
                  --ozone-platform=wayland \
                  --password-store=basic \
                  "$@"
