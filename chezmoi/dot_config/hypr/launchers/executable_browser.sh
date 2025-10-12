#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

BRAVE_HOME="$HOME/.local/state/brave_home"
mkdir -p "$BRAVE_HOME"

# Create symlinks only if they don't exist
[[ -L "$BRAVE_HOME/.local" ]] || ln -s "$HOME/.local" "$BRAVE_HOME/.local"
[[ -L "$BRAVE_HOME/.config" ]] || ln -s "$HOME/.config" "$BRAVE_HOME/.config"
[[ -L "$BRAVE_HOME/.cache" ]] || ln -s "$HOME/.cache" "$BRAVE_HOME/.cache"
[[ -L "$BRAVE_HOME/.pki" ]] || ln -s "$HOME/.local/share/pki" "$BRAVE_HOME/.pki"

# Launch Brave with appropriate flags.
HOME="$BRAVE_HOME" exec brave --user-data-dir="$XDG_DATA_HOME/brave-data" \
                  --disk-cache-dir="$XDG_CACHE_HOME/brave-cache" \
                  --enable-features=UseOzonePlatform \
                  --ozone-platform=wayland \
                  --password-store=basic \
                  "$@"
