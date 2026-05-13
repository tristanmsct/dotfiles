#!/usr/bin/env bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

decode_mods() {
  local mask=$1
  local mods=""
  (( mask & 64 )) && mods+="󰌽  + "
  (( mask & 1  )) && mods+="SHIFT + "
  (( mask & 4  )) && mods+="CTRL + "
  (( mask & 8  )) && mods+="ALT + "
  echo "${mods% + }"
}

keybinds=""

while IFS= read -r bind; do
  desc=$(echo "$bind" | jq -r '.description')
  key=$(echo "$bind" | jq -r '.key')
  mask=$(echo "$bind" | jq -r '.modmask')
  has_desc=$(echo "$bind" | jq -r '.has_description')

  [[ "$has_desc" != "true" || -z "$desc" || "$key" == "" ]] && continue

  mods=$(decode_mods "$mask")
  [[ -n "$mods" ]] && combo="$mods + $key" || combo="$key"

  keybinds+="${combo}"$'\r'"${desc}"$'\n'
done < <(hyprctl binds -j | jq -c '.[]')

rofi -disable-history -dmenu -i -markup -eh 2 -replace -p "Keybinds" \
  -config "$HOME/.config/rofi/config-search.rasi" <<< "$keybinds"
