#!/usr/bin/env bash
#  _     _     _
# | |__ (_) __| | ___        __ _  __ _ _ __ ___   ___  ___
# | '_ \| |/ _` |/ _ \_____ / _` |/ _` | '_ ` _ \ / _ \/ __|
# | | | | | (_| |  __/_____| (_| | (_| | | | | | |  __/\__ \
# |_| |_|_|\__,_|\___|      \__, |\__,_|_| |_| |_|\___||___/
#                           |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Hide games from normal rofi so they only appear on rofi-games.
# -----------------------------------------------------------------------------------------------------------------------------------------

base_apps="$HOME/.local/share/applications"

find "$base_apps" -type f -print0 | while IFS= read -r -d '' file; do
    if (grep -q "Exec=steam" "$file") && (grep -q "Categories=Game" "$file") && (! grep -q "NoDisplay=true" "$file"); then
        echo "NoDisplay=true" >> $file
    fi
done

update-desktop-database ~/.local/share/applications/
