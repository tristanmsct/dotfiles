#!/usr/bin/env bash

# Get XDG variables and create the fake home if it does not exists.
source $HOME/.config/hypr/launchers/setup-fake-home.sh

HOME="$FAKE_HOME" exec firefox "$@"
