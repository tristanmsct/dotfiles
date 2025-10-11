#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

VSCODE_PORTABLE="$XDG_DATA_HOME/VSCodium" exec codium "$@"
