#!/usr/bin/env bash
#       _ _       _     _     _
#   ___| (_)_ __ | |__ (_)___| |_
#  / __| | | '_ \| '_ \| / __| __|
# | (__| | | |_) | | | | \__ \ |_
#  \___|_|_| .__/|_| |_|_|___/\__|
#          |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Common theme configuration
THEME_NORTHEAST="window { location: northeast; anchor: northeast; x-offset: -1.5%; y-offset: 4%; width: 25%;}"
THEME_WIPE="window {width: 20%; font: 'Noto Sans Bold 14';} inputbar { enabled: false;}"

case $1 in
    delete)
      cliphist list | rofi -disable-history -dmenu -replace \
         -config "$HOME/.config/rofi/config-simple.rasi" \
         -theme-str "${THEME_NORTHEAST}" | cliphist delete
      ;;

    wipe)
      if [ "$(echo -e "Clear full clipboard history\nCancel" | rofi -disable-history -dmenu -l 2 \
            -config "$HOME/.config/rofi/config-simple.rasi" -theme-str "${THEME_NORTHEAST}" \
            -theme-str "${THEME_WIPE}")" == "Clear full clipboard history" ] ; then
            cliphist wipe
      fi
      ;;

    *)
      cliphist list | \
         rofi -disable-history -dmenu -display-columns 2 -replace \
            -config "$HOME/.config/rofi/config-simple.rasi" \
            -theme-str "${THEME_NORTHEAST}" | cliphist decode | wl-copy
      ;;
esac
