#!/usr/bin/env bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

keybinds=""
mods=""

while IFS= read -r line; do
  case "$line" in
    bindd*) mods=""; key=""; desc="" ;;
    *"modmask:"*) mask="${line#*modmask: }" ;;
    *"key:"*) key="${line#*key: }" ;;
    *"description:"*) desc="${line#*description: }" ;;
    "")
      [[ -z "$desc" || -z "$key" ]] && continue
      combo=""
      (( mask & 64 )) && combo+="󰌽  + "
      (( mask & 1  )) && combo+="SHIFT + "
      (( mask & 4  )) && combo+="CTRL + "
      (( mask & 8  )) && combo+="ALT + "
      combo+="$key"
      keybinds+="${combo}"$'\r'"${desc}"$'\n'
      ;;
  esac
done < <(hyprctl binds)

rofi -disable-history -dmenu -i -markup -eh 2 -replace -p "Keybinds" \
  -config "$HOME/.config/rofi/config-simple.rasi" <<< "$keybinds"
