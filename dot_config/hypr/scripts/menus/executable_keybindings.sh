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

# Map named keys (from hyprctl) to printable glyphs (reverse mapping)
declare -A keymap=(
  ["ampersand"]="&amp;"
  ["eacute"]="é"
  ["quotedbl"]="\""
  ["apostrophe"]="'"
  ["parenleft"]="("
  ["minus"]="-"
  ["egrave"]="è"
  ["underscore"]="_"
  ["agrave"]="à"
  ["ccedilla"]="ç"
  ["XF86MonBrightnessDown"]="F2"
  ["XF86MonBrightnessUp"]="F3"
  ["XF86AudioMute"]="F6"
  ["XF86AudioLowerVolume"]="F7"
  ["XF86AudioRaiseVolume"]="F8"
  ["comma"]=","
  ["RETURN"]="󰌑"
  ["XF86PowerOff"]=""
  ["mouse:272"]="Left click"
  ["mouse:273"]="Right click"
  ["mouse_up"]="Mouse up"
  ["mouse_down"]="Mouse down"
)

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
      # convert display of some keys (accents) to readable names
      display_key="$key"
      if [[ -n "${keymap[$display_key]+_}" ]]; then
        display_key="${keymap[$display_key]}"
      else
        for ch in "${!keymap[@]}"; do
          display_key="${display_key//${ch}/${keymap[$ch]}}"
        done
      fi

      combo+="$display_key"
      keybinds+="<b>${combo}</b>"$'\r'"${desc}"$'\n'
      ;;
  esac
done < <(hyprctl binds)

rofi -disable-history -dmenu -i -markup -eh 2 -replace -markup-rows -p "Keybinds" \
  -config "$HOME/.config/rofi/config-simple.rasi" <<< "$keybinds"
