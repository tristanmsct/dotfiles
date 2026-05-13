#!/usr/bin/env bash
#  _                                     _
# | |__   ___  _ __ ___   ___        ___| | ___  __ _ _ __   ___ _ __
# | '_ \ / _ \| '_ ` _ \ / _ \_____ / __| |/ _ \/ _` | '_ \ / _ \ '__|
# | | | | (_) | | | | | |  __/_____| (__| |  __/ (_| | | | |  __/ |
# |_| |_|\___/|_| |_| |_|\___|      \___|_|\___|\__,_|_| |_|\___|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Remove Brave crash reports from home, where they do not belong.
find "$HOME/.config/BraveSoftware/Brave-Browser/Crash Reports/completed" -name "*.dmp" -delete
find "$HOME/.config/BraveSoftware/Brave-Browser/Crash Reports/completed" -name "*.meta" -delete
