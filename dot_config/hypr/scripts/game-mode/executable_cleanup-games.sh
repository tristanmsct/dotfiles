#!/usr/bin/env bash
#       _
#   ___| | ___  __ _ _ __  _   _ _ __         __ _  __ _ _ __ ___   ___  ___
#  / __| |/ _ \/ _` | '_ \| | | | '_ \ _____ / _` |/ _` | '_ ` _ \ / _ \/ __|
# | (__| |  __/ (_| | | | | |_| | |_) |_____| (_| | (_| | | | | | |  __/\__ \
#  \___|_|\___|\__,_|_| |_|\__,_| .__/       \__, |\__,_|_| |_| |_|\___||___/
#                               |_|          |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Clean up game desktop file so they are launched properly.
# -----------------------------------------------------------------------------------------------------------------------------------------

base_apps="$HOME/.local/share/applications"

find "$base_apps" -type f -name "*.desktop" -print0 | while IFS= read -r -d '' file; do
    # Check if it's a game that launches with steam
    if grep -q "Exec=steam" "$file" && grep -q "Categories=.*Game" "$file"; then
        # Replace steam exec with our launch script
        sed -i "s|Exec=steam |Exec=steam.sh |g" "$file"

        # Add NoDisplay if not already present
        if ! grep -q "NoDisplay=true" "$file"; then
            # Add after [Desktop Entry] line
            sed -i '/^\[Desktop Entry\]/a NoDisplay=true' "$file"
        fi
    fi
done

update-desktop-database ~/.local/share/applications/
