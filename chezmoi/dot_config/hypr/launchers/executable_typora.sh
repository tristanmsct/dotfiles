#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

# Create fake home with symlinks to real XDG dirs.
CHROMIUM_HOME=$HOME/.local/state/chromium_home
mkdir -p "$CHROMIUM_HOME"

[[ -L "$CHROMIUM_HOME/.local" ]] || ln -s "$HOME/.local" "$CHROMIUM_HOME/.local"
[[ -L "$CHROMIUM_HOME/.config" ]] || ln -s "$HOME/.config" "$CHROMIUM_HOME/.config"
[[ -L "$CHROMIUM_HOME/.cache" ]] || ln -s "$HOME/.cache" "$CHROMIUM_HOME/.cache"
[[ -L "$CHROMIUM_HOME/.ssh" ]] || ln -s "$HOME/.ssh" "$CHROMIUM_HOME/.ssh"

HOME="$CHROMIUM_HOME" exec typora --user-data-dir="$XDG_DATA_HOME/typora-data" "$@"
