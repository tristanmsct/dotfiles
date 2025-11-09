#!/usr/bin/env bash
# > [!Important] VScodium is an Electron app, it needs to use brave's fake home otherwise it creates a ~/.pki directory.

# Get XDG variables and create the fake home if it does not exists.
source $HOME/.config/hypr/launchers/setup-fake-home.sh

HOME="$FAKE_HOME" VSCODE_PORTABLE="$XDG_DATA_HOME/VSCodium" VSCODE_CLI_DATA_DIR="$XDG_DATA_HOME/VSCodium/cli" exec codium "$@"
