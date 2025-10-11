#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

# Launch Brave with appropriate flags.
exec brave --user-data-dir="$XDG_DATA_HOME/brave-data" \
                  --disk-cache-dir="$XDG_CACHE_HOME/brave-cache" \
                  --enable-features=UseOzonePlatform \
                  --ozone-platform=wayland \
                  --password-store=basic \
                  "$@"
