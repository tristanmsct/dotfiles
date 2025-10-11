#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/xdg_config" ]; then
  source "$HOME/.config/shell/xdg_config"
fi

exec slack --user-data-dir="$XDG_DATA_HOME/slack-data" "$@"
