#!/usr/bin/env bash
# > [!Important] Slack is an Electron app, it needs to use brave's fake home otherwise it creates a ~/.pki directory.

# Get XDG variables and create the fake home if it does not exists.
source $HOME/.config/hypr/launchers/setup-fake-home.sh

HOME="$FAKE_HOME" exec /usr/bin/slack --user-data-dir="$XDG_DATA_HOME/slack-data" --gtk-version=3 -s "$@"
