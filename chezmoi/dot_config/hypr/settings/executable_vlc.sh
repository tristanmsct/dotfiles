#!/usr/bin/env bash
XCURSOR_THEME=$(gsettings get org.gnome.desktop.interface cursor-theme | sed "s/'//g") /usr/bin/vlc "$@"
