#!/usr/bin/env bash
exec /usr/bin/slack --user-data-dir="$XDG_DATA_HOME/slack-data" --gtk-version=3 -s "$@"
