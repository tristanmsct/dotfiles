#!/usr/bin/env bash
# > [!Important] Slack is an Electron app, it needs to use brave's fake home otherwise it creates a ~/.pki directory.

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

CHROMIUM_HOME=$HOME/.local/state/chromium_home
mkdir -p "$CHROMIUM_HOME"

# Point Steam's data to our custom location
export CHROMIUM_HOME="$CHROMIUM_HOME"

# Create symlinks only if they don't exist
[[ -L "$CHROMIUM_HOME/.local" ]] || ln -s "$HOME/.local" "$CHROMIUM_HOME/.local"
[[ -L "$CHROMIUM_HOME/.config" ]] || ln -s "$HOME/.config" "$CHROMIUM_HOME/.config"
[[ -L "$CHROMIUM_HOME/.cache" ]] || ln -s "$HOME/.cache" "$CHROMIUM_HOME/.cache"

HOME="$CHROMIUM_HOME" exec slack --user-data-dir="$XDG_DATA_HOME/slack-data" "$@"
