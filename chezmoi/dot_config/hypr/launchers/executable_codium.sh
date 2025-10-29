#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

VSCODE_PORTABLE="$XDG_DATA_HOME/VSCodium" VSCODE_CLI_DATA_DIR="$XDG_DATA_HOME/VSCodium/cli" exec codium "$@"
