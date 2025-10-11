#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

STEAM_HOME=$XDG_STATE_HOME/steam_home
mkdir -p "$STEAM_HOME"

# Point Steam's data to our custom location
export STEAM_HOME="$STEAM_HOME"

ln -sf "$HOME/.local" "$STEAM_HOME/.local"
ln -sf "$HOME/.config" "$STEAM_HOME/.config"
ln -sf "$HOME/.cache" "$STEAM_HOME/.cache"
ln -sf "$HOME/.pki" "$STEAM_HOME/.pki"

HOME="$STEAM_HOME" /usr/bin/steam -nochatui -nofriendsui "$@"
