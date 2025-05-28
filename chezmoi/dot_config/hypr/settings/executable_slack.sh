#!/bin/bash

# Source XDG config if available.
if [ -f "$HOME/.config/ssh/xdg_config" ]; then
  source "$HOME/.config/ssh/xdg_config"
fi

# Set defaults if not defined in xdg_config.
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

exec slack --user-data-dir="$XDG_DATA_HOME/slack-data" "$@"
