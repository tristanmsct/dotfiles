#!/usr/bin/env bash
#               _ _       _           _                   _
#  _____      _(_) |_ ___| |__       | |__   ___  _ __ __| | ___ _ __ ___
# / __\ \ /\ / / | __/ __| '_ \ _____| '_ \ / _ \| '__/ _` |/ _ \ '__/ __|
# \__ \\ V  V /| | || (__| | | |_____| |_) | (_) | | | (_| |  __/ |  \__ \
# |___/ \_/\_/ |_|\__\___|_| |_|     |_.__/ \___/|_|  \__,_|\___|_|  |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

STATE_FILE=$HOME/.local/state/desktop/state.json
FOCUSMODE_ENABLED=$(jq -r '.focusmode.enabled' $STATE_FILE)

if $FOCUSMODE_ENABLED; then
    dunstify "Cannot enable main borders" "Main borders are disabled in focus mode."
    exit
fi

if [ $1 == true ]; then
    sed -i -E "s/(border_size =) 2/\1 0/" $HOME/.config/hypr/conf/windows.conf
else
    sed -i -E "s/(border_size =) 0/\1 2/" $HOME/.config/hypr/conf/windows.conf
fi
