#!/bin/bash

# Source XDG config if available.
if [ -f "$HOME/.config/ssh/xdg_config" ]; then
  source "$HOME/.config/ssh/xdg_config"
fi

# Set defaults if not defined in xdg_config.
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Launch Brave with appropriate flags.
exec brave --user-data-dir="$XDG_DATA_HOME/brave-data" \
                  --disk-cache-dir="$XDG_CACHE_HOME/brave-cache" \
                  --enable-features=UseOzonePlatform \
                  --ozone-platform=wayland \
                  --password-store=basic \
                  "$@"
