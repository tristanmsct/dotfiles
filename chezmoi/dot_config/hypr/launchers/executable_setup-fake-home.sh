#!/usr/bin/env bash

# Source XDG config if available.
if [ -f "$HOME/.config/shell/env" ]; then
  source "$HOME/.config/shell/env"
else
  # Create fake home with symlinks to real XDG dirs.
  export XDG_STATE_HOME="$HOME/.local/state"
  export FAKE_HOME="$XDG_STATE_HOME/fake_home"
fi

if [[ ! -d "$FAKE_HOME" ]]; then
  mkdir -p "$FAKE_HOME"

  [[ -L "$FAKE_HOME/.local" ]] || ln -s "$HOME/.local" "$FAKE_HOME/.local"
  [[ -L "$FAKE_HOME/.config" ]] || ln -s "$HOME/.config" "$FAKE_HOME/.config"
  [[ -L "$FAKE_HOME/.cache" ]] || ln -s "$HOME/.cache" "$FAKE_HOME/.cache"
  [[ -L "$FAKE_HOME/.ssh" ]] || ln -s "$HOME/.ssh" "$FAKE_HOME/.ssh"
  [[ -L "$FAKE_HOME/Documents" ]] || ln -s "$HOME/Documents" "$FAKE_HOME/Documents"
  [[ -L "$FAKE_HOME/Downloads" ]] || ln -s "$HOME/Downloads" "$FAKE_HOME/Downloads"
fi
