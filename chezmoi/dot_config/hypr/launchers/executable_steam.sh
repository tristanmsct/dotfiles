#!/usr/bin/env bash

STEAM_HOME=$HOME/.local/state/steam_home
mkdir -p "$STEAM_HOME"

# Point Steam's data to our custom location
export STEAM_HOME="$STEAM_HOME"

# Create symlinks only if they don't exist
[[ -L "$STEAM_HOME/.local" ]] || ln -s "$HOME/.local" "$STEAM_HOME/.local"
[[ -L "$STEAM_HOME/.config" ]] || ln -s "$HOME/.config" "$STEAM_HOME/.config"
[[ -L "$STEAM_HOME/.cache" ]] || ln -s "$HOME/.cache" "$STEAM_HOME/.cache"
[[ -L "$STEAM_HOME/.pki" ]] || ln -s "$HOME/.local/state/chromium_home/.pki" "$STEAM_HOME/.pki"

HOME="$STEAM_HOME" /usr/bin/steam -nochatui -nofriendsui "$@"
