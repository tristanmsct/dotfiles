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

        # Split comment from command
        comment=""
        if [[ "$alias_cmd" == *" #"* ]]; then
            comment="${alias_cmd#*" # "}"
            alias_cmd="${alias_cmd%%" #"*}"
        fi

        # Strip surrounding quotes from command
        alias_cmd="${alias_cmd%"${alias_cmd##*[![:space:]]}"}"
        alias_cmd="${alias_cmd#\'}"
        alias_cmd="${alias_cmd%\'}"
        alias_cmd="${alias_cmd#\"}"
        alias_cmd="${alias_cmd%\"}"

        if [[ -n "$comment" ]]; then
            item="<b>${alias_name}</b> -> ${alias_cmd}"$'\r'"${comment}"
        else
            item="<b>${alias_name}</b> -> ${alias_cmd}"

        fi

        aliases="${aliases}${item}"$'\n'
    fi
done < "$config_file"

sleep 0.2
selected=$(rofi -disable-history -dmenu -i -eh 2 -replace -markup-rows -p "Aliases" \
    -config "$HOME/.config/rofi/config-simple.rasi" <<< "$aliases")

alias_name="${selected%%' ->'*}"
alias_name="${alias_name//<b>/}"
alias_name="${alias_name//<\/b>/}"
echo -n "$alias_name" | wl-copy
