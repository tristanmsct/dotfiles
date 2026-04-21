#!/usr/bin/env bash
#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

source "$HOME/.config/shell/lib/format"

config_file="$HOME/.config/shell/aliases"

aliases=""

while read -r line; do
    if [[ "$line" == "alias "* ]]; then
        # Strip 'alias ' prefix
        line="${line#alias }"

        # Split on '=' -> alias name and command
        alias_name="${line%%=*}"
        alias_cmd="${line#*=}"

        # Strip surrounding quotes from command
        alias_cmd="${alias_cmd#\'}"
        alias_cmd="${alias_cmd%\'}"
        alias_cmd="${alias_cmd#\"}"
        alias_cmd="${alias_cmd%\"}"

        item="${alias_name}"$'\r'"${alias_cmd}"
        aliases="${aliases}${item}"$'\n'
    fi
done < "$config_file"

sleep 0.2
rofi -dmenu -i -markup -eh 2 -replace -p "Aliases" -config ~/.config/rofi/config-search.rasi <<< "$aliases"
