#!/usr/bin/env bash
# > [!Important] VScodium is an Electron app, it needs to use brave's fake home otherwise it creates a ~/.pki directory.

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

HOME="$CHROMIUM_HOME" VSCODE_PORTABLE="$XDG_DATA_HOME/VSCodium" VSCODE_CLI_DATA_DIR="$XDG_DATA_HOME/VSCodium/cli" exec codium "$@"
