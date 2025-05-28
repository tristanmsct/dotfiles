#!/bin/bash
#  _ ____      ____ _       _ __ ___   ___ _ __  _   _
# | '_ \ \ /\ / / _` |_____| '_ ` _ \ / _ \ '_ \| | | |
# | | | \ V  V / (_| |_____| | | | | |  __/ | | | |_| |
# |_| |_|\_/\_/ \__, |     |_| |_| |_|\___|_| |_|\__,_|
#               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

nwg-menu \
  -s "menu-start.css" \
  -va "top" \
  -ha "left" \
  -fm "nautilus" \
  -term "kitty" \
  -cmd-lock "hyprlock" \
  -cmd-logout "hyprctl dispatch exit" \
  -cmd-restart "systemctl -i reboot" \
  -cmd-shutdown "systemctl -i poweroff" \
  -d \
